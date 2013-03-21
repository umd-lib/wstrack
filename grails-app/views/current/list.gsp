
<%@ page import="edu.umd.lib.wstrack.server.Current" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'current.label', default: 'Current')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
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
					
						<g:sortableColumn property="computerName" title="${message(code: 'current.computerName.label', default: 'Computer Name')}" params="${filterParams}"/>
					
						<g:sortableColumn property="status" title="${message(code: 'current.status.label', default: 'Status')}" params="${filterParams}"/>
					
						<g:sortableColumn property="os" title="${message(code: 'current.os.label', default: 'Os')}" params="${filterParams}"/>
					
						<g:sortableColumn property="userHash" title="${message(code: 'current.userHash.label', default: 'User Hash')}" params="${filterParams}"/>
					
						<g:sortableColumn property="guestFlag" title="${message(code: 'current.guestFlag.label', default: 'Guest Flag')}" params="${filterParams}"/>
					
						<g:sortableColumn property="timestamp" title="${message(code: 'current.timestamp.label', default: 'Timestamp')}" params="${filterParams}"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${currentInstanceList}" status="i" var="currentInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${currentInstance.id}">${fieldValue(bean: currentInstance, field: "computerName")}</g:link></td>
					
						<td>${fieldValue(bean: currentInstance, field: "status")}</td>
					
						<td>${fieldValue(bean: currentInstance, field: "os")}</td>
					
						<td>${fieldValue(bean: currentInstance, field: "userHash")}</td>
					
						<td><g:formatBoolean boolean="${currentInstance.guestFlag}" /></td>
					
						<td><g:formatDate date="${currentInstance.timestamp}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
			 	<filterpane:filterButton text="Filter" />
                &#x7c;
				<g:paginate total="${currentInstanceTotal}" params="${filterParams}" />
                &#x7c;
                <g:link elementId="deleteRecords" controller="current" action="filteredDelete" params="${filterParams}">Delete Entries</g:link>
                &#x7c;
                <span id="totalEntries" title="${currentInstanceTotal}">Entries: ${currentInstanceTotal}</span>
			</div>
		</div>
		<filterpane:filterPane domain="edu.umd.lib.wstrack.server.History" />
		<div id="dialog-confirm" title="Delete These Records?">
			<p>
				<span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>
				<span>These records will be permanently deleted and cannot be recovered. Are you sure?</span>
			</p>
		</div>
</body>
</html>
