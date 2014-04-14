WSTrack-Server
==============

Workstation Tracking (server)

Documentation
-------------

Build Instructions
-------------
To build project execute `mvn -DskipTests clean install` from the project root directory (~/wstrack). 

That will create 1 .war (the server code) located here `./target/wstrack-server-{version}.war`

##Execution

1. Navigate to ~/wstrack/server
2. Run grails run-app
3. Access http://localhost:8080/wstrack-server

From the home screen you may access different links. Each of the links  on the home screen are controlled with a controller class. 

###1. Current Controller

[Click here to access the link](http://localhost:8080/wstrack-server/current/list?max=10&sort=timestamp&order=desc)

The current controller displays the list of all the Computer names, their statuses and their locations. (Please note that for "this" page, at this time, there are no checks in place to filter out nonconforming names).

###2. History Controller
[Click here to access the link](http://localhost:8080/wstrack-server/history/list?max=10&sort=timestamp&order=desc)

This controller is used for auditing purposes and is used to check logins/logouts based on timestamps.

###3. Workstation Availability

The workstation availability controller caters to two functions:
#####a. Availability by location (Web interface)
[Click here to access the link](http://localhost:8080/wstrack-server/history/list?max=10&sort=timestamp&order=desc)

This function displays the number of PCs and MACs available at all the locations. The corresponding view used is [index.gsp](grails-app/views/availability/index.gsp)

#####b. Availability tracking using json/xml
[http://localhost:8080/wstrack-server/availability/list](http://localhost:8080/wstrack-server/availability/list)

This link is used to get the workstation availability information in the form of a JSON message. You can use the format parameter to specify the type of message required. The application supports JSON and XML currently with JSON being the default. 
[http://localhost:8080/wstrack-server/availability/list?format=json](http://localhost:8080/wstrack-server/availability/list?format=json) returns a JSON message and [http://localhost:8080/wstrack-server/availability/list?format=xml](http://localhost:8080/wstrack-server/availability/list?format=xml) returns an XML message.


##Bootstrap data (Local)
The random data generated in the local run is because of init() configurations made in the Bootstrap.groovy file.








