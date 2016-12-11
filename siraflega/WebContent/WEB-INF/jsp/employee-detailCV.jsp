<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../defs/lib-file.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="employeeDetail/scripts.jsp"%>
<style type="text/css">
.listOf {
	list-style: none;
	margin: 1px;
	padding: 5px;
}
</style>
</head>
<body>

	<!-- 	<div> -->
	<!-- 				<label for="cities">Cities Name: </label> <input id="cities"> -->
	<!-- 			</div> -->
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<div class="titile">
				<h2 style="display: block; overflow: hidden">
					<c:out
						value="${employee.firstName} ${employee.middleName} ${employee.lastName}" />
				</h2>
			</div>

			<strong class="dicorated">Age: </strong>${employee.age==0?'':employee.age }<br> <strong
				class="dicorated">Sex: </strong>${employee.sex=='F'?'Female':(employee.sex=='M'?'Female':'') }<br>
			<strong class="dicorated">Address: </strong>${employee.address }<br>
			<strong class="dicorated">Telephone: </strong>${employee.telephone}<br>
			<strong class="dicorated">E-mail: </strong>${employee.email}<br>
			<div style="text-align: justify;"><strong class="dicorated">Summary: </strong>${employee.summary}</div><br>
			<c:if test="${!isNewEmployee}">
<%-- 			<c:out value="${!isNewEmployee}"></c:out> --%>
				<div class="titleTwo">
					<span class="titleTwoText">Work experiences</span>
				</div>
				<ul id="workExpList" class="listOf">
					<c:forEach items="${employee.experiences}" var="experience">
						<li>
							<div class="titleThree">
								<h4>
									<span id="isCurrentLbl" style="font-family: cursive; font-size:medium;"><c:out value="${experience.currentlyWorking eq true?'Current:':'Previous:'}"/></span>
									<span id="workPostion"> ${experience.postion}</span>
								</h4>
							</div>
							<h5>
								<span id="workExpcompanyName">${experience.company.name}</span>
							</h5>
							<h6>
								<span id="startDateExp"><fmt:formatDate type="date"
										value="${experience.starts}" /> </span> - <span id="endDateExp"><fmt:formatDate
										type="date" value="${experience.ends}" /></span> | <span
									id="workExpCity">${experience.company.city}</span>,<span
									id="workExpCountry">${experience.company.country}</span>
							</h6> 
							<div class="descriptionText">${experience.discription}</div>
						</li>
					</c:forEach>
				</ul>


				<div class="titleTwo">
					<span class="titleTwoText">Educations</span>
				</div>

				<ul id="educationList" class="listOf">
					<c:forEach items="${employee.educations}" var="education">
						<li>
							<div class="titleThree">
								<span class="titleThreeText">${education.institute}</span>
							</div>
							<h5>
								<fmt:formatDate type="date" value="${education.startDate}" />
								–
								<fmt:formatDate type="date" value="${education.endDate}" />
								, ${education.level}, ${education.title}
							</h5>
							<div class="descriptionText">${education.remark}</div>
						<li>
					</c:forEach>
				</ul>
				<div class="titleTwo">
					<span class="titleTwoText">Skills</span>
				</div>

				<br>
				<table border="0" class="table table-hover" id="languageProfLevel">
					<thead
						style="background-color: #959697; color: #fff; font-weight: bold;">
						<tr>
							<td>Skill</td>
							<td>Proficiency Level</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${employee.languages}" var="language">
							<tr>
								<td>${language.name}</td>
								<td>${language.level}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
</body>
</html>
<!-- update employee modal starts -->
<%@ include file="employeeDetail/editPersonalInfoModal.jsp"%>
<!-- Modal2 -->
<%@ include file="employeeDetail/editWorkExpModal.jsp"%>
<!-- modal 2 ends -->
<!-- company modal starts -->
<!-- Modal -->
<%@ include file="employeeDetail/editCompanyModal.jsp"%>
<%@ include file="employeeDetail/deleteModal.jsp"%>
<%@ include file="employeeDetail/addEducationModal.jsp"%>
<%@ include file="employeeDetail/addLanguageModal.jsp"%>
