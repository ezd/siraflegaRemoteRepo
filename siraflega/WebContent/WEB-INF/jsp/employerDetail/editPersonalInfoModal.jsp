<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- Modal -->
	<div class="modal fade" id="editEmployerPersonalInfoModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<form class="form-horizontal">
				<div class="modal-content ">

					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Update employee
							information</h4>
					</div>
					<input type="hidden" id="employerId">
					<div class="modal-body">
						<div class="form-group">
							<label for="firstName" class="col-sm-3 control-label">First
								Name:</label>
							<div class="col-sm-9">
								<input type="text" id="firstNameEmployer" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="middleName" class="col-sm-3 control-label">Middle
								Name:</label>
							<div class="col-sm-9">
								<input type="text" id="middleNameEmployer" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="lastName" class="col-sm-3 control-label">Last
								Name:</label>
							<div class="col-sm-9">
								<input type="text" id="lastNameEmployer" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<label for="lastName" class="col-sm-3 control-label">Phone:</label>
							<div class="col-sm-9">
								<input type="text" id="phoneEmployer" class="form-control" />
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" id="saveEmployerPersonalInfo" >Save</button>
						<button type="button" class="btn btn-primary" id="updateEmployerPersonalInfo">Save change</button>
					</div>

				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	$('#updateEmployerPersonalInfo').click(function(){
		$.ajax({
			type: 'POST',
			url: 'updateEmployerInfo',
			contentType: 'application/json',
			dataType:'json',
			data: JSON.stringify({
				id:$('#employerId').val(),
				fName:$('#firstNameEmployer').val(),
				mName:$('#middleNameEmployer').val(),
				lName:$('#lastNameEmployer').val(),
				phone:$('#phoneEmployer').val()
			}),
			success : function(data){
				$('#updateEmprInfo').attr('data-firsName',data.fName);
				$('#updateEmprInfo').attr('data-middleName',data.mName);
				$('#updateEmprInfo').attr('data-lastName',data.lName);
				$('#updateEmprInfo').attr('data-phone',data.phone);
				$('#phone').html(data.phone);
				$('#employerName').html(data.fName+' '+data.mName+' '+data.lName);
				$('#editEmployerPersonalInfoModal').modal('hide');
			},
			error : function(ts) {
				alert(ts.responseText);
			}
		});
	});
	
	$('#saveEmployerPersonalInfo').click(function(){
		$.ajax({
			type: 'POST',
			url: 'saveEmployerInfo',
			contentType: 'application/json',
			dataType:'json',
			data: JSON.stringify({
				fName:$('#firstNameEmployer').val(),
				mName:$('#middleNameEmployer').val(),
				lName:$('#lastNameEmployer').val(),
				phone:$('#phoneEmployer').val()
			}),
			success : function(data){
				$('#employerId').val(data.id),
				$('#updateEmprInfo').attr('data-firsName',data.fName);
				$('#updateEmprInfo').attr('data-middleName',data.mName);
				$('#updateEmprInfo').attr('data-lastName',data.lName);
				$('#updateEmprInfo').attr('data-phone',data.phone);
				$('#phone').html(data.phone);
				$('#employerName').html(data.fName+' '+data.mName+' '+data.lName);
				$('#editEmployerPersonalInfoModal').modal('hide');
			},
			error : function(ts) {
				alert(ts.responseText);
			}
		});
	});
	</script>