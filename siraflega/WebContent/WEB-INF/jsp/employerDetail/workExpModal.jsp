<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cc"%>

<!-- Modal -->
<div class="modal fade" id="employerWorkExpModal" tabindex="-1"
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
					<input type="hidden" name="id" class="editId" id="companyId" /> <input
						type="hidden" class="editIndex" />
					<div class="form-group">
						<input type="hidden" class="prevCompanyId"> <label
							for="companyName" class="col-sm-3 control-label">Company:</label>
						<div class="col-sm-9">
							<select name="selectedCompany" id="editCompany"
								class="form-control selectpicker">
								<cc:forEach items="${companyObjList}" var="companyObj">
									<option value="${companyObj.id}">${companyObj.name}
										[${companyObj.city}, ${companyObj.country}]</option>
								</cc:forEach>
								<option value="newCompany">New Company</option>
							</select>
						</div>

					</div>
					<div class="form-group">
						<label for="postion" class="col-sm-3 control-label">Position:</label>
						<div class="col-sm-9">
							<input type="text" name="postion"
								class="form-control editPostion" id="wpostion" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">Start date:</label>

						<div class='col-sm-9'>
							<div class='input-group date' id='datetimepicker6'>
								<input type='text' class="form-control startDate" /> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label">End date:</label>

						<div class='col-sm-9'>
							<div class='input-group date' id='datetimepicker7'>
								<input type='text' class="form-control endDate" /> <span
									class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<label for="isCurrently" class="control-label">Is
								Currently Working:</label> <input type="checkbox" id="isCurrentlyChk"/>
						</div>
					</div>
<!-- 					<div class="form-group"> -->
<!-- 						<label for="description" class="col-sm-3 control-label">Description:</label> -->
<!-- 						<div class="col-sm-9"> -->
<!-- 							<textarea name="description" id="wdescription" -->
<!-- 								class="form-control editDescription" cols="30" rows="5"></textarea> -->
<!-- 						</div> -->
<!-- 					</div> -->

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="updateEmployerWrokExp"
					data-dismiss="modal" data-backdrop="false">Save changes</button>
				<button type="button" class="btn btn-primary" id="saveEmployerWrokExp"
					data-dismiss="modal" data-backdrop="false">Save</button>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	//prepare exp list
	function addExData(data) {
		var crnt="Previous:";
		if(data.isCurrentlyWorking==true){
			crnt='Current:';
			$('#isCurrentLbl').html("Previous:");
			$('#workPostion').html(data.position+' at '+data.companyName);
			/*
			
			*/
			
		}
		var listToAdd = '<li>'
				+ '<div class="titleThree"> '
				+ '<security:authorize access="isAuthenticated()">'
				+ '<button type="button" class="btn btn-danger btn-sm deleteWorkBtn" '
							+ 'data-idToDelete="'+data.id+'"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>'
				+ '<button type="button" class="btn btn-primary btn-sm trigerEdit" id="editWorkBtn" '
				+ 'data-toggle="modal" data-target="#employerWorkExpModal" data-id="'
				+ data.id
				+ '" '
				+ 'data-position="'+ data.position+ '" '
				+ 'data-company="'+ data.companyId+ '" '
				+ 'data-start="'+ $.datepicker.formatDate('yy-mm-dd', new Date(data.startDate))+ '" '
				+ 'data-end="'+ $.datepicker.formatDate('yy-mm-dd', new Date(data.endDate))+ '" '
				+ 'data-currentlyWorking="'+ data.isCurrentlyWorking
				+ '"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></button> '
				+ '</security:authorize>'
				+ '<h4>'
				+'<span id="isCurrentLbl" style="font-family: cursive; font-size:medium;">'+crnt+'</span>'
				+ '<span id="workPostion">'
				+ data.position
				+ '</span></h4> '
				+ '</div>'
				+ '<h5><span id="workExpcompanyName">'
				+ data.companyName
				+ '</span></h5>'
				+ '<h6><span id="startDateExp">'
				+ $.datepicker.formatDate('M d, yy', new Date(data.startDate))
				+ '</span> - <span id="endDateExp">'
				+ $.datepicker.formatDate('M d, yy', new Date(data.endDate))
				+ '</span> | <span id="workExpCity">'
				+ data.companyCity
				+ '</span>,<span id="workExpCountry">'
				+ data.companyCountry
				+ '</span></h6>'
				+ '</li>';
		return listToAdd;

	}
	$(document).ready(function() {
			$('#isCurrentlyChk').click(function(){
				if($(this).is(':checked')){
					var today=new Date();
					var dd = today.getDate();
					var mm = today.getMonth()+1; //January is 0!
					var yyyy = today.getFullYear();
					var formatedDate=dd+"/"+mm+"/"+yyyy
					$('.endDate').val(formatedDate);
					$(".endDate").prop('disabled',true);
				}else{
					$(".endDate").prop('disabled',false);
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
			$("#datetimepicker6").on(
					"dp.change",
					function(e) {
						$('#datetimepicker7')
								.data("DateTimePicker").minDate(
										e.date);
					});
			$("#datetimepicker7").on(
					"dp.change",
					function(e) {
						$('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
					});
						//ajax for saving new exp
			$("#saveEmployerWrokExp").on("click", function() {
				$.ajax({
					type : 'POST',
					url : '${pageContext.request.contextPath}/saveEmployerWrorkExp',
					contentType : 'application/json',
					dataType : 'json',
					data : JSON.stringify({
						workExpId : $(".editId").val(),
						companyId : $("#editCompany").val(),
						position : $("#wpostion").val(),
						startDate : $(".startDate").val(),
						endDate : $(".endDate").val(),
						isCurrent : $("#isCurrentlyChk").prop('checked')
					}),
					success : function(data) {
						var list = addExData(data);
						if(data.isCurrentlyWorking==true){
							$('#workExpList').prepend(list);
						}else
							{
							$('#workExpList').append(list);
							}
						
						$('#editWorkExpModal').modal('hide');
					},
					error : function(ts) {
						alert(ts.responseText);
					}
				});
			});
						//ajax for updating work exp should be added
			$("#updateEmployerWrokExp").on("click",function() {
				$.ajax({
					type : 'POST',
					url : '${pageContext.request.contextPath}/updateEmployerWrokExp',
					contentType : 'application/json',
					dataType : 'json',
					data : JSON.stringify({
								workExpId : $(".editId").val(),
								companyId : $("#editCompany").val(),
								position : $("#wpostion").val(),
								startDate : $(".startDate").val(),
								endDate : $(".endDate").val(),
								isCurrent : $("#isCurrentlyChk").prop('checked')
							}),
					success : function(data) {
						// 	populateExData(data);$('#employerWorkExpModal .editIndex')
						var indexToBeUpdated = $('#employerWorkExpModal .editIndex').val();
						var list = addExData(data);
						$('#workExpList').children().eq(indexToBeUpdated).replaceWith(list);
						$('#workExpList').listview('refresh');
						$('#updateEmployerWrokExp').modal('hide');
						$.clearInput(this);
					},
					error : function(ts) {
						//alert(ts.responseText);
					}
						});
										});
						//ajax to delete work exp

						$.clearFormFields = function(area) {
							$('#wpostion').val('');
// 							$('#datetimepicker6').val('');
// 							$('#datetimepicker7').val('');
							$('#isCurrently').prop('checked', false);
						};
						$('#employerWorkExpModal').on('hidden.bs.modal',
								function(e) {
									$.clearFormFields(this);
								});

					});
</script>