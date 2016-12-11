<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../defs/lib-file.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.listOf {
	list-style: none;
	margin: 1px;
	padding: 5px;
}
</style>
</head>
<body>
	<div class="col-md-8">
		<div class="container-fluid container-holder">
			<div class="titile">
				<security:authorize access="isAuthenticated()">
					<button type="button" class="btn btn-primary btn-lg"
						id="updateEmprInfo" data-toggle="modal"
						data-target="#editEmployerPersonalInfoModal"
						data-email="${employer.email}"
						data-firsName="${employer.firstName}"
						data-middleName="${employer.middleName}"
						data-lastName="${employer.lastName}"
						data-phone="${employer.telephone}">
						<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
					</button>
				</security:authorize>
				<h2 style="display: block; overflow: hidden">
					<span id="employerName"><c:out
							value="${empty employer.firstName?'Your name':employer.firstName} ${employer.middleName} ${employer.lastName}" />
					</span>
				</h2>
			</div>
			<input type="hidden" id="EmprId" value="${employer.id}" />
			<div class="titleThree">
				<h4>
					<span id="workPostion"> <c:out
							value="${empty currentWork.postion? 'Your position':currentWork.postion }"></c:out>
						at <c:out
							value="${empty currentWork.company.name? 'Your company':currentWork.company.name }"></c:out>
					</span>
				</h4>
			</div>
			<strong class="dicorated" >Telephone: </strong><span id="phone">${employer.telephone}</span><br>
			<strong class="dicorated">E-mail: </strong>${userEmail}<br>
			<c:if test="${!isNewEmployer}">
				<div class="titleTwo">
					<span class="titleTwoText">Work experiences</span>
					<security:authorize access="isAuthenticated()">

						<button type="button" class="btn triggerAdd" id="addEmployerWorkBtn"
							data-toggle="modal" data-target="#employerWorkExpModal">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</security:authorize>

				</div>
				<ul id="workExpList" class="listOf">
					<c:forEach items="${employer.works}" var="experience">
						<li>
							<div class="titleThree">
								<security:authorize access="isAuthenticated()">
									<button type="button"
										class="btn btn-danger btn-sm deleteWorkBtn"
										data-idToDelete="${experience.id}">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
									</button>
									<button type="button" class="btn btn-primary btn-sm trigerEdit"
										id="editWorkBtn" data-toggle="modal"
										data-target="#employerWorkExpModal" 
										data-id="${experience.id}"
										data-position="${experience.postion}"
										data-company="${experience.company.id}"
										data-start="${experience.startsFrom}"
										data-end="${experience.currentlyWorking=='true'?currentTime:experience.upto}"
										data-currentlyWorking="${experience.currentlyWorking}">
										<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
									</button>
								</security:authorize>
								<h4>
								<span id="isCurrentLbl" style="font-family: cursive; font-size:medium;"><c:out value="${experience.currentlyWorking eq true?'Current:':'Previous:'}"/></span>
									<span id="workPostion">${experience.postion}</span>
								</h4>
							</div>
							<h5>
								<span id="workExpcompanyName">${experience.company.name}</span>
							</h5>
							<h6>
								<span id="startDateExp"><fmt:formatDate type="date"
										value="${experience.startsFrom}" /> </span> 
										- 
								<span id="endDateExp"><fmt:formatDate type="date" 
										value="${experience.upto}" /></span> | 
								<span id="workExpCity">${experience.company.city}</span>,<span
									id="workExpCountry">${experience.company.country}</span>
							</h6>
						</li>
					</c:forEach>
				</ul>


			</c:if>
		</div>
	</div>
</body>
</html>
<%@ include file="employeeDetail/deleteModal.jsp" %>
<%@ include file="employerDetail/workExpModal.jsp"%>
<%@ include file="employerDetail/editPersonalInfoModal.jsp"%>
<%@ include file="employeeDetail/editCompanyModal.jsp"%>
<%@ include file="employerDetail/scripts.jsp"%>