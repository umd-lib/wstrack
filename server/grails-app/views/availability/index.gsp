<%@ page import="edu.umd.lib.wstrack.server.Current" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Availability by Location</title>
		<link href="../css/smoothness/jquery-ui-1.10.1.custom.css" type="text/css" rel="stylesheet" media="screen, projection" />
		<g:javascript src="jquery-1.9.1.js" />
		<g:javascript src="jquery-ui-1.10.1.custom.js" />
		<g:javascript src="jquery-migrate-1.0.0.js" />
		<g:javascript src="current.js" />
		<style type="text/css">	
			#dialog-confirm {
				display: none;
				overflow : hidden;
			}
			.ui-dialog {
				font-size : .8em;
			}
		</style>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="list-current" class="content scaffold-list" role="main">
			<h1>Availability by location</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
						<th>Location</th>
					
						<th>PC (Available/Total)</th>
					
						<th>MAC (Available/Total)</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in = "${locVsCountFinalMap}" status="j" var="locVsCount">
					<g:each in="${locVsCount.value}" var="map">
							<tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
								<td>${locVsCount.key}</td>
								<td>${map.value['pc']['available'] }/${map.value['pc']['total'] }</td>
								<td>${map.value['mac']['available'] }/${map.value['mac']['total'] }</td>
							</tr>
					</g:each>
				</g:each>
				</tbody>
			</table>
		</div>
</body>
</html>
