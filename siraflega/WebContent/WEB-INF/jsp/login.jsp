<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body {
	padding-top: 40px;
	padding-bottom: 40px;
	background-color: #eee;
}

.form-signin {
	max-width: 330px;
	padding: 15px;
	margin: 0 auto;
}

.form-signin .form-signin-heading, .form-signin .checkbox {
	margin-bottom: 10px;
}

.form-signin .checkbox {
	font-weight: normal;
}

.form-signin .form-control {
	position: relative;
	height: auto;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	padding: 10px;
	font-size: 16px;
}

.form-signin .form-control:focus {
	z-index: 2;
}

.form-signin input[type="email"] {
	margin-bottom: -1px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
	margin-bottom: 10px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}
</style>
<%@ include file="../defs/lib-file.jsp" %>
<title>Insert title here</title>
</head>
<c:url value="/login" var="loginUrl"/>

<body>
	<div class="col-md-8">
		<div class="container-fluid"
			style="background-color: #ECE9E6; margin: 10px 2px; padding: 5px; box-shadow: 1px 1px 2px grey; min-height: 500px">
			<form class="form-signin" action="${loginUrl}" method="post"> 
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<h2 class="form-signin-heading">Please sign in</h2>
				<input type="text" name="username" class="form-control" placeholder="User name" required autofocus> 
				<input type="password" name="password" class="form-control" placeholder="Password"  required>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
			</form>
		</div>
	</div>
</body>
</html>