<h1>This is the listAvailable gsp page</h1>

<table border="1">
<tr><th>Computer Name</th><th>Status</th><th>Location</th></tr>
<g:each in="${currentAvailableList}" var="current">
	<tr><td>${current.computerName}</td><td> ${current.status}</td></tr>
</g:each>
</table>

<p><h4>Total Workstations available: ${currentAvailableCount }</h4>
<p><h4>Total Workstations : ${totalCount }</h4>
