
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
            <g:set var="c" value="${Current.counts() }" />
			<h1>Statistics - Current</h1>
                  <table>
                    <tbody>
                      <tr>
                        <th>OS</th>
                        <th>login (regular/guest)</th>
                        <th>logout (regular/guest)</th>
                        <th>Total (regular/guest)</th>
                      </tr>
                      <g:each in="${Current.listOs() }" status="i" var="os">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                          <td>${os}</td>
                          <td>${c[os]['login']['all'] } (${c[os]['login'][false] }/${c[os]['login'][true] })</td>
                          <td>${c[os]['logout']['all'] } (${c[os]['logout'][false] }/${c[os]['logout'][true] })</td>
                          <td>${c[os]['all']['all'] } (${c[os]['all'][false] }/${c[os]['all'][true] })</td>
                        </tr>
                      </g:each>
                      <tr class="${(Current.listOs().size() % 2) == 0 ? 'even' : 'odd' }">
                        <td>Total</td>
                        <td>${c['all']['login']['all'] } (${c['all']['login'][false] }/${c['all']['login'][true] })</td>
                        <td>${c['all']['logout']['all'] } (${c['all']['logout'][false] }/${c['all']['logout'][true] })</td>
                        <td>${c['all']['all']['all'] } (${c['all']['all'][false] }/${c['all']['all'][true] })</td>
                      </tr>
                    </tbody>
                  </table>
            <g:set var="c" value="${History.counts() }" />
			<h1>Statistics - History</h1>
                  <table>
                    <tbody>
                      <tr>
                        <th>OS</th>
                        <th>login (regular/guest)</th>
                        <th>logout (regular/guest)</th>
                        <th>Total (regular/guest)</th>
                      </tr>
                      <g:each in="${History.listOs() }" status="i" var="os">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                          <td>${os}</td>
                          <td>${c[os]['login']['all'] } (${c[os]['login'][false] }/${c[os]['login'][true] })</td>
                          <td>${c[os]['logout']['all'] } (${c[os]['logout'][false] }/${c[os]['logout'][true] })</td>
                          <td>${c[os]['all']['all'] } (${c[os]['all'][false] }/${c[os]['all'][true] })</td>
                        </tr>
                      </g:each>
                      <tr class="${(Current.listOs().size() % 2) == 0 ? 'even' : 'odd' }">
                        <td>Total</td>
                        <td>${c['all']['login']['all'] } (${c['all']['login'][false] }/${c['all']['login'][true] })</td>
                        <td>${c['all']['logout']['all'] } (${c['all']['logout'][false] }/${c['all']['logout'][true] })</td>
                        <td>${c['all']['all']['all'] } (${c['all']['all'][false] }/${c['all']['all'][true] })</td>
                      </tr>
                    </tbody>
                  </table>
      </div>
	</body>
</html>
