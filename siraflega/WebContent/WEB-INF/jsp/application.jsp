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
				<p style="float:right">
					<input type="hidden" id="languageflag" value="${param.langoption}"/>
					<input type="radio" name="languageOption" value="english" > English
  					<input type="radio" name="languageOption" value="amharic"> አማርኛ
					</p>
					<h4 class="engContent">To whom it may Concern</h4>
					<h4 class="amharicContent">ለሚመለከተው</h4>
				</div>
			</div>
			<input type="hidden" id="jobId" value="${postedJob.id}"> 
			<input type="hidden" id="empId" value="${employee.id}">
			<br>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<c:choose>
					<c:when test="${empty employee or employee.summary ==''or empty employee.summary }"><p id="yoursummary"><a href="${pageContext.request.contextPath}/account.html?returnTo=apply&&jobid=${postedJob.id}">Your summary is not Complete. Please build your profile and apply again.</a></p></c:when>
					</c:choose>
					<p id="jobSummary">${employee.summary}<a href="${pageContext.request.contextPath}/account.html?returnTo=apply&&jobid=${postedJob.id}"><span class="glyphicon glyphicon-pencil" id="btnSign"></span></a></p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<p class="values engContent">
						I am writing to you to express my interest in the <strong>
							${postedJob.position} </strong> position at <strong>${postedJob.company.name}</strong>
						currently posted on <strong>Siraflega&copy;</strong>.
					</p>
					<p class="values amharicContent">ይህን ደብዳቤ ለመጻፍ የተነሳሳሁት <strong>Siraflega&copy;</strong> ድህረ ገጽ ላይ ባገኘሁት መረጃ መሰረት ነው：：
					 ባገኘሁት መረጃ መሰረት, <strong>${postedJob.company.name}</strong> ባለው ክፍት ቦታ <strong>${postedJob.position} </strong> አወዳድሮ ለመቅጠር እንደሚፈልግ ለመረዳት ችያለሁ：： 
					 
					
					</p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<p class="engContent">
					<span class="values letterPr" style="float: left;">${application==null?'':application.letter}</span>
					<button class="btn btn-link" data-toggle="modal"
						data-target="#letterModal" id="addLetter" style="float: left;">
						<span class="glyphicon glyphicon-pencil btnSign" 
							style="float: right;"></span> <span class="btnText">State
							your reason for being a good fit for the position...</span>
					</button>
					</p>
					<p class="amharicContent">
					<span class="values letterPr" style="float: left;">${application==null?'':application.letter}</span>
					<button class="btn btn-link" data-toggle="modal"
						data-target="#letterModal" id="addLetter" style="float: left;">
						<span class="glyphicon glyphicon-pencil btnSign" 
							style="float: right;"></span> <span class="btnText">ለምን ለክፍት ስራ ቦታው ጥሩ ተወዳዳሪ እንደሆንክ ግለጽ </span>
					</button>
					</p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					<input type="hidden" id="lettervalue"/>
					<p class="values engContent">
						With best regards,<br> <span
							style="text-transform: capitalize; font-weight: bold"><c:out
								value="${employee.firstName} ${employee.middleName} ${employee.lastName}" /></span>
					</p>
					<p class="values amharicContent">
						ከምስጋና ጋር።<br> <span
							style="text-transform: capitalize; font-weight: bold"><c:out
								value="${employee.firstName} ${employee.middleName} ${employee.lastName}" /></span>
					</p>
				</div>
			</div>
			<div class="row outPutRow">
				<div class="col-xs-12"
					style="margin: 0px; padding: 0px; text-align: justify;">
					
						<c:choose>
							<c:when test="${isApplied eq true}">
							 <p class="values engContent">
							Thank you. You have applied for this position.<span class="input-group-btn"><button class="btn btn-info" id="btnBack"><span class="glyphicon glyphicon-chevron-left"></span>Go back.</button></span> 
							</p>
							<p class="values amharicContent">
							እናመሰግናለን። ማመልከቻውን በሚገባ አጠናከዋል።<span class="input-group-btn"><button class="btn btn-info" id="btnBack"><span class="glyphicon glyphicon-chevron-left"></span>ተመለስ</button></span> 
							</p>
							</c:when>
							<c:when test="${isApplied eq false}">
							<button class="btn btn-info" id="btnBack"><span class="glyphicon glyphicon-chevron-left"></span>Go back</button> 
							<button class="btn btn-primary" id="btnApply">Apply</button>
							</c:when>
						</c:choose>
						
					
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
					<h4 class="modal-title engContent" id="myModalLabel">Why you are a big
						fit for the position?</h4>
					<h4 class="modal-title amharicContent" id="myModalLabel">ለምን ለስራው ተገቢ ምርጫ እንደሆንክ ግለጽ።</h4>
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
var langoption='english';
function changeLanguge(langoption) {
	if('amharic'==langoption){
		$('.engContent').css({'display':'none'});
		$('.amharicContent').css({'display':'block'});
		}else{
			$('.engContent').css({'display':'block'});
			$('.amharicContent').css({'display':'none'});
		}
	$("input[name='languageOption'][value=" + langoption + "]").prop('checked', true);
	
}
	$(document).ready(function() {
		//language opiton
		//langoption=$("input[name='languageOption']:checked").val();
// 		if(langoption==null || langoption==''){
			
// 		}
		langoption=$('#languageflag').val()==''?langoption:$('#languageflag').val();
		changeLanguge(langoption);
						$('#saveChangeBtn').on('click',
										function() {
							
											if (tinymce.get('letterTxt').getContent({ format: 'text'}) == '') {
												$(".btnSign").attr('class','glyphicon glyphicon-pencil');
												$(".btnSign").css('float','right');
												$('.letterPr').html('');
												$('#lettervalue').val('');
											}else { //($('#letterTxt').html() == ''|| !$("#letterTxt").val()) 
												$('.btnText').html('');
												$(".btnSign").attr('class','glyphicon glyphicon-edit');
												$(".btnSign").css('float','right');
// 												tinymce.get('letterTxt').getContent({ format: 'text' })
												$('.letterPr').text(tinymce.get('letterTxt').getContent({ format: 'text' }));
												$('.letterPr').html(tinymce.get('letterTxt').getContent({ format: 'text' }));
												$('#lettervalue').val(tinymce.get('letterTxt').getContent({ format: 'text' }));
											}

											$('#letterModal').modal('toggle');
										});

						$('#addLetter').on('click', function() {
							//tinyMCE.triggerSave();
							$('.letterTxt').val($('.letterPr').html());
							$('.letterTxt').html($('.letterPr').html());
							$('.letterTxt').text($('.letterPr').html());
							//tinymce.get('letterTxt').setContent($('#letterPr').html());
						});
						
						$("input[name='languageOption']").on("click",function(){
							langoption=$("input[name='languageOption']:checked").val();
							changeLanguge(langoption);
						});
						$("#btnApply").on("click",function() {
							if($("#empId").val()==null || $("#empId").val()==''){
								$('#yoursummary').css({'border-color':'red', 'border-width':"1px", 'border-style': 'solid'});
							}else{
								$('#yoursummary').css({'border-color':'black' , 'border-width':"1px", 'border-style': 'none'});
								var langoption=$("input[name='languageOption']:checked").val();
								$.ajax({
									type : 'POST',
									url : '${pageContext.request.contextPath}/apply/',
									contentType : 'application/json',
									dataType : 'json',
									data : JSON.stringify({applicantId : $('#empId').val(),
												jobId : $('#jobId').val(),
												applicationLetter : $('#lettervalue').val(),
											}),
									success : function(data) {
										window.location.replace('${pageContext.request.contextPath}/apply/'+ $('#jobId').val()+"?langoption="+langoption);
										
									},
									error : function(ts) {
										alert(ts.responseText);
									}
								});
								
							}
						});
						$('#btnBack').on("click",function(){
							    window.history.go(-2);
						});
					});
</script>

