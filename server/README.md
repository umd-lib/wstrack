# WSTrack Server

A rails based implementation of the Workstation Tracking server.

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
    git clone git@github.com:umd-lib/wstrack.git
    cd wstrack/server
    ```

    Switching into the directory should trigger RVM to set up a gemset.

2) Copy the "env_example" file to ".env":

    ```bash
    > cp env_example .env
    ```

    Edit the '.env" file:

    ```bash
    > vi .env
    ```

    and set the HOST parameter:

    | Parameter              | Value                                |
    | ---------------------- | ------------------------------------ |
    | HOST                   | wstrack-local                        |

3) Run the following commands to setup the application:

    ```bash
    bundle config set without 'production'
    bundle install
    yarn
    rails db:reset
    rails server
    ```

4) The application will be available at <http://wstrack-local:3000/>

### Running the tests

To run the tests:

```bash
rails test:system test
```

### Code Style

The application uses [Rubocop](https://docs.rubocop.org/rubocop/1.25/index.html)
to enforce a coding standard. To run:

```bash
rubocop -D
```

## Rake Tasks

### Sample Data

#### Populate the database with sample data

```bash
> rails db:populate_sample_data
```

#### Drop, create, migrate, seed and populate sample data

```bash
> rails db:reset_with_sample_data
```
