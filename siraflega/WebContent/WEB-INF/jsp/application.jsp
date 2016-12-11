<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style type="text/css">
.outPutRow {
	margin: 10px 5px;
}

.mainTiltle h4 {
	color: #7c795d;
	font-family: "Trocchi", serif;
	font-size: 26px;
	line-height: 20px;
	margin: 0;
	text-align: center;
	font-weight: bold;
	text-decoration: underline;
}
</style>

</head>
<body>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<div class="row outPutRow ">
				<div class="col-xs-12 mainTiltle" style="margin: 0px; padding: 0px;">
					<h4>To whom it may Concern</h4>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<p class="values" id="jobSummary">${employee.summary}
						<input type="hidden" id="jobId" value="${postedJob.id}"> <input
							type="hidden" id="empId" value="${employee.id}">
					</p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<p class="values">
						I am writing to you to express my interest in the <strong>
							${postedJob.position} </strong> position at <strong>${postedJob.company.name}</strong>
						currently posted on <strong>Siraflega&copy;</strong>.
					</p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<button class="btn btn-link" data-toggle="modal"
						data-target="#letterModal" id="addLetter">
						<span class="glyphicon glyphicon-pencil" id="btnSign"
							style="float: right;"></span> <span id="btnText">State
							your reason for being a good fit for the position...</span>
					</button>
					<p class="values" id="letterPr">${application==null?'':application.letter}</p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<p class="values">
						With best regards,<br> <span
							style="text-transform: capitalize; font-weight: bold"><c:out
								value="${employee.firstName} ${employee.middleName} ${employee.lastName}" /></span>
					</p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<p class="values">
						<c:choose>
							<c:when test="${isApplied eq true}">
							<span class="input-group-btn"><button class="btn btn-info" id="btnBack"><span class="glyphicon glyphicon-chevron-left"></span>You have applied, Go back!</button></span> 
							</c:when>
							<c:when test="${isApplied eq false}">
							<button class="btn btn-info" id="btnBack"><span class="glyphicon glyphicon-chevron-left"></span>Go back</button> 
							<button class="btn btn-primary" id="btnApply">Apply</button>
							</c:when>
						</c:choose>
						
					</p>
				</div>
			</div>


		</div>
		<div class="row pageFooter"></div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="letterModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Why you are a big
						fit for the position?</h4>
				</div>
				<div class="modal-body">
					<textarea id="letterTxt" maxlength="1200" rows="16" cols="76"
						placeholder="use less than 1200 caracters"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="saveChangeBtn">Save
						changes</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	$(document).ready(function() {
						$('#saveChangeBtn').on('click',
										function() {
											if ($('#letterTxt').html() != 'use less than 1200 caracters') {
												$('#btnText').html('');
												$("#btnSign").attr('class','glyphicon glyphicon-edit');
												$("#btnSign").css('float','right');
												$('#letterPr').val($('#letterTxt').val());
												$('#letterPr').html($('#letterTxt').html());

											}

											if ($('#letterTxt').html() == ''|| !$("#letterTxt").val()) {
												$('#btnText').html('State your reason for being a good fit for the position...');
												$("#btnSign").attr('class','glyphicon glyphicon-pencil');
												$("#btnSign").css('float','right');
												$('#letterPr').val('');
												$('#letterPr').html('');
											}

											$('#letterModal').modal('toggle');
										});

						$('#addLetter').on('click', function() {
							$('#letterTxt').val($('#letterPr').val());
							$('#letterTxt').html($('#letterPr').html());
						});
						$("#btnApply").on("click",
										function() {
											$.ajax({
														type : 'POST',
														url : '${pageContext.request.contextPath}/apply/',
														contentType : 'application/json',
														dataType : 'json',
														data : JSON.stringify({applicantId : $('#empId').val(),
																	jobId : $('#jobId').val(),
																	applicationLetter : $('#letterPr').val(),
																}),
														success : function(data) {
															window.location.replace('${pageContext.request.contextPath}/apply/'+ $('#jobId').val());
														},
														error : function(ts) {
															alert(ts.responseText);
														}
													});
										});
						$('#btnBack').on("click",function(){
							    window.history.go(-2);
						});
					});
</script>

