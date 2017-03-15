<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style type="text/css">
.hiddenRow {
	padding: 0 !important;
}

.outPutRow {
	margin: 10px 5px;
/* 	border-bottom: 1px dashed #ccc;; */
}
.mainTiltle h4{
 color: #7c795d; 
 font-family: 'Trocchi', serif; 
 font-size: 20px; 
 line-height: 20px; 
 margin: 0; 
 
}

.title {
	text-transform: capitalize;
	color: #7c795d; 
	font-weight: bold;
}

.values {
	text-align: justify;
}

.pageBody {
	/* 	height: 470px; */
	min-height: 470px;
}

</style>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
</head>
<body>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
											<div class="row outPutRow ">
												<div class="col-xs-12 mainTiltle" style="margin: 0px; padding: 0px;">
													<h4>${postedJob.position}, 
														${postedJob.company.name}</h4>
												</div>
											</div>
											<div class="row outPutRow">
												<div class="col-xs-3" align="right">
													<span class="title">Status:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">
														<c:choose>
															<c:when test="${postedJob.deadLine lt currentDate}">
																<span style="color: red">Deadline has passed</span>
															</c:when>
															
															<c:when test="${postedJob.deadLine ge currentDate}">
															<security:authorize access="hasRole('EMPLOYEE')">
<!-- 															/apply/{jobId} -->
																<span style="color: green">On progress<a href="${pageContext.request.contextPath}/apply/${postedJob.id}" style="float: right"><strong>Apply</strong></a></span>
															</security:authorize>
															</c:when>
															
														</c:choose>
													</p>
												</div>
											</div>
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
												<div class="col-xs-3 title" align="right">
													<span>phone:</span>
												</div>
												<div class="col-xs-9" style="margin: 0px; padding: 0px;">
													<p class="values">${postedJob.phone}</p>
												</div>
											</div>
										</div>
								</div>
</body>
</html>
