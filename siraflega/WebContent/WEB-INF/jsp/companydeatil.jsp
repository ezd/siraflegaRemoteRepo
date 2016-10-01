
<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
.outPutRow {
	margin: 10px 5px;
	/* 	border-bottom: 1px dashed #ccc;; */
}

.title {
	text-transform: capitalize;
	color: #7c795d;
	font-weight: bold;
}

.values {
	text-align: justify;
}
.mainTiltle h3{
 color: #7c795d; 
 font-family: 'Trocchi', serif; 
 font-size: 30px; 
 line-height: 30px; 
 margin: 0; 
}
</style>
</head>
<body>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<div class="row outPutRow ">
				<div class="col-xs-12 mainTiltle" style="margin: 0px; padding: 0px;">
					<h3>Company Profile:</h3>
				</div>
			</div>
			<div class="row outPutRow ">

				<div class="col-xs-3" align="right">
					<span class="title">Name:</span>
				</div>
				<div class="col-xs-9" style="margin: 0px; padding: 0px;">
					<p class="values">${company.name}</p>
				</div>

			</div>
			<div class="row outPutRow ">

				<div class="col-xs-3" align="right">
					<span class="title">Area of focus:</span>
				</div>
				<div class="col-xs-9" style="margin: 0px; padding: 0px;">
					<p class="values">${company.areaOfFocus}</p>
				</div>

			</div>
			<div class="row outPutRow ">

				<div class="col-xs-3" align="right">
					<span class="title">Address:</span>
				</div>
				<div class="col-xs-9" style="margin: 0px; padding: 0px;">
					<p class="values">${company.address}</p>
				</div>

			</div>
			<div class="row outPutRow ">

				<div class="col-xs-3" align="right">
					<span class="title">City:</span>
				</div>
				<div class="col-xs-9" style="margin: 0px; padding: 0px;">
					<p class="values">${company.city}</p>
				</div>

			</div>
			<div class="row outPutRow ">

				<div class="col-xs-3" align="right">
					<span class="title">Country:</span>
				</div>
				<div class="col-xs-9" style="margin: 0px; padding: 0px;">
					<p class="values">${company.country}</p>
				</div>

			</div>
			<div class="row outPutRow ">

				<div class="col-xs-3" align="right">
					<span class="title">Telephone:</span>
				</div>
				<div class="col-xs-9" style="margin: 0px; padding: 0px;">
					<p class="values">${company.telephon}</p>
				</div>

			</div>
			<div class="row outPutRow ">

				<div class="col-xs-3" align="right">
					<span class="title">Web-site:</span>
				</div>
				<div class="col-xs-9" style="margin: 0px; padding: 0px;">
					<p class="values">
						<a href="http://${company.website}">${company.website}</a>
					</p>
				</div>

			</div>
		</div>

	</div>
</body>
</html>