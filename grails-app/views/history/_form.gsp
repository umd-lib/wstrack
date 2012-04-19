<%@ page import="edu.umd.lib.wstrack.server.History" %>



<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'ip', 'error')} required">
	<label for="ip">
		<g:message code="history.ip.label" default="Ip" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="ip" required="" value="${historyInstance?.ip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'guestFlag', 'error')} ">
	<label for="guestFlag">
		<g:message code="history.guestFlag.label" default="Guest Flag" />
		
	</label>
	<g:checkBox name="guestFlag" value="${historyInstance?.guestFlag}" />
</div>

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'hostName', 'error')} ">
	<label for="hostName">
		<g:message code="history.hostName.label" default="Host Name" />
		
	</label>
	<g:textField name="hostName" value="${historyInstance?.hostName}"/>
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

<div class="fieldcontain ${hasErrors(bean: historyInstance, field: 'userHash', 'error')} ">
	<label for="userHash">
		<g:message code="history.userHash.label" default="User Hash" />
		
	</label>
	<g:textField name="userHash" value="${historyInstance?.userHash}"/>
</div>

