
<%@ page import="edu.umd.lib.wstrack.server.Current" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tracking.label', default: 'Tracking')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tracking" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tracking" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="computerName" title="${message(code: 'tracking.computerName.label', default: 'Computer Name')}" />
					
						<g:sortableColumn property="guestFlag" title="${message(code: 'tracking.guestFlag.label', default: 'Guest Flag')}" />
					
						<g:sortableColumn property="os" title="${message(code: 'tracking.os.label', default: 'Os')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'tracking.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="userName" title="${message(code: 'tracking.userName.label', default: 'User Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${trackingInstanceList}" status="i" var="trackingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${trackingInstance.id}">${fieldValue(bean: trackingInstance, field: "computerName")}</g:link></td>
					
						<td><g:formatBoolean boolean="${trackingInstance.guestFlag}" /></td>
					
						<td>${fieldValue(bean: trackingInstance, field: "os")}</td>
					
						<td>${fieldValue(bean: trackingInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: trackingInstance, field: "userName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${trackingInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
