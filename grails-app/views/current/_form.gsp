<%@ page import="edu.umd.lib.wstrack.server.Current" %>



<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'computerName', 'error')} required">
	<label for="computerName">
		<g:message code="current.computerName.label" default="Computer Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="computerName" required="" value="${currentInstance?.computerName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'status', 'error')} required">
	<label for="status">
		<g:message code="current.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="status" required="" value="${currentInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'os', 'error')} required">
	<label for="os">
		<g:message code="current.os.label" default="Os" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="os" required="" value="${currentInstance?.os}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'userHash', 'error')} required">
	<label for="userHash">
		<g:message code="current.userHash.label" default="User Hash" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="userHash" required="" value="${currentInstance?.userHash}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'guestFlag', 'error')} ">
	<label for="guestFlag">
		<g:message code="current.guestFlag.label" default="Guest Flag" />
		
	</label>
	<g:checkBox name="guestFlag" value="${currentInstance?.guestFlag}" />
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'timestamp', 'error')} required">
	<label for="timestamp">
		<g:message code="current.timestamp.label" default="Timestamp" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="timestamp" precision="day"  value="${currentInstance?.timestamp}"  />
</div>

