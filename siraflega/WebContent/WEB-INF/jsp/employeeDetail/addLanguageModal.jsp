<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cc"%>

<!-- Modal -->
<div class="modal fade" id="addLanguageModal" tabindex="-1"
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
					<input type="hidden" id="languageEditId" /> <input type="hidden"
						id="languageEditIndex" />
					<div class="form-group">
						<label for="languageName" class="col-sm-3 control-label">Language:</label>
						<div class="col-sm-9">
							<input type="text" class="form-control " id="languageName" />
						</div>
					</div>
					<div class="form-group">
						<label for="proficiencyLevel" class="col-sm-3 control-label">Proficiency
							Level:</label>
						<div class="col-sm-9">
						<select id="proficiencyLevel"
								class="form-control selectpicker">
								<option value="No Practical Proficiency">No Practical Proficiency</option>
								<option value="Elementary Proficiency">Elementary Proficiency</option>
								<option value="Limited Working Proficiency">Limited Working Proficiency</option>
								<option value="Minimum Professional Proficiency">Minimum Professional Proficiency</option>
								<option value="Full Professional Proficiency">Full Professional Proficiency</option>
								<option value="Native Proficiency">Native Proficiency</option>
								</select>
						</div>
					</div>
										<!-- 				ends here -->
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="updateLanguage"
					data-dismiss="modal" data-backdrop="false">Save changes</button>
				<button type="button" class="btn btn-primary" id="saveLanguage"
					data-dismiss="modal" data-backdrop="false">Save</button>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	//prepare exp list
	function addLanguageData(data) {
		var rowToAdd = '<tr>' + '<td>'
				+ data.name
				+ '</td> '
				+ '<td>'
				+ data.level
				+ '</td> '
				+ '<security:authorize access="isAuthenticated()">'
				+ '<td align="right">'
				+'<button type="button" style="border-radius: 0px;" class="btn btn-primary btn-sm trigerLanguageEdit" '
				+'	data-toggle="modal" '
				+'	data-target="#addLanguageModal" '
				+'	data-languageId="'+data.id+'" '
				+'	data-name="'+data.name+'" '
				+'	data-languageLevel="'+data.level+'"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></button>'
				+'<button type="button" style="border-radius: 0px;" class="btn btn-danger btn-sm deleteLanguageBtn"'
				+'	data-languageToDelete="'+data.id+'"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>'
					
				+ '</td> '
				+ '</security:authorize>' 
				+ '</tr>';
		return rowToAdd;

	}
	$(document).ready(function() {
		//ajax for saving new language
	$("#saveLanguage").on("click",function() {
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/saveLanguage',
				contentType : 'application/json',
				dataType : 'json',
				data : JSON.stringify({
							languageName : $("#languageName").val(),
							languageLevel : $("#proficiencyLevel").val(),
						}),
				success : function(data) {
					var row = addLanguageData(data);
					$('#languageProfLevel > tbody:last-child').append(row);
					$('#addLanguageModal').modal('hide');
					// 									$.clearFormFields(this);
				},
				error : function(ts) {
					//alert(ts.responseText);
				}
			});
	});
	$("#updateLanguage").on("click",function() {
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/updateLanguage',
			contentType : 'application/json',
			dataType : 'json',
			data : JSON.stringify({
						languageId:$("#languageEditId").val(),
						languageName : $("#languageName").val(),
						languageLevel : $("#proficiencyLevel").val(),
					}),
			success : function(data) {
				var indexToBeUpdated = parseInt($('#languageEditIndex').val(),10);
				var row = addLanguageData(data);
				$('#languageProfLevel tbody tr').eq(indexToBeUpdated).replaceWith(row);
				$('#addLanguageModal').modal('hide');
				// 									$.clearFormFields(this);
			},
			error : function(ts) {
				//alert(ts.responseText);
			}
		});
	});
	


	});
</script>