
<%@ page import="edu.umd.lib.wstrack.server.Current" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'current.label', default: 'Current')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-current" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-current" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list current">
			
				<g:if test="${currentInstance?.ip}">
				<li class="fieldcontain">
					<span id="ip-label" class="property-label"><g:message code="current.ip.label" default="Ip" /></span>
					
						<span class="property-value" aria-labelledby="ip-label"><g:fieldValue bean="${currentInstance}" field="ip"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${currentInstance?.guestFlag}">
				<li class="fieldcontain">
					<span id="guestFlag-label" class="property-label"><g:message code="current.guestFlag.label" default="Guest Flag" /></span>
					
						<span class="property-value" aria-labelledby="guestFlag-label"><g:formatBoolean boolean="${currentInstance?.guestFlag}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${currentInstance?.hostName}">
				<li class="fieldcontain">
					<span id="hostName-label" class="property-label"><g:message code="current.hostName.label" default="Host Name" /></span>
					
						<span class="property-value" aria-labelledby="hostName-label"><g:fieldValue bean="${currentInstance}" field="hostName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${currentInstance?.os}">
				<li class="fieldcontain">
					<span id="os-label" class="property-label"><g:message code="current.os.label" default="Os" /></span>
					
						<span class="property-value" aria-labelledby="os-label"><g:fieldValue bean="${currentInstance}" field="os"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${currentInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="current.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${currentInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${currentInstance?.timestamp}">
				<li class="fieldcontain">
					<span id="timestamp-label" class="property-label"><g:message code="current.timestamp.label" default="Timestamp" /></span>
					
						<span class="property-value" aria-labelledby="timestamp-label"><g:formatDate date="${currentInstance?.timestamp}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${currentInstance?.userHash}">
				<li class="fieldcontain">
					<span id="userHash-label" class="property-label"><g:message code="current.userHash.label" default="User Hash" /></span>
					
						<span class="property-value" aria-labelledby="userHash-label"><g:fieldValue bean="${currentInstance}" field="userHash"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${currentInstance?.id}" />
					<g:link class="edit" action="edit" id="${currentInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
