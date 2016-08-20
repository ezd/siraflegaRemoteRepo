<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.hiddenRow {
	padding: 0 !important;
}

.outPutRow {
	margin: 10px 5px;
	border-bottom: 1px dashed #ccc;;
}

.title {
	text-transform: capitalize;
}

.values {
	text-align: justify;
}

.pageBody {
	/* 	height: 470px; */
	min-height: 470px;
}

button{
-webkit-border-radius: 0px;
-moz-border-radius: 0px;
border-radius: 0px;
}
.btn {
  border-radius:0;
}
</style>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
</head>
<body>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<!-- 			<table class="table table-hover"> -->
			<!-- 			<thead><tr><td>Position</td><td>Company</td><td>Applied Employees</td><td>Status</td><td></td></tr></thead> -->
			<!-- 			<tbody><tr><td>System analist and Software developer</td><td>Information and Network Security of Ethiopia</td><td>1989</td><td>Expierd</td><td><a href="viewJob"></a>etaile</td></tr></tbody> -->
			<!-- 			</table> -->
			<div class="row pageBody">
				<table class="table table-condensed"
					style="border-collapse: collapse;">
					<thead>
						<tr>
							<th></th>
							<th>Company</th>
							<th>Position</th>
							<th>Status</th>
							<th>#of Applied Employees</th>
							<th style="text-align: right;">
								<button class="btn btn-primary btn-sm" data-toggle="modal"
										data-target="#jobModal" id="addJob">Job
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>
							</th>
						</tr>
					</thead>
					<!--     style="border-collapse:collapse;" -->

					<tbody>
						<c:forEach items="${postedJobs}" var="postedJob">
							<tr>
								<div class="row">
									<td>
									<button
											class="btn btn-primary btn-sm accordion-toggle"
											data-toggle="collapse" data-target="#demo${postedJob.id}" >

											<span class="glyphicon glyphicon-menu-down"
												aria-hidden="true"></span>
										</button></td>
									<td>${postedJob.company.name}</td>
									<td><a href="${pageContext.request.contextPath}/jobPost/${postedJob.id}.html">${postedJob.position}</a></td>
									<td>
										<%-- 								${postedJob.deadLine}-${currentDate}- --%> <c:choose>
											<c:when test="${postedJob.deadLine lt currentDate}">
												<span style="color: red">Deadline has passed</span>
											</c:when>
											<c:when test="${postedJob.deadLine ge currentDate}">
												<span style="color: blue">On progress</span>
											</c:when>
										</c:choose>
									</td>
									<td class="text-sucyyyyyyyyyyss">$150.00</td>
									<td class="text-info">
										<div class="btn-group" style="width: 70px">
											<button class="btn btn-primary btn-sm pull-left" id="updateJobBtn"
											data-id="${postedJob.id}" data-discription="${postedJob.discription}"
											data-position="${postedJob.position}" data-sallery="${postedJob.sallery}"
											data-postedDate="${postedJob.postedDate}" data-deadLine="${postedJob.deadLine}"
											data-rqdSkills="${postedJob.rqdSkills}" data-rqdEducation="${postedJob.rqdEducation}"
											data-rqdExperianceyears="${postedJob.rqdExperianceyears}"
											data-howToApply="${postedJob.howToApply}" data-email="${postedJob.email}"
											data-phone="${postedJob.phone}" data-companyId="${postedJob.company.id}"
											>
												<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
											</button>
											<button class="btn btn-danger btn-sm pull-right deletePostedJobBtn"  data-id="${postedJob.id}" >
												<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
											</button>
										</div>
									</td>
								</div>
							</tr>
							<tr>
								<div class="row">
									<td colspan="6" class="hiddenRow">
										<div class="accordian-body collapse" id="demo${postedJob.id}">
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Description:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.discription}</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Salary:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.sallery}</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Posted date:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">
														<fmt:formatDate type="date"
															value="${postedJob.postedDate}" />
													</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Deadline: 
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">
														<fmt:formatDate type="date" value="${postedJob.deadLine}" />
													</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Required education:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.rqdEducation}</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Required skills:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.rqdSkills}</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Years of experience:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.rqdExperianceyears}</p>
												</div>
											</div>

											<div class="row outPutRow">
												<div class="col-xs-3 title" align="right">
													<span>How to apply:</span>
												</div>

												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.howToApply}</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3 title" align="right">
													<span>Email:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.email}</p>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span>phone:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.phone}</p>
												</div>
											</div>
										</div>

									</td>
								</div>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="row pageFooter">
				<nav>
				<ul class="pagination" id="jobsPagination">
					<c:if test="${totalPageSize>1}">
						<li id="previousPage"><a href="#" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${startat}" end="${endat}">
						<c:choose>
							<c:when test="${i == pageNumber}">
								<li class="active">
							</c:when>
							<c:when test="${i != pageNumber}">
								<li class="">
							</c:when>
						</c:choose>
						<a
							href="${pageContext.request.contextPath}/employerPosts/${i}.html"><c:out
								value="${i}" /> </a>
						</li>
					</c:forEach>
					<c:if test="${totalPageSize>1}">
						<li id="nextPage"><a href="#" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="jobModal.jsp" %>
