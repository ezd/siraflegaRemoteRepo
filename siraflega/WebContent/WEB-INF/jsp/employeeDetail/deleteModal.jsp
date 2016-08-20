<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="cc"%>
<!-- Modal -->
<div class="modal fade" id="delet_Modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">
					Remove <span id="nameItemToBeDeleted"></span>
				</h4>
			</div>
			<div class="modal-body" id="deleteConfirmationMessage"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-danger btnRemove"
					data-idToBeDelete="" data-deleteItem="" data-deleteIndex=""
					id="deleteConfirmedBtn" data-dismiss="modal" data-backdrop="false">Delete</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
	$('#deleteConfirmedBtn').on('click',function(e) {
						var idtodelete = $(this).attr(
								'data-idToBeDelete');
						var selectedLisIndex = $(this)
								.attr('data-deleteIndex');
						var itemToBeDeleted = $(this).attr(
								'data-deleteItem');
						if (itemToBeDeleted == 'Work Experience') {
							$.ajax({
									type : 'POST',
									url : 'deleteWorkExp',
									contentType : 'application/json',
									dataType : 'json',
									data : JSON.stringify({id : idtodelete}),
									success : function(data) {
										$('#workExpList').children().eq(selectedLisIndex).remove();
										$('#workExpList').listview("refresh");
										$('#delet_Modal').modal('toggle');
									},
									error : function(ts) {
										//alert(ts.responseText);
									}
								});
						} else if (itemToBeDeleted == 'Employer Work Experience') {
							$.ajax({
									type : 'POST',
									url : 'deleteEmployerWorkExp',
									contentType : 'application/json',
									dataType : 'json',
									data : JSON.stringify({id : idtodelete}),
									success : function(data) {
										$('#workExpList').children().eq(selectedLisIndex).remove();
										$('#workExpList').listview("refresh");
										$('#delet_Modal').modal('toggle');
									},
									error : function(ts) {
										//alert(ts.responseText);
									}
								});
						} else if (itemToBeDeleted == 'Education') {
							$.ajax({
									type : 'POST',
									url : 'deleteEducation',
									contentType : 'application/json',
									dataType : 'json',
									data : JSON.stringify({id : idtodelete}),
									success : function(data) {
										$('#educationList').children().eq(selectedLisIndex).remove();
										$('#educationList').listview("refresh");
										$('#delet_Modal').modal('toggle');
									},
									error : function(ts) {
										//alert(ts.responseText);
									}
								});
						}  else if (itemToBeDeleted == 'Posted Job') {
							$.ajax({
								type : 'POST',
								url : '${pageContext.request.contextPath}/deletePostedJob',
								contentType : 'application/json',
								dataType : 'json',
								data : JSON.stringify({id : idtodelete}),
								success : function(data) {
									window.location.reload();
								},
								error : function(ts) {
									//alert(ts.responseText);
								}
							});
					} else if (itemToBeDeleted == 'Language') {
							$.ajax({
									type : 'POST',
									url : 'deleteLanguage',
									contentType : 'application/json',
									dataType : 'json',
									data : JSON.stringify({id : idtodelete}),
									success : function(data) {
										var calculatedIndex = parseInt(selectedLisIndex,10) + 1;
										$('#languageProfLevel tbody tr').eq(selectedLisIndex).remove();
										// 					$('#delet_Modal').modal('toggle');
									},
									error : function(ts) {
										//alert(ts.responseText);
									}
								});
						}
					});
					});
</script>