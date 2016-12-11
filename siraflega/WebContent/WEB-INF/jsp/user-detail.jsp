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
#errorMsg{
display: none;

}
#successMsg{
display: none;
}
.userInput{
display: none;
}
#saveChangeBtn{
display: none;
}
#cancelChangeBtn{
display: none;
}
</style>
<script type="text/javascript">
$( function() {
    $( "#tabs" ).tabs({
      collapsible: false
    });
  } );
	$(function() {
		
		$('#editUserBtn').on('click', function() {
			$('#saveChangeBtn').show();
			$('#cancelChangeBtn').show();
			$('.userInput').show();
			$('.lables').hide();
			$('#editUserBtn').hide();
		});
		$('#cancelChangeBtn').on('click', function(e) {
			$('#userInfoUpdateAreaForm').unbind('submit');//first remove propageted submit 
			$('.userInput').hide();
			$('.lables').show();
			$('#editUserBtn').show();
			$('#saveChangeBtn').hide();
			$('#cancelChangeBtn').hide();
			$( "#tabs" ).tabs({ active: 0 });
			
		});
		$('#cancelPasswordChange').on('click', function(e) {
			//$('#passwordUpdateAreaForm').unbind('submit');//first remove propageted submit 
			$('#oldPassword2').val(null);
			$('#newPassword').val(null);
			$('#reNewPassword').val(null);
			$( "#tabs" ).tabs({ active: 0 });
			
		});

		$('#saveChangeBtn').on('click',function() {
		$("#userInfoUpdateAreaForm").validate({
			onfocusout: function(e) {
	              this.element(e);
	          },
				rules : {
					userNameIn : {
						required : true,
						minlength : 2,
						},
					userEmailIn : {
						required: true,
						email: true
						},	
					oldPassword: {
						required: true,
						minlength: 6
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
						required: "Enter password",
						minlength: "Your password must be at least 6 characters long"
						}
					},
	submitHandler:function(){
		
				$.ajax({
							type : 'POST',
							url : '${pageContext.request.contextPath}/updateUser',
							contentType : 'application/json',
							dataType : 'json',
							data : JSON
									.stringify({
										userName : $('#userNameIn').val(),
										userEmail : $('#userEmailIn').val(),
										userOldPassword : $('#userPassword').val()
									}),
							success : function(data) {
								if (data.isPassCorrect == 'notCorrect'){
									$('#errorMsg').html('This old password does not exist');
									$('#errorMsg').show().fadeOut(5000);
								}else if (data.isEmaiExist == 'EmaiExist'){//isEmaiExist
									$('#errorMsg').html('Email is already used! try another email.');
									$('#errorMsg').show().fadeOut(5000);
								}else if (data.isUserNameExist == 'UserNameExist'){
									$('#errorMsg').html('User name is already used! try another name');
									$('#errorMsg').show().fadeOut(5000);
								}else {
		 							//window.location.replace("${pageContext.request.contextPath}/userDetail");
									$('#successMsg').html('The information is updated successfuly!!');
									$('#successMsg').show().fadeOut(5000);
									$('#userIdIn').val(data.id);
									$('#userNameIn').val( data.userName);
									$('#userEmailIn').val( data.email);
									$('#userNameLb').html( data.userName);
									$('#userEmailLb').html( data.email);
									$('#userPassword').val(null);
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
				$( "#tabs" ).tabs({ active: 0 });
				
		} 
					});
		});
// 		$('#userInfoUpdateAreaForm').submit(function (e) {
// 		    e.preventDefault();
		    
// 		    return false;
// 		});
		
		
// 		parssword update starts###############################################
$('#savePasswordChange').on('click',function(e) {
	$("#passwordUpdateAreaForm").validate({
			onfocusout: function(e) {
	              this.element(e);
	          },
				rules : {
					oldPassword2: {
						required: true,
						minlength: 6
						},
					newPassword: {
						required: true,
						minlength: 6
						},
					reNewPassword: {
						required: true,
						minlength: 6,
						equalTo: "#newPassword"
						}
					},
				
				messages : {
					oldPassword2: {
						required: "Enter old password",
						minlength: "Your password must be at least 6 characters long"
						},
					newPassword: {
						required: "Please provide a password",
						minlength: "Your password must be at least 6 characters long"
						},
					reNewPassword: {
						required: "Please provide a password",
						minlength: "Your password must be at least 6 characters long",
						equalTo: "Please enter the same password as above"
						}
				},
				submitHandler:function(){
					
					$.ajax({
								type : 'POST',
								url : '${pageContext.request.contextPath}/updatePassword',
								contentType : 'application/json',
								dataType : 'json',
								data : JSON
										.stringify({
											passwordTochange : $('#oldPassword2').val(),
											newPassword : $('#newPassword').val()
										}),
								success : function(data) {
									if (data.isPassCorrect == 'notCorrect'){
										$('#errorMsg').html('Incorrect password!');
										$('#errorMsg').show().fadeOut(5000);
									}else {
			 							//window.location.replace("${pageContext.request.contextPath}/userDetail");
										$('#successMsg').html('The password is updated successfuly!!');
										$('#successMsg').show().fadeOut(5000);
									}
								},
								error : function(ts) {
									//alert(ts.responseText);
								}
							});
					$( "#tabs" ).tabs({ active: 1 });
					
			}
	});
	//return false;
 });
	
// 		password update ends here #############################################################
		
		
	});

	</script>
	
</head>
<body>
	<br>
	<br>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<div id="userAccountInformation">
				<div class="alert alert-danger" id="errorMsg"></div>
				<div class="alert alert-success" id="successMsg"></div>
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


				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">User Info</a></li>
						<li><a href="#tabs-2">Change Password</a></li>
					</ul>
					<div id="tabs-1">
						<form id="userInfoUpdateAreaForm">
							<p>
								<span class="caption">User name:</span> <span class="lables"
									id="userNameLb"> ${user.userName}</span> <input
									class="form-control userInput" value="${user.userName}"
									id="userNameIn" name="userNameIn" />
							</p>
							<p>
								<span class="caption">User email:</span> <span class="lables"
									id="userEmailLb"> ${user.email}</span> <input
									class="form-control userInput" value="${user.email}"
									id="userEmailIn" name="userEmailIn" />
							</p>

							<p>
								<span class="captionPass">Password:</span> <span
									class="lables" id="userPassLb">******</span>
									<span class="userInput"> <input
									class="form-control " id="userPassword"
									name="oldPassword" type="password" /></span>
							</p>
							<p>
								<input type="button" class="btn btn-primary" id="editUserBtn" value="Edit user" /> 
								<input type="submit" class="btn btn-primary" id="saveChangeBtn" value="Save Change"  /> 
								<input type="submit" class="cancel btn btn-primary" id="cancelChangeBtn" value="Cancel" />

							</p>
						</form>
					</div>
					<div id="tabs-2">
						<form id="passwordUpdateAreaForm">
							<p>
								<span class="captionPass">Old password:</span> <input
									class="form-control" id="oldPassword2" name="oldPassword2" />
							</p>
							<p>
								<span class="captionPass">New password:</span> <input
									class="form-control" id="newPassword" name="newPassword" />
							</p>
							<p>
								<span class="captionPass">Re-enter New password:</span> <input
									class="form-control" id="reNewPassword" name="reNewPassword" />
							</p>
							<p>
								<input type="submit" class="btn btn-primary" id="savePasswordChange"
									value="Save Change" /> <input type="button"
									class="cancel btn btn-primary" id="cancelPasswordChange"
									value="Cancel" />

							</p>
						</form>
					</div>
				</div>

				<p>	
					<a class="btn btn-link" href="${pageContext.request.contextPath}/account">Build your Profile</a>
				</p>

				
			</div>
			<br>

		</div>
	</div>
</body>

</html>
