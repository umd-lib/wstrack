# WSTrack Server

A Rails-based implementation of the Workstation Tracking server.

## Access Control

In order to login to this application, the user must be a member of the
following Grouper group (<https://grouper.umd.edu/>):

* Application Roles/Libraries/WorkstationTracking/WorkstationTracking-Administrator

The following endpoints do not require a login:

* /ping - Used by Kubernetes for application health checks
* /track - Used by the "wstrack" clients to update workstation status
* /availability - Used to report workstation availability, by location

## Development Setup

### Prerequisites

The following instructions assume RVM (<https://rvm.io/>) is installed, to
enable the setup of an isolated Ruby environment.

To run locally, the following must be installed:

* Ruby v2.7.5
* Bundler v2.1.4
* sqlite3
* node v8.16.1 or later
* yarn v1.22.0 or later
* Edit the "/etc/hosts" file and add

    ```bash
    127.0.0.1 wstrack-local
    ```

#### Running with rbenv

If you use rbenv (<https://github.com/rbenv/rbenv>) instead of RVM for Ruby
version management, you will need to symlink your rbenv install of Ruby 2.7.5
to `ruby-2.7.5`:

```bash
cd "$(rbenv root)/versions"
ln -s 2.7.5 ruby-2.7.5
```

### Installation for development

1) Clone the Git repository and switch to the directory:

    ```bash
    $ git clone git@github.com:umd-lib/wstrack.git
    $ cd wstrack/server
    ```

    Switching into the directory should trigger RVM to set up a gemset.

2) Copy the "env_example" file to ".env":

    ```bash
    $ cp env_example .env
    ```

   Determine the values for the "SAML_SP_PRIVATE_KEY" and "SAML_SP_CERTIFICATE"
   variables:

   ```bash
   > kubectl -n test get secret wstrack-common-env-secret -o jsonpath='{.data.SAML_SP_PRIVATE_KEY}' | base64 --decode
   > kubectl -n test get secret wstrack-common-env-secret -o jsonpath='{.data.SAML_SP_CERTIFICATE}' | base64 --decode
   ```

   **Note:** These values are also available from the "test/sp.crt" and
   "test/sp.key" files in the "wstrack-saml.zip" file in the
   "SSDR/Developer Resources/DIT SAML Configurations/" directory on Box.

   Edit the '.env" file:

   ```bash
   > vi .env
   ```

   and set the parameters:

   | Parameter              | Value                                |
   | ---------------------- | ------------------------------------ |
   | HOST                   | wstrack-local                        |
   | SAML_SP_PRIVATE_KEY    | (Output from first kubectl command)  |
   | SAML_SP_CERTIFICATE    | (Output from second kubectl command) |

3) Because this application is currently built with an older Ruby (2.7.5), you
   will need to use OpenSSL 1.1 when building the puma native extensions. Before
   running `bundle install`, you should install OpenSSL 1.1 and configure the shell
   environment to use it:

   ```zsh
   brew install openssl@1.1

   export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
   export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
   export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"
   ```

3) Run the following commands to setup the application:

    ```bash
    $ bundle config set without 'production'
    $ bundle install
    $ yarn
    $ rails db:reset
    $ rails server
    ```

4) The application will be available at <http://wstrack-local:3000/>

### Running the tests

To run the tests:

```bash
$ rails test:system test
```

### Code Style

