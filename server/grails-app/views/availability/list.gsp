<h1>This is the listAvailable gsp page</h1>

<table border=2>
	<tr>
		<th>Location</th>
		<th>Workstations</th>
	</tr>
	<g:each in="${locVsCountFinalMap}" var="map">
		<tr>
			<td>
				${map.key}
			</td>
			<td><g:each in="${map.value}" var="ws">
					${ws.key}=${ws.value}<br>
				</g:each></td>

		</tr>


	</g:each>
</table>

<%-- THis is for listAll 
<table border=2>
<tr>
	<th >Location</th>
	<th colspan="5">Workstations</th>
	</tr>
	<tr><th></th><th colspan="3">name</th><th colspan="2">Status</th>
<g:each in="${locationVsCurrentFinal}" var="map">
	<tr>
		<td>
			${map.key}
		</td>
		<g:each in="${map.value}" var="ws">
				<td>${ws.computerName}</td><td>${ws.status}</td>
			</g:each>

	</tr>


</g:each>
</table>
		
		
--%>