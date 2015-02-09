WSTrack
=======

WSTrack (Workstation Tracking Project) contains client and server projects for tracking user workstation logins.

Documentation
-------------


How to Install WSTrack on the Server
-------------

    # Stop the tomcat

    cd /apps/cms/tomcat-misc
    ./control stop

    cd /apps/cms/webapps
    mv wstrack wstrack-old.dir
    mv wstrack{.war,-war.old}

    wget "https://maven.lib.umd.edu/nexus/service/local/artifact/maven/content?r=releases&g=edu.umd.lib.wstrack.server&a=wstrack-server&v=LATEST&p=war" --content-disposition

    mv wstrack-*.war wstrack.war
    cd /apps/cms/tomcat-misc
    ./control start

    # Test

    rm -rf wstrack-old.dir

Build Instructions
-------------
To build projects execute `mvn  -DskipTests clean install` from the repository root directory. 

That will create 2 files, a .war (the server code) located here `/wstrack/server/target/wstrack-server-{version}.war` and a .jar (the client code) located here `/wstrack/client/target/wstrack-client-{version}-jar-with-dependencies.jar`

How to Test the App?
--------------------

* 1. Build the code using `mvn  -DskipTests clean install` from the repository root directory.
* 2. Navigate to ~/server/ and run "grails run-app"
* 3. Navigate to ~/client/script/ and execute ./wstrack-client.sh [login|logout] [local|DEV|Prod] 
    (This step should add a new row in the Current list.)

Note - While executing "./wstrack-client.sh [login|logout] [local|DEV|Prod]" , if you get an error "Unable to access jarfile /apps/git/wstrack/client/script/wstrack-client.jar"
Follow the following steps.

1. Navigate to ~/client/script and remove the wstrack-client.jar file. (rm -rf wstrack-client.jar)
2. Execute "ln -s ../target/wstrack-client-{VERSION}-jar-with-dependencies.jar wstrack-client.jar" (This will relink the jar file with the correct jar file.)
3. Restart the server. and rerun the ./wstrack-client.sh [login|logout] [local|DEV|Prod] command.
