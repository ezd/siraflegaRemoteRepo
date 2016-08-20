<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="../defs/lib-file.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../defs/lib-file.jsp"%>

	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/additional-methods.min.js"></script>


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
		$('#passwordChangeRequest').show();//passwordChangeRequest passwordChangeAction
		$('#passwordChangeAction').hide();
		$('#editUserBtn').on('click', function() {
			$('#saveChangeBtn').show();
			$('#cancelChangeBtn').show();
			$('.userInput').show();
			$('.lables').hide();
			$('#editUserBtn').hide();
		});
		$('#passwordChangeRequest').on('click', function(){
			$('#passwordChangeRequest').hide();
			$('#passwordChangeAction').show();
			$('#passwordChangeRequest').hide();
			
		});
		$('#cancelChangeBtn').on('click', function() {
			$('#saveChangeBtn').hide();
			$('#cancelChangeBtn').hide();
			$('.userInput').hide();
			$('.lables').show();
			$('#editUserBtn').show();
		});

		$('#changePassBtn').on('click', function() {
			$('#userInfoUpdateArea').hide();
			$('#userPassUpdateArea').show();
			$('#saveNewPass').show();
			$('#cancelPass').show();
		});
		
		$('#cancelPass').on('click', function() {
			$('#userInfoUpdateArea').show();
			$('#userPassUpdateArea').hide();
			$('#saveNewPass').hide();
			$('#cancelPass').hide();
		});
		
// 		$("#passUpdateAreaForm").validate({
// 			onfocusout: function(e) {
// 	              this.element(e);
// 	          },
// 				rules : {
// 					newPassword: {
// 						required: true,
// 						minlength: 5
// 						},
// 					reNewPassword: {
// 						required: true,
// 						minlength: 5,
// 						equalTo: "#newPassword"
// 						},
					
// 					},
// 					messages : {
// 					newPassword: {
// 						required: "Please provide a password",
// 						minlength: "Your password must be at least 5 characters long"
// 						},
// 					reNewPassword: {
// 						required: "Please provide a password",
// 						minlength: "Your password must be at least 5 characters long",
// 						equalTo: "Please enter the same password as above"
// 						}
// 					},
					
// 			submitHandler:function(){
// 				$('#saveNewPass').on('click',function() {
// 					alert("user updated withllll:" + $('#userEmailLb').html() + "," + $('#newPassword').val());
// 					$.ajax({
// 						type : 'POST',
// 						url : 'updatePassword',
// 						contentType : 'application/json',
// 						dataType : 'json',
// 						data : JSON.stringify({
// 							userEmail : $('#userEmailLb').html(),
// 							userPassword : $('#newPassword').val(),
// 							userOldPassword:$('#oldPassword').val(),
// 						}),
// 						success : function(data) {
// 							if (data.redirect == 'true') {
// 								window.location.replace("${pageContext.request.contextPath}/userDetail");
// 							} else {
// 								// Process the expected results...
// 							}
// 						},
// 						error : function(ts) {
// 							alert(ts.responseText);
// 						}
// 							});
// 					$('#userInfoUpdateArea').show();
// 					$('#userPassUpdateArea').hide();
// 					$('#saveNewPass').hide();
// 					$('#cancelPass').hide();
// 						});
// 			}
// 		});


		$("#userInfoUpdateAreaForm").validate({
					
			onfocusout: function(e) {
	              this.element(e);
	          },
		
				rules : {
					userNameIn : {
						required : true,
						minlength : 2,
						lettersonly:true
						},
					userEmailIn : {
						required: true,
						email: true
						},	
					oldPassword: {
						required: true,
						minlength: 5
						},
					newPassword: {
						required: true,
						minlength: 5
						},
					reNewPassword: {
						required: true,
						minlength: 5,
						equalTo: "#newPassword"
						}
					},
					
				messages : {
					userNameIn : {
						required : "Please enter your first name",
						minlength : "User name shoud be more than 2 characters",
						},
					userEmailIn : {
						email: "Email is required",
						agree: "Enter valid email"
						},
					oldPassword: {
						required: "Enter old password",
						minlength: "Your password must be at least 5 characters long"
						},
					newPassword: {
						required: "Please provide a password",
						minlength: "Your password must be at least 5 characters long"
						},
					reNewPassword: {
						required: "Please provide a password",
						minlength: "Your password must be at least 5 characters long",
						equalTo: "Please enter the same password as above"
						}
					},
	submitHandler:function(){
		$('#saveChangeBtn').on('click',function() {
				$.ajax({
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
										userOldPassword : $(
												'#oldPassword')
												.val(),
										userNewPassword : $(
												'#newPassword')
												.val()
									}),
							success : function(data) {
								if (data.isExists == 'exist') {
									$('#errorMsg').html('User name or email is already being used');
									$('#errorMsg').show().fadeOut(3000);
						
								} else if (data.isPassCorrect == 'notCorrect'){
									//return jsonObject.put("isExists", "exist").toString();
									$('#errorMsg').html('This old password does not exist');
									$('#errorMsg').show().fadeOut(3000);
								}
								else {
									if (data.redirect == 'true') {
		 								window.location.replace("${pageContext.request.contextPath}/userDetail");
		 								}
									$('#errorMsg') .html( 'The information is updated successfuly!!');
									$('#errorMsg').show().fadeOut( 3000);
									$('#userIdIn').val(data.id);
									$('#userNameIn').val( data.userName);
									$('#userEmailIn').val( data.email);
									$('#userNameLb').html( data.userName);
									$('#userEmailLb').html( data.email);
								}
							},
							error : function(ts) {
								//alert(ts.responseText);
							}
						});
				$('#saveChangeBtn').hide();
				$('#cancelChangeBtn').hide();
				$('.userInput').hide();
				$('.lables').show();
				$('#editUserBtn').show();
			});
		} 
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
				<form id="userInfoUpdateAreaForm">
				
<!-- 				<div id="userInfoUpdateArea"> -->
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
						<span class="caption">User name:</span>
						<span class="lables" id="userNameLb"> ${user.userName}</span>
						<input class="form-control userInput" value="${user.userName}" id="userNameIn"  name="userNameIn" />
					</p>
					<p>
						<span class="caption">User email:</span>
						<span class="lables" id="userEmailLb"> ${user.email}</span>
						<input class="form-control userInput" value="${user.email}" id="userEmailIn" name="userEmailIn"/>
					</p>

					<p>
						<span class="captionPass">Old password:</span>
						<span class="lables" id="userPassLb">******</span>
						<input class="form-control userInput" id="oldPassword" name="oldPassword"/>
					</p>
					<div id="passwordChangeRequest">
						<p>
							<button type="button" id="passwordChange_btn" class="userInput btn btn-link" >Change your password?</button>
						</p>
						
					</div>
					
					<div id="passwordChangeAction">
						<p>
						<span class="userInput">New password:</span>
						<input class="form-control userInput" id="newPassword" name="newPassword"/>
						</p>
					<p>
						<span class="userInput">Re-enter New password:</span>
						<input class="form-control userInput" id="reNewPassword" name="reNewPassword"/>
					</p>
					</div>

					<p>	
						<input type="button" class="btn btn-link" id="editUserBtn" value="Edit user" />
						<input type="submit" class="btn btn-link" id="saveChangeBtn" value="Save Change"/>
						<input type="button" class="btn btn-link" id="cancelChangeBtn" value="Cancel"/>
						<a class="btn btn-link" href="${pageContext.request.contextPath}/account">Build your Profile</a>
					</p>					

				</form>
			</div>
			<br>

		</div>
	</div>
</body>
</html>