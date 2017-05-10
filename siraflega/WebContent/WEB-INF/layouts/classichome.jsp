<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="gr__blackrockdigital_github_io">
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta name="description"
	content="Welcome to siraflega site. Search new jobs in ethiopia, post new jobs, hire employees, get up to date new jobs in ethiopia. Much more data than Ethiojobs, ezega and qefira websites.">
<meta name="keywords"
	content="ethiopia,job,jobs,employer,hire,employee,CV,new graduate,ethiopia">
<meta name="author" content="Siraflega by Code4fun">
<%@ include file="../defs/lib-file.jsp"%>
<title><tiles:getAsString name="title" /></title>
<tilesx:useAttribute name="current" />
<!-- style for jquery tab -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- cdn starts here -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css">


<link
	href="${pageContext.request.contextPath}/resources/vendor/font-awesome/css/font-awesome.css"
	rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>

<!-- Plugin CSS -->
<link
	href="${pageContext.request.contextPath}/resources/vendor/magnific-popup/magnific-popup.css"
	rel="stylesheet">

<!-- Theme CSS -->
<link
	href="${pageContext.request.contextPath}/resources/creative.min.css"
	rel="stylesheet">

</head>

<body id="page-top" data-gr-c-s-loaded="true">

	<!-- Fixed navbar -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<spring:url value="/index.html" />"><img
				width="100px" height="51px"
				src="${pageContext.request.contextPath}/resources/jobslogoopt.png"
				alt="Siraflega" /></a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="${current == 'home' ? 'active' : ''}"><a
					href="<spring:url value="/index.html" />">Home</a></li>
				<li class="${current == 'jobs' ? 'active' : ''}"><a
					href="<spring:url value="/jobs.html" />">Jobs</a></li>
				<security:authorize access="hasRole('ADMIN')">
					<li class="${current == 'users' ? 'active' : ''}"><a
						href="<spring:url value="/users.html" />">Users</a></li>
				</security:authorize>
				<security:authorize
					access="hasAnyRole('ROLE_EMPLOYEE','ROLE_EMPLOYER')">
					<li class="${current == 'userDetail' ? 'active' : ''}"><a
						href="<spring:url value="/userDetail.html" />">My Account</a></li>
					<li class="${current == 'account' ? 'active' : ''}"><a
						href="<spring:url value="/account.html" />">My Profile</a></li>
				</security:authorize>
				<security:authorize access="hasRole('EMPLOYER')">
					<li class="${current == 'employerPosts' ? 'active' : ''}"><a
						href="<spring:url value="/employerPosts/1.html" />">My Posts</a></li>
				</security:authorize>
				<security:authorize access="!isAuthenticated()">
					<li class="${current == 'register' ? 'active' : ''}"
						id="registerlink"><a
						href="<spring:url value="/register.html" />"
						<%--							href="index.html" --%>
						title="Coming soon">Register</a></li>

				</security:authorize>
				<security:authorize access="!isAuthenticated()">
					<li class="${current == 'login' ? 'active' : ''}"><a
						href="<spring:url value="/login.html" />">Login</a></li>
				</security:authorize>
				<security:authorize access="isAuthenticated()">
					<li><a href="<spring:url value="/logout" />">Logout</a></li>
				</security:authorize>
			</ul>
			<ul class="nav navbar-nav navbar-right" style="padding: 15px 30px;">
				<li>${timesvisited}times visited</li>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</nav>
	<br>
	<br>
		<tiles:insertAttribute name="body" />
		<hr>
		<!-- Footer -->
		<footer> <tiles:insertAttribute name="footer" /> </footer>

	<!-- Plugin JavaScript -->

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

	<script
		src="${pageContext.request.contextPath}/resources/vendor/scrollreveal/scrollreveal.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

	<!-- Theme JavaScript -->
	<script
		src="${pageContext.request.contextPath}/resources/js/creative.min.js"></script>




</body>

</html>
