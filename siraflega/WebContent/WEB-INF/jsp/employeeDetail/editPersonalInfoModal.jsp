<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- Modal -->
	
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/additional-methods.min.js"></script>
	
<%-- 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script> --%>
	<div class="modal fade" id="editPersonalInfoModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">

			<form:form id="updateEmpInfo" class="form-horizontal"
				commandName="employee"
				action="${pageContext.request.contextPath}/updateEmployee">
				<div class="modal-content ">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Update employee
							information</h4>
					</div>
					<div class="modal-body">
						<form:hidden path="id" />
						<form:hidden path="email" />
						<div class="form-group">
							<label for="firstName" class="col-sm-3 control-label">First
								Name:</label>
							<div class="col-sm-9">
								<frm:input path="firstName" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="middleName" class="col-sm-3 control-label">Middle
								Name:</label>
							<div class="col-sm-9">
								<frm:input path="middleName" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="lastName" class="col-sm-3 control-label">Last
								Name:</label>
							<div class="col-sm-9">
								<frm:input path="lastName" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="age" class="col-sm-3 control-label">Age:</label>
							<div class="col-sm-9">
								<frm:input path="age" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="sex" class="col-sm-3 control-label">Sex:</label>
							<div class="col-sm-9">
								<frm:select path="sex">
									<frm:option value="F">Female</frm:option>
									<frm:option value="M">Male</frm:option>
								</frm:select>
							</div>
						</div>
						<div class="form-group">
							<label for="address" class="col-sm-3 control-label">Address:</label>
							<div class="col-sm-9">
								<frm:input path="address" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="telephone" class="col-sm-3 control-label">Telephone:</label>
							<div class="col-sm-9">
								<frm:input path="telephone" class="form-control" />
							</div>
						</div>


					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<input type="submit" class="btn btn-lg btn-primary"
							value="Save changes">
					</div>
				</div>
			</form:form>
		</div>
	</div>
	
	<script type="text/javascript">

		$(document).ready(function() {
			$("#updateEmpInfo").validate(
				{
					rules : {
					firstName : {
							required : true,
							minlength : 2,
							lettersonly:true
						},
					middleName:{
							required: true,
							minlength: 2,
							lettersonly:true
						},
					lastName : {
							required : true,
							minlength : 2,
							lettersonly:true
						},
	 				age: {
	 					required: true,
	 					alphanumeric:true,
	 					min:15,
	 					},
	 				sex: {
	 					required: true,
	 					},
	 				address:{
	 					required: true,
	 					},
 					telephone:{
	 						required:true
// 	 						phonesUK:fa
	 					},
					},
					messages : {
						firstName : {
							required : "Please enter your first name",
							minlength : "First name shoud be more than 2 characters",
						},
						middleName:{
							required : "Please enter your middle name",
							minlength : "Middle name shoud be more than 2 characters",
							},
						lastName : {
							required : "Please enter your last name",
							minlength : "Last name shoud be more than 2 characters"
						},
		 				age: {
		 					required: "Please enter your age",
		 					min: "Minimum age allowed is 15"
		 					},
		 				sex: {
		 					required: "Enter your sex"
		 					},
		 				address:{
		 					required: "Address is required"
		 					},
	 					telephone:{
	 						required:"Enter your telephone number"
	 					},
					}
				});
	})
	</script>