<%@ include file="../employeeDetail/deleteModal.jsp" %>

<script type="text/javascript">
	$(document).ready(
			function() {
				//date formatter
				function formatedDate(unformatedDate) {
					var dt = unformatedDate.split('-');
					var y = dt[0];
					var m = dt[1];
					var d = dt[2];
					return d + "/" + m + "/" + y;
				}
				
				$('#addJob').click(function(){
					$('.prevCompanyId').val(1);
					$('#editCompany').val(1);
					$('#editCompany').selectpicker('render');
					
				});
				$('.deletePostedJobBtn').click(function(e) {
//			 		var parrentUli = $(this).parent().parent();
					$('#nameItemToBeDeleted').html("Posted Job");
					$('#deleteConfirmationMessage').html("Do you want the posted job to be deleted?");
					$('#deleteConfirmedBtn').attr('data-idToBeDelete',$(this).attr('data-id'));
					$('#deleteConfirmedBtn').attr('data-deleteItem','Posted Job');
// 					$('#deleteConfirmedBtn').attr('data-deleteIndex',selectedLisIndex);
					$('#delet_Modal').modal('toggle');
					
				});
				$('#updateJobBtn').click(function(){
					$('#jobId').val($(this).attr('data-id'));
					$('.prevCompanyId').val($(this).attr('data-companyId'));
					$('#editCompany').val($(this).attr('data-companyId'));
					$('#editCompany').selectpicker('render');
					$('#position').val($(this).attr('data-position'));
					$('#discription').val($(this).attr('data-discription'));
					$('#sallery').val($(this).attr('data-sallery'));
					var std = $(this).attr("data-postedDate").split(' ');
					var fmtStDt = formatedDate(std[0]);
					$('#postedDate').val(fmtStDt);
					var entd = $(this).attr("data-deadLine").split(' ');
					var fmtenDt = formatedDate(entd[0]);
					$('#deadLine').val(fmtenDt);
					$('#rqdSkills').val($(this).attr('data-rqdSkills'));
					$('#rqdEducation').val($(this).attr('data-rqdEducation'));
					$('#howToApply').val($(this).attr('data-howToApply'));
					$('#rqdExperianceyears').val($(this).attr('data-rqdExperianceyears'));
					$('#email').val($(this).attr('data-email'));
					$('#phone').val($(this).attr('data-phone'));
					$('#jobModal').modal('show');
					// 					$('#').val();
					
				});
				$('#jobsPagination li').click(
						function() {
							var selectedLi = $('#jobsPagination li.active');
							if ($(this).attr('id') == 'previousPage') {
								if ($('#jobsPagination li.active').prev().attr(
										'id') != 'previousPage') {
									// 				$(this).siblings('li').removeClass('active');
									// 				selectedLi.prev().addClass('active');
									window.location.replace(selectedLi.prev()
											.children('a').attr('href'));
								}
							} else if ($(this).attr('id') == 'nextPage') {
								if ($('#jobsPagination li.active').next().attr(
										'id') != 'nextPage') {
									// 				$(this).siblings('li').removeClass('active');
									// 				selectedLi.next().addClass('active');
									window.location.replace(selectedLi.next()
											.children('a').attr('href'));
								}
							} else {
								$(this).siblings('li').removeClass('active');
								$('#jobsPagination li.active').next().addClass(
										'active');
							}
						});
			});
</script>