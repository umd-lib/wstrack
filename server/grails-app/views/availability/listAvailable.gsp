<h1>This is the listAvailable gsp page</h1>

<table border="1">
<tr><th>Computer Name</th><th>Status</th><th>Location</th></tr>
<g:each in="${currentAvailableList}" var="current">
	<tr><td>${current.computerName}</td><td> ${current.status}</td><td> ${current.location}</td></tr>
</g:each>
</table>

<p><h4>Total Workstations available: ${currentAvailableCount }</h4>
<p><h4>Total Workstations : ${totalCount }</h4>

<table border="2">
<tr><th>Complete list of all the Workstations</th></tr>
<tr><th>Computer Name</th><th>Status</th><th>Location</th></tr>
<g:each in="${matchedAllCurrentList}" var="current1">
	<tr><td>${current1.computerName}</td><td> ${current1.status}</td><td> ${current1.location}</td></tr>
</g:each>
</table>