
<%@ page import="edu.umd.lib.wstrack.server.History" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'history.label', default: 'History')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-history" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-history" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list history">
			
				<g:if test="${historyInstance?.computerName}">
				<li class="fieldcontain">
					<span id="computerName-label" class="property-label"><g:message code="history.computerName.label" default="Computer Name" /></span>
					
						<span class="property-value" aria-labelledby="computerName-label"><g:fieldValue bean="${historyInstance}" field="computerName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${historyInstance?.guestFlag}">
				<li class="fieldcontain">
					<span id="guestFlag-label" class="property-label"><g:message code="history.guestFlag.label" default="Guest Flag" /></span>
					
						<span class="property-value" aria-labelledby="guestFlag-label"><g:formatBoolean boolean="${historyInstance?.guestFlag}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${historyInstance?.os}">
				<li class="fieldcontain">
					<span id="os-label" class="property-label"><g:message code="history.os.label" default="Os" /></span>
					
						<span class="property-value" aria-labelledby="os-label"><g:fieldValue bean="${historyInstance}" field="os"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${historyInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="history.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${historyInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${historyInstance?.timestamp}">
				<li class="fieldcontain">
					<span id="timestamp-label" class="property-label"><g:message code="history.timestamp.label" default="Timestamp" /></span>
					
						<span class="property-value" aria-labelledby="timestamp-label"><g:formatDate date="${historyInstance?.timestamp}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${historyInstance?.userName}">
				<li class="fieldcontain">
					<span id="userName-label" class="property-label"><g:message code="history.userName.label" default="User Name" /></span>
					
						<span class="property-value" aria-labelledby="userName-label"><g:fieldValue bean="${historyInstance}" field="userName"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${historyInstance?.id}" />
					<g:link class="edit" action="edit" id="${historyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
