# WSTrack Server

A Rails-based implementation of the Workstation Tracking server.

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

## CSV History File Configuration

The application records workstation login/logout activity to a CSV file.
Activity is only recorded for new records (either generated through the
GUI, or from the API endpoint). Edits to existing records and deletions
are *not* recorded.

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

### Code Style

The application uses [Rubocop](https://docs.rubocop.org/rubocop/1.25/index.html)
to enforce a coding standard. To run:

```bash
$ rubocop -D
```

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

## Access Control

In order to access this application, the user must be a member of the following
Grouper group (<https://grouper.umd.edu/>):

* Application Roles/Libraries/WorkstationTracking/WorkstationTracking-Administrator
