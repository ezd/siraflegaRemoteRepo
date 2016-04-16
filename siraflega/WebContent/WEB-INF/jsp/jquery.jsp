<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
#usersList {
	list-style: none;
}

#usersList li {
	background-color: #ccc;
	margin-bottom: 2px;
}

#divForm {
	margin: 5px;
	padding: 10px;
	background-color: #ddd;
}
</style>
<script type="text/javascript">
	function addOrder(item) {
		$("#usersList")
				.append(
						'<li>'
								+ '<p>Name:'
								+ item.userName
								+ '</p>'
								+ '<p>Password:'
								+ item.password
								+ '</p>'
								+ '<p><button id="rmvButton" class="remove" data-id="">Remove<button></p>'
								+ '</li>');
	}
	$(function() {
		$.ajax({
			type : 'GET',
			url : 'jqusers.html',
			contentType : 'application/json',
			dataType : 'json',
			success : function(data) {
				for (var i = 0; i < data.lengthk; i++) {
					var item = data[i];
					addOrder(item);
				}
			},
			error : function(ts) {
				alert(ts.responseText);
			}
		});
		var $un = $("#uname");
		var $pw = $("#password");
		$("#buttonAdd").on("click", function() {
			var user = {
				"userName" : $un.val(),
				"password" : $pw.val()
			}

			$.ajax({
				type : 'POST',
				url : 'jqusers.html',
				contentType : 'application/json',
				dataType : 'json',
				data : JSON.stringify(user),
				success : function(data) {
					var item = data[0];
					if (item == "faile") {
						alert("Not saved!")
					} else {
						addOrder(item);
						$("#uname").val("");
						$("#password").val("");
					}
				},
				error : function(ts) {
					alert(ts.responseText);
				}
			});
		});
	});
</script>
</head>
<body>
	<br>
	<br>
	<br> JQuery test comes here New Users
	<ul id="usersList">
	</ul>
	<h4>Add User</h4>
	<div id="divForm">
		<div>
			<label id="unameId" for="uname">User name:</label><input id="uname" />
		</div>
		<div>
			<label id="passwordId" for="password">Password:</label><input
				id="password" />
		</div>
		<button id="buttonAdd">Add</button>
	</div>

</body>
</html>