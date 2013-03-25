WSTrack
=======

WSTrack (Workstation Tracking Project) contains client and server projects for tracking user workstation logins.

Documentation
-------------


  

Build Instructions
-------------
To build projects execute `mvn  -DskipTests clean install` from the repository root directory. 

That should create 2 files, a .war (the server code) located here `/wstrack/server/target/wstrack-server-{version}.war` and a .jar (the client code) located here `/wstrack/client/target/wstrack-client-{version}-jar-with-dependencies.jar`