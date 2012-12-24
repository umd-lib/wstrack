
<%@ page import="edu.umd.lib.wstrack.server.Current" %>
<%@ page import="edu.umd.lib.wstrack.server.History" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'current.label', default: 'Current')}" />
		<title>Statistics</title>
	</head>
	<body>
		<a href="#list-current" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="list-current" class="content scaffold-list" role="main">
			<h1>Statistics - Current</h1>
                  <table>
                    <tbody>
                      <tr>
                        <th>OS</th>
                        <th>login</th>
                        <th>logout</th>
                        <th>Total</th>
                      </tr>
                      <g:each in="${Current.listOs() }" status="i" var="os">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                          <td>${os}</td>
                          <td>${Current.countByOsAndStatus(os, "login") }</td>
                          <td>${Current.countByOsAndStatus(os, "logout") }</td>
                          <td>${Current.countByOs(os)}</td>
                        </tr>
                      </g:each>
                      <tr>
                        <td>Total</td>
                        <td>${Current.countByStatus("login") }</td>
                        <td>${Current.countByStatus("logout") }</td>
                        <td>${Current.count() }</td>
                      </tr>
                    </tbody>
                  </table>
                <h1>Statistics - History</h1>
                  <table>
                    <tbody>
                      <tr>
                        <th>OS</th>
                        <th>login</th>
                        <th>logout</th>
                        <th>Total</th>
                      </tr>
                      <g:each in="${History.listOs() }" status="i" var="os">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                          <td>${os}</td>
                          <td>${History.countByOsAndStatus(os, "login") }</td>
                          <td>${History.countByOsAndStatus(os, "logout") }</td>
                          <td>${History.countByOs(os)}</td>
                        </tr>
                      </g:each>
                      <tr>
                        <td>Total</td>
                        <td>${History.countByStatus("login") }</td>
                        <td>${History.countByStatus("logout") }</td>
                        <td>${History.count() }</td>
                      </tr>
                    </tbody>
                  </table>
      </div>
	</body>
</html>
