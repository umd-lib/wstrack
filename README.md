WSTrack
=======

WSTrack (Workstation Tracking Project) contains client and server projects for tracking user workstation logins.

Documentation
-------------


  

Build Instructions
-------------
To build projects execute `mvn  -DskipTests clean install` from the repository root directory. 

That will create 2 files, a .war (the server code) located here `/wstrack/server/target/wstrack-server-{version}.war` and a .jar (the client code) located here `/wstrack/client/target/wstrack-client-{version}-jar-with-dependencies.jar`

Run the client
--------------

* The script wstrack-client.sh runs the ClientTracking.java code.
* Step 1 - Build the code using `mvn  -DskipTests clean install` from the repository root directory.
* Step 2 - Navigate to ~/client/scripts/
* Step 3 - Execute ./wstrack-client.sh [login|logout] [local|DEV|Prod]
* Step 4 - Log on to the server and check the new entry
