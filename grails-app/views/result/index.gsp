<%@ page import="shiro_test.Result" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="noreen_kevin">
    <link rel="shortcut icon" href="${assetPath(src: 'butterfly_icon.gif')}" type="image/x-icon">

    <title>Results Index</title>

	<asset:stylesheet src="application.css"/>
	<asset:javascript src="application.js"/>
	
    <!-- Bootstrap core CSS -->
     <asset:stylesheet src="bootstrap.min.css"/>
    

    <!-- Custom styles for this template -->
     <asset:stylesheet src="jumbotron.css"/>

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
		<g:set var="entityName" value="${message(code: 'result.label', default: 'Result')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style='font-family:"Ubuntu-C";' >
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Papillon.this</a>
        </div>
        <div class="navbar-collapse collapse">
        
          <form class="navbar-form navbar-right" role="form" action="home/signin">
            <div class="form-group">
              <input name="username" type="text" placeholder="Username" class="form-control">
            </div>
            <div class="form-group">
              <input name="password" type="password" placeholder="Password" class="form-control">
            </div>
            <button type="submit" class="btn" style="background-color:#EBFAFA; color:#33CCCC;">Sign in</button>
          </form>
          
        </div><!--/.navbar-collapse -->
      </div>
    </div>
	
		<a href="#list-result" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation" style='font-family:"Ubuntu-C";'>
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-result" class="content scaffold-list" role="main" style='font-family:"Ubuntu-C";'>
			<h1 style="color: #33CCCC"><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="dateOfQuery" title="${message(code: 'result.dateOfQuery.label', default: 'Date Of Query')}" />
					
						<g:sortableColumn property="metric_1" title="${message(code: 'result.metric_1.label', default: 'Metric1')}" />
					
						<g:sortableColumn property="metric_2" title="${message(code: 'result.metric_2.label', default: 'Metric2')}" />
					
						<g:sortableColumn property="metric_3" title="${message(code: 'result.metric_3.label', default: 'Metric3')}" />
					
						<g:sortableColumn property="metric_4" title="${message(code: 'result.metric_4.label', default: 'Metric4')}" />
					
						<th><g:message code="result.servers.label" default="Servers" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${resultInstanceList}" status="i" var="resultInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${resultInstance.id}">${fieldValue(bean: resultInstance, field: "dateOfQuery")}</g:link></td>
					
						<td>${fieldValue(bean: resultInstance, field: "metric_1")}</td>
					
						<td>${fieldValue(bean: resultInstance, field: "metric_2")}</td>
					
						<td>${fieldValue(bean: resultInstance, field: "metric_3")}</td>
					
						<td>${fieldValue(bean: resultInstance, field: "metric_4")}</td>
					
						<td>${fieldValue(bean: resultInstance, field: "servers")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${resultInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
