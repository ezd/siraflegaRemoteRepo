<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cc"%>

<!-- Modal -->
<div class="modal fade" id="addEducationModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Edit work experience</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<input type="hidden" id="educationEditId"/> 
						<input type="hidden" id="educationEditIndex" />
					<div class="form-group">
						<label for="educationInstitutionName"
							class="col-sm-3 control-label">Institution Name:</label>
						<div class="col-sm-9">
							<input type="text" class="form-control "
								id="educationInstitutionName" />
						</div>
					</div>
					<div class="form-group">
						<label for="educationLevel" class="col-sm-3 control-label">Level:</label>
						<div class="col-sm-9">
							<input type="text" class="form-control " id="educationLevel" />
						</div>
					</div>
					<div class="form-group">
						<label for="educationTitle" class="col-sm-3 control-label">Award
							title:</label>
						<div class="col-sm-9">
							<input type="text" class="form-control " id="educationTitle" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">Start date:</label>

						<div class='col-sm-9'>
							<div class='input-group date' id='educationDatetimepickerStart'>
								<input type='text' class="form-control startEducationDate" /> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">End date:</label>
						<div class='col-sm-9'>
							<div class='input-group date' id='educationDatetimepickerEnd'>
								<input type='text' class="form-control endEducationDate" /> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="educationRemark" class="col-sm-3 control-label">Remark:</label>
						<div class="col-sm-9">
							<textarea id="educationRemark" class="form-control" cols="30"
								rows="5"></textarea>
						</div>
					</div>
					<!-- 				ends here -->
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="updateEducation"
					data-dismiss="modal" data-backdrop="false">Save changes</button>
				<button type="button" class="btn btn-primary" id="saveEducation"
					data-dismiss="modal" data-backdrop="false">Save</button>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	//prepare exp list
	function addEducationData(data) {
		var listToAdd = '<li>' 
					+'<div class="titleThree">'
						+ '<security:authorize access="isAuthenticated()">'
							+ '<button type="button" class="btn btn-danger btn-sm deleteEducationBtn" '
							+ 'data-educationToDelete="'+data.id+'"'+'><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>'
							+ '<button type="button" class="btn btn-primary btn-sm trigerEducationEdit" id="editEducationBtn" '
							+ 'data-toggle="modal" data-target="#addEducationModal" data-educationId="'
							+ data.id
							+ '" '
							+ 'data-institute="'+ data.institute+ '" '
							+ 'data-educationLevel="'+ data.level+ '" '
							+ 'data-educationTitle="'+ data.title+ '" '
							+ 'data-educationStart="'
							+ $.datepicker.formatDate('yy-mm-dd', new Date(data.startDate))+ '" '
							+ 'data-educationEnd="'
							+ $.datepicker.formatDate('yy-mm-dd', new Date(data.endDate))+ '" '
							+ 'data-educationRemark="'+ data.remark+ '"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></button> '
						+ '</security:authorize>'
						+ '<span class="titleThreeText">'+ data.institute+ '</span> '
					+'</div>'
				+ '<h5>' + $.datepicker.formatDate('M d, yy', new Date(data.startDate))
				+'-'+ $.datepicker.formatDate('M d, yy', new Date(data.endDate))
				+', '+data.level+', '+data.title
				+ '</h5>' 
				+ '<div class="descriptionText">'+data.remark+'</div>'
				+ '</li>';
		return listToAdd;

	}
	$(document)
			.ready(
					function() {
						
						$('#institutionName').autocomplete({
							source : function(query, process) {
								$.ajax({
									type : 'GET',
									url : '${pageContext.request.contextPath}/educationInistitiute.html',
									contentType : 'application/json',
									dataType : 'json',
									data : {
										q : query.term
									},
									success : function(data) {
										process(data);
									},
									error : function(ts) {
									}
								});
							}
						});

						$('#educationDatetimepickerStart').datetimepicker({
							format : 'DD/MM/YYYY'
						});
						$('#educationDatetimepickerEnd').datetimepicker({
							useCurrent : false,
							format : 'DD/MM/YYYY'
						//Important! See issue #1075
						});
						$("#educationDatetimepickerStart").on(
								"dp.change",
								function(e) {
									$('#educationDatetimepickerEnd')
											.data("DateTimePicker").minDate(
													e.date);
								});
						$("#educationDatetimepickerEnd").on(
								"dp.change",
								function(e) {
									$('#educationDatetimepickerStart')
											.data("DateTimePicker").maxDate(
													e.date);
								});
						//ajax for saving new exp
						$("#saveEducation").on("click", function() {
							$.ajax({
								type : 'POST',
								url : '${pageContext.request.contextPath}/saveEducation',
								contentType : 'application/json',
								dataType : 'json',
								data : JSON.stringify({
									inistitution : $("#educationInstitutionName").val(),
									level : $("#educationLevel").val(),
									title : $("#educationTitle").val(),
									startDate : $(".startEducationDate").val(),
									endDate : $(".endEducationDate").val(),
									remark : $('#educationRemark').val()
								}),
								success : function(data) {
									var list = addEducationData(data);
									$('#educationList').prepend(list);
									$('#addEducationModal').modal('hide');
// 									$.clearFormFields(this);
								},
								error : function(ts) {
									//alert(ts.responseText);
								}
							});
						});
						//ajax for updating education
						$("#updateEducation").on("click", function() {
							$.ajax({
								type : 'POST',
								url : '${pageContext.request.contextPath}/updateEducation',
								contentType : 'application/json',
								dataType : 'json',
								data : JSON.stringify({
									educationId:$("#educationEditId").val(),
									inistitution : $("#educationInstitutionName").val(),
									level : $("#educationLevel").val(),
									title : $("#educationTitle").val(),
									startDate : $(".startEducationDate").val(),
									endDate : $(".endEducationDate").val(),
									remark : $('#educationRemark').val()
								}),
								success : function(data) {
									var indexToBeUpdated = $('#educationEditIndex').val();
									var list = addEducationData(data);
									$('#educationList').children().eq(indexToBeUpdated).replaceWith(list);
									$('#educationList').listview('refresh');
									$('#addEducationModal').modal('hide');
// 									$.clearFormFields(this);
								},
								error : function(ts) {
									//alert(ts.responseText);
								}
							});
						});
						//ajax for updating work exp
						$.clearFormFields = function(area) {
							$(area)
									.find(
											'input[type=text], input[type=password], input[type=number],input[type=url], input[type=email], textarea')
									.val('');
						};
						$('#addEducationModal').on('hidden.bs.modal',
								function(e) {
									$.clearFormFields(this);
								});

					});
</script>