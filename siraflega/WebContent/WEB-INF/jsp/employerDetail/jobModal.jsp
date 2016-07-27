<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cc"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="modal fade" id="jobModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form:form id="newjobform" class="form-horizontal" commandName="job"
				action="${pageContext.request.contextPath}/postJob" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">New Job posting</h4>
				</div>
				<form:hidden path="id" id="jobId" />
				<input type="hidden" name="pageNumber" />
				<div class="modal-body">
					<input type="hidden" class="prevCompanyId">
					<div class="form-group">
						<label for="companyName" class="col-sm-2 control-label">Company:</label>
						<div class="col-sm-10">
							<form:select path="company" id="editCompany"
								class="form-control selectpicker">
								<cc:forEach items="${companyObjList}" var="companyObj">
									<form:option value="${companyObj.id}">${companyObj.name}
										[${companyObj.city}, ${companyObj.country}]</form:option>
								</cc:forEach>
								<form:option value="newCompany">New Company</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="position" class="col-sm-2 control-label">Position:</label>
						<div class="col-sm-10">
							<form:input class="form-control" path="position" id="position" />
						</div>
					</div>
					<div class="form-group">
						<label for="discription" class="col-sm-2 control-label">Description:</label>
						<div class="col-sm-10">
							<form:textarea class="form-control" path="discription"
								id="discription" rows="4" />
						</div>
					</div>
					<div class="form-group">
						<label for="sallery" class="col-sm-2 control-label">Salary:</label>
						<div class="col-sm-10">
							<form:input class="form-control" path="sallery" id="sallery" />
						</div>
					</div>
					<div class="form-group">
						<label for="postedDate" class="col-sm-2 control-label">Posted
							date:</label>
						<div class="col-sm-10">
							<div class='input-group date' id='datetimepicker6'>
								<form:input class="form-control" path="postedDate"
									id="postedDate" />
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="deadLine" class="col-sm-2 control-label">Deadline:</label>
						<div class="col-sm-10">
							<div class='input-group date' id='datetimepicker7'>
								<form:input class="form-control" path="deadLine" id="deadLine" />
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar" style="height: 10px"></span>
								</span>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="rqdSkills" class="col-sm-2 control-label">Required
							skills:</label>
						<div class="col-sm-10">
							<form:textarea class="form-control" path="rqdSkills"
								id="rqdSkills" rows="4" />
						</div>
					</div>
					<div class="form-group">
						<label for="rqdEducation" class="col-sm-2 control-label">Required
							education:</label>
						<div class="col-sm-10">
							<form:textarea class="form-control" path="rqdEducation"
								id="rqdEducation" rows="4" />
						</div>
					</div>
					<div class="form-group">
						<label for="rqdExperianceyears" class="col-sm-2 control-label">Years
							of experience:</label>
						<div class="col-sm-10">
							<div class="input-group">
								<form:input class="form-control" path="rqdExperianceyears"
									id="rqdExperianceyears" />
								<span class="input-group-addon">Years</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="howToApply" class="col-sm-2 control-label">How
							to apply:</label>
						<div class="col-sm-10">
							<form:textarea class="form-control" path="howToApply"
								id="howToApply" rows="4" />
						</div>
					</div>
					<div class="form-group">
						<label for="email" class="col-sm-2 control-label">Contact
							email:</label>
						<div class="col-sm-10">
							<form:input class="form-control" path="email" id="email" />
						</div>
					</div>
					<div class="form-group">
						<label for="phone" class="col-sm-2 control-label">Contact
							phone:</label>
						<div class="col-sm-10">
							<form:input class="form-control" path="phone" id="phone" />
						</div>
					</div>
					<!-- 					<div class="form-group"> -->
					<!-- 						<label for="clogo" class="col-sm-2 control-label">Logo:</label> -->
					<!-- 						<div class="col-sm-10"> -->
					<!-- 							<input type="file" class="form-control" id="clogo" name="logo"> -->
					<!-- 						</div> -->
					<!-- 					</div> -->


				</div>
				<div class="modal-footer">
					<button id="cancelJobBtn" type="button" class="btn btn-default"
						data-dismiss="modal">Close</button>
					<input type="submit" class="btn btn-primary"
						value="Save
							changes" id="updateJob" />
				</div>
			</form:form>
		</div>
	</div>
