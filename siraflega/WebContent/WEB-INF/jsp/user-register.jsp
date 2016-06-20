<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../defs/lib-file.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%-- 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.js"></script> --%>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>

<%-- 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script> --%>

<title>Insert title here</title>
</head>
<body>

	<br>
	<br>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<frm:form id="Register" class="form-horizontal" commandName="user">
				<c:if test="${param.success eq false }">
					<c:choose>
						<c:when test="${param.message eq 'Exists'}">
							<div class="alert alert-danger">
								Email address is already in used <br> <a
									href="${pageContext.request.contextPath}/login">Login?</a>
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
						<frm:input id="userName" path="userName" class="form-control"
							placeholder="User Name" name="userName" />
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-2 control-label">Email:</label>
					<div class="col-sm-10">
						<frm:input id="email" path="email" class="form-control"
							placeholder="Email" name="email" />
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-sm-2 control-label">Password:</label>
					<div class="col-sm-10">
						<frm:password id="password" path="password" class="form-control"
							name="password" />
					</div>
				</div>
				<div class="form-group">
					<label for="password2" class="col-sm-2 control-label">Re-enter
						password:</label>
					<div class="col-sm-10">
						<input id="password2" type="password" class="form-control"
							name="password2" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">Registered as</label>
					<div class="col-sm-10 selectContainer">
						<select id="type" class="form-control selectpicker" name="type">
							<option value="">Select</option>
							<option value="employer">Employer</option>
							<option value="employee">Employee</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"> </label>
					<div class="col-sm-10">
						<input id="button2" type="submit" class="btn btn-lg btn-primary"
							value="Register">
					</div>
				</div>
			</frm:form>

		</div>
	</div>

	<script type="text/javascript">
		// 		$.validator.setDefaults( {
		// 			submitHandler: function () {
		// 				alert( "submitted!" );
		// 			}
		// 		} );

		$(document)
				.ready(
						function() {

							// validate signup form on keyup and submit
							/*
							 $("#button2").click(function(){
							 alert($("#button2").val());
							 });
							 })
							 */
		$("#Register").validate(
				{
					rules : {
						userName : {
							required : true,
							minlength : 2
						},
	 				email: {
	 					required: true,
	 					email: true
	 					},
	 				password: {
	 					required: true,
	 					minlength: 6
	 					},
	 				password2:{
	 					required: true,
	 					minlength: 6,
	 					equalTo: "#password"
	 					},
	 					type:{
	 						required:true,
	 					},
					},
					messages : {
						userName : {
							required : "Please enter a user name",
							minlength : "Your username must consist of at lease 2 characters"
						},
						email : {
							required : "Please enter your email",
							email : "enter valid email"
						},
						password : {
							required : "Please provide a password",
							minlength : "Your password must be at lease 6 characters long"
						},
						password2 : {
							required : "Please provide a password",
							minlength : "Your password must be at least 6 characters long",
							equalTo : "Please enter the same password as above"
						},
						type: {
						      required: "Please select an option from the list",
						     },
					}
				});
	})
	</script>

</body>
</html>