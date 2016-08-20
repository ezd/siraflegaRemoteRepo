<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../defs/lib-file.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(document).ready(function() {
		$('.trigerRemove').click(function(e) {
			e.preventDefault();
			$('#deletModal .btnRemove').attr("href", $(this).attr("href"));
			$('#deletModal').modal();
		});
		$('.trigerEdit').click(function(e){
			e.preventDefault();
			$('#editModal .editUserName').attr("value",$(this).attr("data-userName"))
			
			
		});
	});
</script>
</head>
<body>
	<br>
	<br>
	<div class="col-md-8">
		<div class="container-fluid"
			style="background-color: #ECE9E6; margin: 10px 2px; padding: 5px; box-shadow: 1px 1px 2px grey;">
			<table class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>User Name</th>
						<th>Operation</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users}" var="user">
						<tr>
							<td><a href='<spring:url value="/users/${user.id}.html"/>'>${user.userName}</a></td>
							<td><a class="btn btn-danger trigerRemove"
								href='<spring:url value="/users/remove/${user.id}.html"/>'>Remove</a></td>
							<td><button type="button" class="btn btn-danger trigerEdit"
									data-toggle="modal" data-target="#editModal"
									data-userName="${user.userName}"
									data-password="${user.password}">Edit</button></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="deletModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Remove user</h4>
				</div>
				<div class="modal-body">Do you want to remove the user?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<a href="" class="btn btn-danger btnRemove">Remove</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Remove user</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="userName" class="col-sm-2 control-label">User name:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control editUserName" value=""
								 />
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<a href="" class="btn btn-danger btnRemove">Remove</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>