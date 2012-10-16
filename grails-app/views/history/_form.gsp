<%@ page import="edu.umd.lib.wstrack.server.History" %>



<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'computerName', 'error')} required">
	<label for="computerName">
		<g:message code="history.computerName.label" default="Computer Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="computerName" required="" value="${historyInstance?.computerName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'guestFlag', 'error')} ">
	<label for="guestFlag">
		<g:message code="history.guestFlag.label" default="Guest Flag" />
		
	</label>
	<g:checkBox name="guestFlag" value="${historyInstance?.guestFlag}" />
</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'os', 'error')} ">
	<label for="os">
		<g:message code="history.os.label" default="Os" />
		
	</label>
	<g:textField name="os" value="${historyInstance?.os}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="history.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${historyInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'timestamp', 'error')} required">
	<label for="timestamp">
		<g:message code="history.timestamp.label" default="Timestamp" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="timestamp" precision="day"  value="${historyInstance?.timestamp}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'userName', 'error')} ">
	<label for="userName">
		<g:message code="history.userName.label" default="User Name" />
		
	</label>
	<g:textField name="userName" value="${historyInstance?.userName}"/>
</div>

