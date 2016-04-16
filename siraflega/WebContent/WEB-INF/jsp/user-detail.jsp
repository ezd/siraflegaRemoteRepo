<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../defs/lib-file.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../defs/lib-file.jsp"%>
<style type="text/css">
#userAccountInformation {
	/* border:1px solid red; */
	border-bottom: 1px solid rgba(53, 86, 129, 0.3);
}

#userAccountInformation p {
	/* padding-left: 5px; */
	padding: 0px 0px 0px 5px;
	margin: 0px;
}

#personalInformation {
	border-bottom: 1px solid rgba(53, 86, 129, 0.3);
}

p.title {
	border-bottom: 1px solid rgba(53, 86, 129, 0.3);
	font-weight: 600;
	font-size: 18px;
	font-family: monospace;
	margin-bottom: 10px;
	font-family: monospace;
}

#userAccountInformation .caption {
	font-weight: 600;
	font-family: monospace;
	/* 	float: left; */
	width: 100px;
	margin-bottom: 0px;
}

.lables {
	font-size: 16px;
}

#personalInformation input {
	margin-bottom: 5px;
}

#personalInformation label {
	margin-bottom: 0px;
	/* 	margin-left: 5px; */
}
/* #personalInformation div{ */
/* border: 1px solid red; */
/* } */
</style>
<script type="text/javascript">
	$(function() {
		$('#errorMsg').hide();
		$('.userInput').hide();
		$('.lables').show();
		$('#saveChangeBtn').hide();
		$('#cancelChangeBtn').hide();
		$('#editUserBtn').show();
		$('#userPassUpdateArea').hide();
		$('#changePassBtn').show();
		$('#editUserBtn').on('click', function() {
			$('#saveChangeBtn').show();
			$('#cancelChangeBtn').show();
			$('.userInput').show();
			$('.lables').hide();
			$('#editUserBtn').hide();
			$('#changePassBtn').hide();
		});
		$('#cancelChangeBtn').on('click', function() {
			$('#saveChangeBtn').hide();
			$('#cancelChangeBtn').hide();
			$('.userInput').hide();
			$('.lables').show();
			$('#editUserBtn').show();
			$('#changePassBtn').show();
		});
		$('#saveChangeBtn')
				.on(
						'click',
						function() {
							alert("user updated with:" + $('#userNameIn').val()
									+ "," + $('#userEmailIn').val())
							$
									.ajax({
										type : 'POST',
										url : 'updateUser',
										contentType : 'application/json',
										dataType : 'json',
										data : JSON
												.stringify({
													userName : $('#userNameIn')
															.val(),
													userEmail : $(
															'#userEmailIn')
															.val(),
												}),
										success : function(data) {
											alert("data values" + data.id + ","
													+ data.userName + ","
													+ data.email + ','
													+ data.isExists);
											if (data.isExists == 'exist') {
												$('#errorMsg')
														.html(
																'User name or email is already being used');
												$('#errorMsg').show().fadeOut(
														3000);

											} else {
												$('#errorMsg')
														.html(
																'The information is updated successfuly!!');
												$('#errorMsg').show().fadeOut(
														3000);
												$('#userIdIn').val(data.id);
												$('#userNameIn').val(
														data.userName);
												$('#userEmailIn').val(
														data.email);
												$('#userNameLb').html(
														data.userName);
												$('#userEmailLb').html(
														data.email);
											}
										},
										error : function(ts) {
											alert(ts.responseText);
										}
									});
							$('#saveChangeBtn').hide();
							$('#cancelChangeBtn').hide();
							$('.userInput').hide();
							$('.lables').show();
							$('#editUserBtn').show();
							$('#changePassBtn').show();
						});
		$('#changePassBtn').on('click', function() {
			$('#userInfoUpdateArea').hide();
			$('#userPassUpdateArea').show();
			$('#saveNewPass').show();
			$('#cancelPass').show();
		});
		$('#saveNewPass')
				.on(
						'click',
						function() {
							//userEmailLb

							alert("user updated withllll:"
									+ $('#userEmailLb').html() + ","
									+ $('#newPassword').val())
							$
									.ajax({
										type : 'POST',
										url : 'updatePassword',
										contentType : 'application/json',
										dataType : 'json',
										data : JSON.stringify({
											userEmail : $('#userEmailLb')
													.html(),
											userPassword : $('#newPassword')
													.val(),
										}),
										success : function(data) {
											if (data.redirect == 'true') {
												window.location
														.replace("${pageContext.request.contextPath}/userDetail");
											} else {
												// Process the expected results...
											}
										},
										error : function(ts) {
											alert(ts.responseText);
										}
									});
							$('#userInfoUpdateArea').show();
							$('#userPassUpdateArea').hide();
							$('#saveNewPass').hide();
							$('#cancelPass').hide();
						});
		$('#cancelPass').on('click', function() {
			$('#userInfoUpdateArea').show();
			$('#userPassUpdateArea').hide();
			$('#saveNewPass').hide();
			$('#cancelPass').hide();
		});
	});
