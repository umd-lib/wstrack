<%@ page import="edu.umd.lib.wstrack.server.Current" %>



<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'computerName', 'error')} required">
	<label for="computerName">
		<g:message code="tracking.computerName.label" default="Computer Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="computerName" required="" value="${trackingInstance?.computerName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'guestFlag', 'error')} ">
	<label for="guestFlag">
		<g:message code="tracking.guestFlag.label" default="Guest Flag" />
		
	</label>
	<g:checkBox name="guestFlag" value="${trackingInstance?.guestFlag}" />
</div>

<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'os', 'error')} ">
	<label for="os">
		<g:message code="tracking.os.label" default="Os" />
		
	</label>
	<g:textField name="os" value="${trackingInstance?.os}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="tracking.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${trackingInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'userName', 'error')} ">
	<label for="userName">
		<g:message code="tracking.userName.label" default="User Name" />
		
	</label>
	<g:textField name="userName" value="${trackingInstance?.userName}"/>
</div>

