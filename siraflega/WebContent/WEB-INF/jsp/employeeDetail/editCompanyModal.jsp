<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cc"%>
<div class="modal fade" id="companyModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Add company</h4>
			</div>
			<form class="form-horizontal" id="companyContainer" name="companyContainername">
				<div class="modal-body">

					<div class="form-group">
						<label for="companyName" class="col-sm-2 control-label">Company
							name:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="cName"
								name="companyName">
						</div>
					</div>
					<div class="form-group">
						<label for="caofFocus" class="col-sm-2 control-label">Area
							of focus:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="caofFocus"
								name="areaofFocus">
						</div>
					</div>
					<div class="form-group">
						<label for="caddress" class="col-sm-2 control-label">Street
							address:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="caddress"
								name="address">
						</div>
					</div>
					<div class="form-group">
						<label for="ccountry" class="col-sm-2 control-label">Country:</label>
						<div class="col-sm-10">
							<select id="ccountry" name="country"
								class="form-control bfh-countries" data-country="ET"></select>
						</div>
					</div>

					<div class="form-group">
						<label for="ccity" class="col-sm-2 control-label">City:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="ccity" name="city">
						</div>
					</div>
					<div class="form-group">
						<label for="ctele" class="col-sm-2 control-label">Telephone:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="ctele"
								name="telephone">
						</div>
					</div>
					<div class="form-group">
						<label for="cweb" class="col-sm-2 control-label">Web-site:</label>
						<div class="col-sm-10">
							<input type="url" class="form-control" id="cweb" name="website">
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
					<button id="cancelCompanyBtn" type="button" class="btn btn-default"
						data-dismiss="modal">Close</button>
					<input type="submit" class="btn btn-primary"
						value="Save
							changes" id="submitCompany" />
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
						
						$('#editCompany').on('change',function() {
											if ($('#editCompany').val() == 'newCompany') {
												$('#companyModal').modal();
											} else {
												$('.prevCompanyId').val($('#editCompany').val());
											}
										});
						$('#cancelCompanyBtn').on("click", function() {
							$('#editCompany').val($('.prevCompanyId').val());
							$('#editCompany').selectpicker('render');
						});
						//save new company
// 						var validator = $("#companyContainer").validate();
						$("#submitCompany").on("click",function() {
							$.ajax({
									type : 'POST',
									url : '${pageContext.request.contextPath}/saveCompany',
									contentType : 'application/json',
									dataType : 'json',
									data : JSON.stringify({
										name : $("#cName").val(),
										areaOfFocus : $("#caofFocus").val(),
										address : $("#caddress").val(),
										country : $("#ccountry option:selected").text(),
												city : $("#ccity").val(),
												telephon : $("#ctele").val(),
												website : $("#cweb").val()
											}),
									success : function(data) {
										$('#editCompany').find('[value=newCompany]').remove();
										$('#editCompany').append($('<option>',{value : data.id,text : data.name+ ' ['+ data.city+ ', '+ data.country+ ']'
																}));
										$('#editCompany').append($('<option>',{value : 'newCompany',text : 'New Company'
																}));
										$('#editCompany').val(data.id);
										$('#editCompany').selectpicker('refresh');
										$('#companyModal').modal('hide');
									},
									error : function(ts) {
										//alert(ts.responseText);
									}
								});

					});

// 					});
	$('#companyModal').on('hidden.bs.modal', function(e) {
		$.clearFormFields(this);
	});
	//ajax for auto complete
	$("#ccity").autocomplete({
		source : function(query, process) {
			$.ajax({
				type : 'GET',
				url : '${pageContext.request.contextPath}/cities.html',
				contentType : 'application/json',
				dataType : 'json',
				data : {
					q : query.term
				},
				success : function(data) {
					process(data);
				},
				error : function(ts) {
					//alert(ts.responseText);
				}
			});
		}
	});
});
//	$("#companyContainer").validate({
//	rules:{
//		companyName:{
//			required:true,
//			minLenght:2
//			},
//		areaofFocus:{
//			required:true,
//			minLenght:2
//			},
//		address:{
//			required:true,
//			minLenght:2
//			},
//		country:{
//			required:true,
//			minLenght:2
//			},
//		city:{required:true,
//			minLenght:2
//			},
//		telephone:{
//			required:true,
//			minLenght:10
//			}
//		},
//	messages:{
//		companyName:{
//			required:"Please insert company name. It is requierd.",
//			minLenght:"Please insert at least 2 character."
//			},
//		areaofFocus:{
//			required:"Please insert area of focus. It is requierd.",
//			minLenght:"Please insert at least 2 character."
//			},
//		address:{
//			required:"Please insert address. It is requierd.",
//			minLenght:"Please insert at least 2 character."
//			},
//		country:{
//			required:"Please insert country. It is requierd.",
//			minLenght:"Please insert at least 2 character."
//			},
//		city:{
//			required:"Please insert city. It is requierd.",
//			minLenght:"Please insert at least 2 character."
//			},
//		telephone:{
//			required:"Please insert telephone. It is requierd.",
//			minLenght:"Please insert 10 degit telephone number."
//			}
//		},
//		onfocus: function(element) {
//         this.element(element);
//     }

//});
</script>