</div>
<%@ include file="../employeeDetail/editCompanyModal.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#newjobform").validate({
			rules : {
				position : {
					required : true,
					minlength : 2,
				},
				discription : {
					required : true,
					minlength : 200,
				},
				sallery : {
					required : true,
				},
				postedDate : {
					required : true,
				},
				deadLine : {
					required : true,
				},
				rqdSkills : {
					required : true,
					minlength : 10
				},
				rqdEducation : {
					required : true,
					minlength : 10
				},
				rqdExperianceyears : {
					required : true
				},
				howToApply : {
					required : true,
					minlength : 2
				},
				email : {
					required : true,
					email: true
				},
				phone : {
					required : true,
					minlength : 10
				}
			},
			messages : {
				position : {
					required : "Please insert position.",
					minlength : "Please insert atleast 2 character for postion.",
				},
				discription : {
					required : "Please insert description. It is required.",
					minlength : "Please insert for description at least 200 carachters."
				},
				sallery : {
					required : "Please insert sallery. It is required.",
				},
				postedDate : {
					required : "Please insert post date. It is required.",
// 					date: "Please insert proper date."
				},
				deadLine : {
					required : "Please insert deadline date. It is required.",
// 					date: "Please insert proper date."
				},
				rqdSkills : {
					required : "Please insert required skill. It is required.",
					minlength : "Please insert for required skill at least 10 carachters."
				},
				rqdEducation : {
					required : "Please insert required education. It is required.",
					minlength : "Please insert for required education at least 10 carachters."
				},
				rqdExperianceyears : {
					required : "Please insert required number of years. It is required."
				},
				howToApply : {
					required : "Please insert how to apply. It is required.",
					minlength : "Please insert for how to apply at least 2 carachters."
				},
				email : {
					required : "Please insert email address. It is required.",
					email: "Please insert proper email address."
				},
				phone : {
					required : "Please insert phone number. It is required.",
					minlength : "Please insert proper phone number, 10 digit."
				}
			},
			onfocusout: function(element) {
	            this.element(element);
	        }
		});
		$('#datetimepicker6').datetimepicker({
			format : 'DD/MM/YYYY'
		});
		
		$('#datetimepicker7').datetimepicker({
			useCurrent : false,
			format : 'DD/MM/YYYY'
		//Important! See issue #1075
		});
		$("#datetimepicker6").on("dp.change", function(e) {
			$('#datetimepicker7').data("DateTimePicker").minDate(e.date);
		});
		$("#datetimepicker7").on("dp.change", function(e) {
			$('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
		});
		$("#position").autocomplete({
			source : function(query, process) {
				$.ajax({
					type : 'GET',
					url : '/siraflega/catigories',
					contentType : 'application/json',
					dataType : 'json',
					data : {
						q : query.term
					},
					success : function(data) {
						process(data);
					},
					error : function(ts) {
						alert(ts.responseText);
					}
				});
			}
		});
		$('#editCompany').on('change', function() {
			if ($('#editCompany').val() == 'newCompany') {
				$('#companyModal').modal();
			} else {
				$('.prevCompanyId').val($('#editCompany').val());
			}
		});
		$('#cancelCompanyBtn').on("click", function() {
			alert("close me" + $('.prevCompanyId').val());
			$('#editCompany').val($('.prevCompanyId').val());
			$('#editCompany').selectpicker('render');
		});
		//save new company

	});
	$.clearFormFields = function(area) {
		$(area)
				.find(
						'input[type=text], input[type=password], input[type=number],input[type=url], input[type=email], textarea')
				.val('');
	};
	$('#jobModal').on('hidden.bs.modal', function(e) {
		$.clearFormFields(this);
	});
	// 	//ajax for auto complete
	// 	$("#ccity").autocomplete({
	// 		source : function(query, process) {
	// 			$.ajax({
	// 				type : 'GET',
	// 				url : '${pageContext.request.contextPath}/cities.html',
	// 				contentType : 'application/json',
	// 				dataType : 'json',
	// 				data : {
	// 					q : query.term
	// 				},
	// 				success : function(data) {
	// 					process(data);
	// 				},
	// 				error : function(ts) {
	// 					alert(ts.responseText);
	// 				}
	// 			});
	// 		}
	// 	});
</script>