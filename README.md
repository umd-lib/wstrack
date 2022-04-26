# WSTrack

WSTrack (Workstation Tracking Project) contains client and server applications
for tracking user workstation logins and logouts.

## Quick Start

### Prerequisites

The following are needed to build and run the "wstrack" client and server
applications on a local workstation:

* Java 8
* Apache Maven 3.8.1 or later
* Ruby 2.7.5

See the [client/README.md](client/README.md) and
[server/README.md](server/README.md) files for more information.

Also, due to the use of CAS for authentication, edit the "/etc/hosts" file:

```bash
$ sudo vi /etc/hosts
```

and add the following line:

```text
127.0.0.1       wstrack-local
```

### Build the "server" application

In a terminal (the "server" terminal), do the following, starting in the
project root directory.

1) Edit the "/etc/hosts" file on the local workstation:

    ```bash
    $ sudo vi /etc/hosts
    ```

    and add the following line:

    ```text
    127.0.0.1       wstrack-local
    ```

    This is needed to support CAS authentication, and only needs to be done
    once.

2) Switch into the "server" directory:

    ```bash
    $ cd server
    ```

3) Copy the "env_example" file to ".env":

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

4) Run the following commands to set up the Rails application
(with sample data):

    ```bash
    $ bundle config set without 'production'
    $ bundle install
    $ yarn
    $ rails db:reset_with_sample_data
    ```

5) Run the server:

    ```bash
    $ rails server
    ```

6) In a web browser, go to

    <http://wstrack-local:3000/>

    the application home page should be displayed.

### Build the "client" application

In a second terminal (the "client" terminal), do the following, starting in the
project root directory.

1) Build the client Jar file:

    ```bash
    $ cd client
    $ mvn clean install
    ```

    This will create a Jar file in
    "/wstrack/client/target/wstrack-client-{VERSION}-jar-with-dependencies.jar"
    where {VERSION} is the current version (from the pom.xml file).

2) Set up the symbolic link in the "script" directory

    ```bash
    $ cd script
    $ rm -rf wstrack-client.jar
    $ ln -s ../target/wstrack-client-{VERSION}-jar-with-dependencies.jar wstrack-client.jar
    ```

    where {VERSION} is the current version (from the pom.xml file).

3) To trigger an update on the server, run the following:

    ```bash
    $ ./wstrack-client.sh login local true
    ```

    See the [client/README.md](client/README.md) for more information about the
    "wstrack-client.sh" script.

    The update should be displayed in
    <http://wstrack-local:3000/workstation_statuses>

    **Note:** The "Location" and "Type" fields will not be populated, because
    the local workstation name does not have the expected format for generating
    these entries.

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations
(Apache 2.0).
