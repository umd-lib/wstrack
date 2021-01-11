# WSTrack

WSTrack (Workstation Tracking Project) contains client and server projects for tracking user workstation logins.

## Documentation

### Docker Image Build

To build the Docker image.

```
    docker build . -t <IMAGE:TAG>
```

Push to registry

```
docker push <IMAGE:TAG>
```

### Build Instructions

Note: The server needs JDK 7, so build the project using JDK 7. But, when you run the client, you need to use JRE 8+ to avoid SSL handshake errors. If you just want to build the client, you can build it with JDK 8.

To build projects execute `mvn  -DskipTests clean install` from the repository root directory.

That will create 2 files, a .war (the server code) located here `/wstrack/server/target/wstrack-server-{version}.war` and a .jar (the client code) located here `/wstrack/client/target/wstrack-client-{version}-jar-with-dependencies.jar`

### Deploying the client to Nexus

To deploy the client package used by the workstations to Nexus:

```bash
cd client
mvn clean install
mvn deploy
```

### Testing the app

* 1. Build the code using `mvn  -DskipTests clean install` from the repository root directory.
* 2. Navigate to ~/server/ and run "grails run-app"
* 3. Navigate to ~/client/scripts/ and execute ./wstrack-client.sh [login|logout] [local|DEV|Prod]
    (This step should add a new row in the Current list.)

Note - While executing "./wstrack-client.sh [login|logout] [local|DEV|Prod]" , if you get an error "Unable to access jarfile /apps/git/wstrack/client/script/wstrack-client.jar"
Follow the following steps.

1. Navigate to ~/client/scripts and remove the wstrack-client.jar file. (rm -rf wstrack-client.jar)
2. Execute "ln -s ../target/wstrack-client-{VERSION}-jar-with-dependencies.jar wstrack-client.jar" (This will relink the jar file with the correct jar file.)
3. Restart the server. and rerun the ./wstrack-client.sh [login|logout] [local|DEV|Prod] command.

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (Apache 2.0).
