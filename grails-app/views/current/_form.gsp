<%@ page import="edu.umd.lib.wstrack.server.Current" %>



<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'ip', 'error')} required">
	<label for="ip">
		<g:message code="current.ip.label" default="Ip" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="ip" required="" value="${currentInstance?.ip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'guestFlag', 'error')} ">
	<label for="guestFlag">
		<g:message code="current.guestFlag.label" default="Guest Flag" />
		
	</label>
	<g:checkBox name="guestFlag" value="${currentInstance?.guestFlag}" />
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'hostName', 'error')} ">
	<label for="hostName">
		<g:message code="current.hostName.label" default="Host Name" />
		
	</label>
	<g:textField name="hostName" value="${currentInstance?.hostName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'os', 'error')} ">
	<label for="os">
		<g:message code="current.os.label" default="Os" />
		
	</label>
	<g:textField name="os" value="${currentInstance?.os}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="current.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${currentInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: currentInstance, field: 'userHash', 'error')} ">
	<label for="userHash">
		<g:message code="current.userHash.label" default="User Hash" />
		
	</label>
	<g:textField name="userHash" value="${currentInstance?.userHash}"/>
</div>