The application uses [Rubocop](https://docs.rubocop.org/rubocop/1.25/index.html)
to enforce a coding standard. To run:

```bash
$ rubocop -D
```

## Server Functionality

This application provides the following functionality:

* a "/track" endpoint used by the "wstrack" client application to report
  workstation logins and logouts.

* Workstation Statuses - displays the workstations currently known by
  the application (via clients accessing the "/track" endpoint)

* Availability - displays workstation availability by physical location
  in HTML, JSON, and XML formats.

* Locations - a editable list of regular expressions mapping workstation names
  to physical locations.

The application also generates CSV files of the workstation logins and logouts
history for analysis.

## Client "/track" Endpoint

The "/track" endpoint accepts an HTTP GET request, using a URL of the following
format:

```text
<APPLICATION_BASE_URL>/track/<WORKSTATION_NAME>/<STATUS>/<OS>/<GUEST_FLAG>/<USER_HASH>
```

where:

* \<APPLICATION_BASE_URL> - The base URL for the server
* \<WORKSTATION_NAME> - The name of the workstation (expected, but not required,
  to conform to one  of the "Locations" regular expressions)
* \<STATUS> - Accepted values: "login" or "logout"
* \<OS> - The operating system description
* \<GUEST_FLAG> - Accepted values: "t" (true) or "f" (false)
* \<USER_HASH> - The hashcode for the user

## CSV History File Configuration

The application records workstation login/logout activity to a CSV file.
Only activity on the "wstrack_client" endpoint ("/track") is recorded.
New records, edits, or deletions through the GUI are *not* recorded.

Activity for each day is recorded in files named for that day (the filename
format is "YYYY-MM-DD.csv").

The directory that the CSV files are written to is configured via the
"config.x.history.storage_dir" parameter in "config/application.rb". The
value for this parameter can be set via a "HISTORY_STORAGE_DIR" environment
variable, otherwise it defaults to the "tmp" subdirectory in the project root.
The directory will be created, if it does not exist.

The application has been configured (via the
"config.time_zone" parameter in "config/application.rb") to use the
"Eastern Time (US & Canada)" timezone, to ensure that files are rolled over
at EST/EDT midnight.

The CSV file contains a "timestamp" field that reflects the "EST/EDT" timezone.

## Rake Tasks

### Sample Data

#### Populate the database with sample data

```bash
$ rails db:populate_sample_data
```

#### Drop, create, migrate, seed and populate sample data

```bash
$ rails db:reset_with_sample_data
```

### Grails Migration Tasks

The following tasks are intended to support the migration of data from the
Grails "wstrack" application. These tasks can be removed once the Grails
"wstrack" application has been retired.

#### Clear the WorkstationStatus table

Clears the "WorkstationStatus" table, prior to importing data from the CSV file
from the Grails "wstrack" application.

```bash
$ rails db:clear_current_workstation_status
```

#### Import Grails "Current" Workstation Status CSV file

Populates the "WorkstationStatus" table with a CSV file generated from the
"Current" entries in the Grails "wstrack" application.

```bash
$ rails db:import_current_workstation_status['<CSV_FILE>']
```

where \<CSV_FILE> is the full path to the CSV file. For example, if the CSV
file is located at "/tmp/grails_wstrack_current.csv", the command would beL

```bash
$ rails db:import_current_workstation_status['/tmp/grails_wstrack_current.csv']
```

To generate the CSV from the Grails "wstrack" application:

1) Switch to the approriate Kubernetes namespace:

    ```bash
    $ kubectl config use-context <K8S_NAMESPACE>
    ```

    where \<K8S_NAMESPACE> is the Kubernetes namespace. For example, for the "test"
    namespace", the command would be:

    ```bash
    $ kubectl config use-context test
    ```

2) Run the following command to output a CSV file to the
   "/tmp/grails_wstrack_current.csv" file in the "wstrack-app-0" pod:

    ```bash
    $ kubectl exec wstrack-db-0 -- psql --username wstrack --dbname wstrack -c \
      "COPY (SELECT * FROM current ORDER BY id ASC) TO '/tmp/grails_wstrack_current.csv' WITH (FORMAT CSV, HEADER)"
    ```

3) Copy the "/tmp/grails_wstrack_current.csv" file to
   "/tmp/grails_wstrack_current.csv" on the local workstation

    ```bash
    $ kubectl cp wstrack-db-0:/tmp/grails_wstrack_current.csv /tmp/grails_wstrack_current.csv
    ```
