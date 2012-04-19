
<%@ page import="edu.umd.lib.wstrack.server.Current" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'current.label', default: 'Current')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-current" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-current" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="ip" title="${message(code: 'current.ip.label', default: 'Ip')}" />
					
						<g:sortableColumn property="guestFlag" title="${message(code: 'current.guestFlag.label', default: 'Guest Flag')}" />
					
						<g:sortableColumn property="hostName" title="${message(code: 'current.hostName.label', default: 'Host Name')}" />
					
						<g:sortableColumn property="os" title="${message(code: 'current.os.label', default: 'Os')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'current.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="timestamp" title="${message(code: 'current.timestamp.label', default: 'Timestamp')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${currentInstanceList}" status="i" var="currentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${currentInstance.id}">${fieldValue(bean: currentInstance, field: "ip")}</g:link></td>
					
						<td><g:formatBoolean boolean="${currentInstance.guestFlag}" /></td>
					
						<td>${fieldValue(bean: currentInstance, field: "hostName")}</td>
					
						<td>${fieldValue(bean: currentInstance, field: "os")}</td>
					
						<td>${fieldValue(bean: currentInstance, field: "status")}</td>
					
						<td><g:formatDate date="${currentInstance.timestamp}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${currentInstanceTotal}" />
			</div>
		</div>
	</body>
</html>