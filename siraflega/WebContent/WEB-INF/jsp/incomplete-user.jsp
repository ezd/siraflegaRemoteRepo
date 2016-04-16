<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../defs/lib-file.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
	<br>
	<div class="col-md-8">
		<div class="container-fluid"
			style="background-color: #ECE9E6; margin: 10px 2px; padding: 5px; box-shadow: 1px 1px 2px grey;">
			<h2>Incomplete user information</h2>
			<div class="form-group">
				<div class="col-sm-2 control-label">User Name:</div>
				<div class="col-sm-10">${user.userName}</div>
			</div>
			<div class="form-group">
				<div class="col-sm-2 control-label">Email:</div>
				<div class="col-sm-10">${user.email}</div>
			</div>
			<security:authorize access="hasRole('ADMIN')">
				<div class="form-group">
					<div class="col-sm-2 control-label"></div>
					<div class="col-sm-10">
						<a
							href='<spring:url value="/users/sendReminder/${user.id}.html"/>'>Send
							a reminder</a>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-2 control-label"></div>
					<div class="col-sm-10">
						<p>${result}</p>
					</div>
				</div>
			</security:authorize>
		</div>
	</div>
</body>
</html>