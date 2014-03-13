<h1>This is the listAvailable gsp page</h1>

<table border=2>
	<tr>
		<th>Location</th>
		<th>Workstations</th>
	</tr>
	<g:each in="${locationVsCountsMap}" var="map">
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