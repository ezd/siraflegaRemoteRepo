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
		<div class="container-fluid container-holder">
			<frm:form class="form-horizontal" commandName="user">
				<c:if test="${param.success eq false }">
					<c:choose>
						<c:when test="${param.message eq 'Exists'}">
							<div class="alert alert-danger">Email address is already in used <br>
							<a href="${pageContext.request.contextPath}/login">Login?</a>
							</div>
						</c:when>
						<c:when test="${param.message eq 'notsaved'}">
							<div class="alert alert-danger">Error!</div>
						</c:when>
					</c:choose>
				</c:if>
				<div class="form-group">
					<label class="col-sm-2 control-label"></label>
					<div class="col-sm-10">
						<h2>New User</h2>
					</div>
				</div>

				<div class="form-group">
					<label for="userName" class="col-sm-2 control-label">User
						Name:</label>
					<div class="col-sm-10">
						<frm:input path="userName" class="form-control"
							placeholder="User Name" />
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-2 control-label">Email:</label>
					<div class="col-sm-10">
						<frm:input path="email" class="form-control" placeholder="Email" />
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-sm-2 control-label">Password:</label>
					<div class="col-sm-10">
						<frm:password path="password" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label for="password2" class="col-sm-2 control-label">Re-enter
						password:</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="password2" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Registered as</label>
					<div class="col-sm-10 selectContainer">
						<select class="form-control selectpicker" name="type">
							<option value="">Select</option>
							<option value="employer">Employer</option>
							<option value="employee">Employee</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"> </label>
					<div class="col-sm-10">
						<input type="submit" class="btn btn-lg btn-primary"
							value="Register">
					</div>
				</div>
			</frm:form>

		</div>
	</div>
</body>
</html>