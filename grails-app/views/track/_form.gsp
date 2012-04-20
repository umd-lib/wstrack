<%@ page import="edu.umd.lib.wstrack.server.Current" %>



<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'ip', 'error')} required">
	<label for="ip">
		<g:message code="tracking.ip.label" default="Ip" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="ip" required="" value="${trackingInstance?.ip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'guestFlag', 'error')} ">
	<label for="guestFlag">
		<g:message code="tracking.guestFlag.label" default="Guest Flag" />
		
	</label>
	<g:checkBox name="guestFlag" value="${trackingInstance?.guestFlag}" />
</div>

<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'hostName', 'error')} ">
	<label for="hostName">
		<g:message code="tracking.hostName.label" default="Host Name" />
		
	</label>
	<g:textField name="hostName" value="${trackingInstance?.hostName}"/>
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

<div class="fieldcontain ${hasErrors(bean: trackingInstance, field: 'userHash', 'error')} ">
	<label for="userHash">
		<g:message code="tracking.userHash.label" default="User Hash" />
		
	</label>
	<g:textField name="userHash" value="${trackingInstance?.userHash}"/>
</div>

