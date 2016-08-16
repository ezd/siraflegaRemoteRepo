<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../defs/lib-file.jsp"%>
<title><tiles:getAsString name="title" /></title>
<tilesx:useAttribute name="current" />
<!-- style for autocomplet -->
<!-- to style the autocomplet list -->
<style type="text/css">
.ui-autocomplete {
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	float: left;
	display: none;
	min-width: 160px;
	_width: 160px;
	padding: 4px 0;
	margin: 4px 0 0 0;
	list-style: none;
	background-color: #ffffff;
	border-color: #ccc;
	border-color: rgba(0, 0, 0, 0.2);
	border-style: solid;
	border-width: 1px;
	
}

.ui-menu-item:hover {
	/*     color: #777777; */
	border-radius: 0px; //
	border: 1px solid #777777;
	cursor: pointer;
	cursor: hand;
	font-weight: bold;
	background-color: rgba(245, 245, 245, 1);
}
/* to bring the autocomplet up front */
.ui-autocomplete {
	z-index: 5000;
}
</style>

<!-- cdn starts here -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.2/angular.min.js"></script>

<%-- 	src="${pageContext.request.contextPath}/resources/bootstrap.js"></script> --%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/js/bootstrap.min.js"></script>
<!-- date picker -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>

<script
	src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.8.1/css/bootstrap-select.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.8.1/js/bootstrap-select.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-formhelpers/2.3.0/css/bootstrap-formhelpers.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-formhelpers/2.3.0/js/bootstrap-formhelpers.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
<link
	rel="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.css">
<!-- <script src="https://twitter.github.io/typeahead.js/releases/latest/typeahead.bundle.js"></script> -->

<!-- cdn ends here -->

<!-- validation -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/additional-methods.min.js"></script>



<style type="text/css">
div.container-holder {
	margin: 10px 2px;
	padding: 5px;
}

.titile h2 {
	/* border:1px solid red; */
	margin: 1em 0 0.5em 0;
	font-weight: 600;
	font-family: 'Titillium Web', sans-serif;
	/* 	position: relative; */
	text-shadow: 0 -1px 1px rgba(0, 0, 0, 0.2);
	font-size: 28px;
	line-height: 39px;
	color: #355681;
	text-transform: capitalize;
	border-bottom: 1px solid rgba(53, 86, 129, 0.3);
}

.titile button {
	display: block;
	position: relative;
	float: right;
	border-radius: 0px;
}

.titleTwo {
	border-bottom: 1px solid rgba(53, 86, 129, 0.3);
	/* padding: 10px 0px 0px 0px; */
	margin-top: 30px;
}

.titleTwo button {
	border-radius: 0px;
	position: relative;
	float: right;
}

.titleTwo .titleTwoText {
	/* 	 border:1px solid red;  */
	/* 	float:left; */
	font-weight: 600;
	font-family: 'Titillium Web', sans-serif;
	/* 	position: relative; */
	text-shadow: 0 -1px 1px rgba(0, 0, 0, 0.2);
	font-size: 18px;
	line-height: 26px;
	color: #355681;
	text-transform: capitalize;
}

.titleThree button {
	border-radius: 0px;
	position: relative;
	float: right;
}

.titleThree .titleThreeText {
	font-weight: 600;
	font-family: 'Titillium Web', sans-serif;
	position: relative;
	font-size: 14px;
	line-height: 26px;
	color: #788699;
	font-family: 'Muli', sans-serif;
	/* 	border: 1px solid red; */
}

h5 {
	margin: 0px;
	font-weight: 500;
	font-family: 'Titillium Web', sans-serif;
	position: relative;
	font-size: 14px;
	line-height: 20px;
	color: #888888;
	font-family: 'Muli', sans-serif;
}

.dicorated {
	color: #4c4a37;
	font-family: 'Source Sans Pro', sans-serif;
	font-size: 18px;
	line-height: 32px;
	margin: 0 0 24px;
}

.descriptionText {
	font-family: sans-serif;
	font-size: 14px;
	text-align: justify;
	margin-bottom: 10px;
}
</style>
</head>

<body>

	<!-- Fixed navbar -->
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<spring:url value="/index.html" />">Sira</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="${current == 'home' ? 'active' : ''}"><a href="<spring:url value="/index.html" />">Home</a></li>
				<security:authorize access="hasRole('ADMIN')">
					<li class="${current == 'users' ? 'active' : ''}"><a
						href="<spring:url value="/users.html" />">Users</a></li>
				</security:authorize>
				<security:authorize
					access="hasAnyRole('ROLE_EMPLOYEE','ROLE_EMPLOYER')">
					<li class="${current == 'userDetail' ? 'active' : ''}"><a
						href="<spring:url value="/userDetail.html" />">My User Info</a></li>
					<li class="${current == 'account' ? 'active' : ''}"><a
						href="<spring:url value="/account.html" />">My Profile</a></li>
				</security:authorize>
				<security:authorize access="hasRole('EMPLOYER')">
					<li class="${current == 'employerPosts' ? 'active' : ''}"><a
						href="<spring:url value="/employerPosts/1.html" />">My Posts</a></li>
				</security:authorize>
				<security:authorize access="!isAuthenticated()">
					<li class="${current == 'register' ? 'active' : ''}"><a
<%-- 						href="<spring:url value="/register.html" />" --%>
							href="index.html"
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
			<ul class="nav navbar-nav navbar-right">
				<li></li>
				<!--             <li class="active"><a href="./">Fixed top <span class="sr-only">(current)</span></a></li> -->
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
	</nav>
	<br>
	<br>
	<div class="container">
		<div class="row" style="padding-top: 15px">
			<tiles:insertAttribute name="body" />
			<tiles:insertAttribute name="sideBar" />
		</div>
		<hr>
		<!-- Footer -->
		<footer> <tiles:insertAttribute name="footer" /> </footer>
	</div>
</body>
</html>