</script>
</head>
<body>
	<br>
	<br>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<div id="userAccountInformation">
				<div id="userInfoUpdateArea">
					<div class="alert alert-danger" id="errorMsg"></div>
					<p class="title">
						<c:choose>
							<c:when test="${type eq 'employer' }">
								<c:out value="Employer user information" />
							</c:when>
							<c:when test="${type eq 'employee' }">
								<c:out value="Employee user information" />
							</c:when>
						</c:choose>
					</p>
					<input type="hidden" value="${user.id}" id="userIdIn" />
					<p>
						<span class="caption">User name:</span><span class="lables"
							id="userNameLb"> ${user.userName}</span><input
							class="form-control userInput" value="${user.userName}"
							id="userNameIn" />
					</p>
					<p>
						<span class="caption">User email:</span><span class="lables"
							id="userEmailLb"> ${user.email}</span><input
							class="form-control userInput" value="${user.email}"
							id="userEmailIn" />
					</p>

					<p>
						<button class="btn btn-link" id="editUserBtn">Edit user</button>
						<button class="btn btn-link" id="saveChangeBtn">Save
							Change</button>
						<button class="btn btn-link" id="cancelChangeBtn">cancel</button>
						<button class="btn btn-link" id="changePassBtn">Change
							password</button>
						<a class="btn btn-link" href="${pageContext.request.contextPath}/account">Bulid your Profile</a>
					</p>
				</div>
				<div id="userPassUpdateArea">
					<p>
						<span class="captionPass">New password:</span><input
							class="form-control" id="newPassword" />
					</p>
					<p>
						<span class="captionPass">Re-enter New password:</span><input
							class="form-control " id="reNewPassword" />
					</p>
					<p>
						<button class="btn btn-link" id="saveNewPass">Save Change</button>
						<button class="btn btn-link" id="cancelPass">Cancel</button>
					</p>

				</div>
			</div>
			<br>
			
<!-- 			<div id="personalInformation"> -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${type eq 'employer' }"> --%>
<!-- 						<div id="employerInfoBody"> -->
<!-- 							<p class="title"> -->
<%-- 								<c:out value="Employer personal information" /> --%>
<!-- 							</p> -->
<!-- 						</div> -->
<%-- 					</c:when> --%>
<%-- 					<c:when test="${type eq 'employee' }"> --%>
<!-- 						<div id="employerInfoBody"> -->
<!-- 							<p class="title"> -->
<%-- 								<c:out value="Employee personal information" /> --%>
<!-- 							</p> -->
<%-- 							<frm:form class="form-horizontal"  --%>
<%-- 							commandName="employee" --%>
<%-- 							action="${pageContext.request.contextPath}/saveEmployeePersonalInfo"> --%>
<%-- 																action="${pageContext.request.contextPath}/saveEmployeePersonalInfo"> --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${param.status eq 'success'}"> --%>
<!-- 										<div class="alert alert-success"> -->
<!-- 											Employee Information successfully saved<br> -->
<%-- 									</c:when> --%>
<%-- 									<c:when test="${param.status eq 'fail'}"> --%>
<!-- 										<div class="alert alert-danger">Employee Information not -->
<!-- 											saved!</div> -->
<%-- 									</c:when> --%>
<%-- 								</c:choose> --%>
<!-- 								<div class="form-group"> -->
<!-- 									<label class="col-sm-2 control-label">First Name:</label> -->
<!-- 									<div class="col-sm-10"> -->
<%-- 										<frm:input path="firstName" class="form-control" --%>
<%-- 											title="First Name" id="firstName" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label class="col-sm-2 control-label">Middle Name:</label> -->
<!-- 									<div class="col-sm-10"> -->
<%-- 										<frm:input path="middleName" class="form-control" --%>
<%-- 											title="Middle Name" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label class="col-sm-2 control-label">Last Name:</label> -->
<!-- 									<div class="col-sm-10"> -->
<%-- 										<frm:input path="lastName" class="form-control" --%>
<%-- 											title="Last Name" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label class="col-sm-2 control-label">Age:</label> -->
<!-- 									<div class="col-sm-10"> -->
<%-- 										<frm:input path="age" class="form-control" title="Age" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label for="sex" class="col-sm-3 control-label">Sex:</label> -->
<!-- 									<div class="col-sm-9">  -->
<%-- 										<frm:select path="sex" class="form-control" > --%>
<%-- 											<frm:option value="F">Female</frm:option> --%>
<%-- 											<frm:option value="M">Male</frm:option> --%>
<%-- 										</frm:select> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label class="col-sm-2 control-label">Email:</label> -->
<!-- 									<div class="col-sm-10"> -->
<%-- 										<frm:input path="" class="form-control" title="Email" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label class="col-sm-2 control-label">Telephone:</label> -->
<!-- 									<div class="col-sm-10"> -->
<%-- 										<frm:input path="telephone" class="form-control" --%>
<%-- 											title="Telephone" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label class="col-sm-2 control-label">Address:</label> -->
<!-- 									<div class="col-sm-10"> -->
<%-- 										<frm:input path="address" class="form-control" title="Address" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<div class="col-sm-offset-2 col-sm-10"> -->
<!-- 										<button type="submit" class="btn btn-default">Save -->
<!-- 											change</button> -->
<!-- 									</div> -->
<!-- 								</div> -->
<%-- 							</frm:form> --%>

<!-- 						</div> -->
<%-- 					</c:when> --%>
<%-- 				</c:choose> --%>
<!-- 			</div> -->
		</div>
	</div>
</body>
</html>