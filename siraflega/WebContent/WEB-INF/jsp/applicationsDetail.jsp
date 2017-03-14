<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
ul {
	padding: 0px;
	margin: 10px;
	list-style: none;
}

#jobdisplayarea {
	width: 98%;
	margin: 1%;;
	text-align: justify;
	padding: 2px;
	border-bottom: 1px solid #ccc;
	-webkit-box-shadow: 0px 0px 0.5px rgba(0, 0, 0, 0.1);
}

.pageBody {
	/* 	margin: 2px 5px; */
	margin-left: 2%;
	min-height: 470px;
}

.pageFooter {
	/* 	margin: 2px 5px; */
	margin-left: 5%;
}

.mainTitle {
	margin: 0px 2px;
	font-family: serif;
	font-size: medium;
}

.applicantSummary {
	font-size: 13px;
	font-family: 'Open Sans', sans-serif;
	color: #4A4A4A;
}

.applicantSummary p {
	margin: 2px;
}


.mainTitle h3 {
	font-size: 16px;
	font-family: 'Open Sans', sans-serif;
	line-height: 18px;
	margin: 0px 1px;
}
</style>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
</head>
<body>
	<div class="col-md-8">
		<!-- Blog Search Well -->

		

		<div class="row pageBody">
			<ul>
				<li><div class="container-fluid"
						style="background-color: #ECE9E6; margin: 2px 5px; padding: 5px; box-shadow: 1px 1px 2px grey;">
						<div class="input-group">

							<input type="text" class="form-control" id="jobsearchinput">
							<span class="input-group-btn">
								<button id="search" class="btn btn-default" type="button"
									style="height: 32px; margin: 0px;" placement="top"
									title="Filter">
									<span class="glyphicon glyphicon-filter"></span>
								</button>
							</span>
						

						</div>
						<!-- /.input-group -->
					</div></li>
				<c:forEach items="${applicants}" var="applicant">

					<li><div class="col-xs-12 col-md-12" id="jobdisplayarea">
							<div class="mainTitle">
								<a
									href="${pageContext.request.contextPath}/cv/${applicant.id}.html"><c:out
						value="${applicant.applicantFullName}" /></a>
							</div>

							<div class="applicantSummary">
								<p>
									${applicant.letter}... <a
										href="${pageContext.request.contextPath}/cv/${applicant.id}.html">read
										more</a>
								</p>

							</div>
						</div></li>
				</c:forEach>
			</ul>
		</div>

<input type="hidden" id="contextvalue" value="${pageContext.request.contextPath}" />

		<!-- Pager -->
		<div class="row pageFooter">
			<input type="hidden" id="totalPageSize" value="${totalPageSize}">
			<nav>
				<ul class="pagination" id="jobsPagination">
					<c:if test="${totalPageSize>1}">
						<li id="previousPage"><a href="${pageContext.request.contextPath}/applicationsDetail/${jobId}/${pageNumber>1?(pageNumber-1):1}.html" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${startat}" end="${endat}">
						<c:choose>
							<c:when test="${i == pageNumber}">
								<li class="active">
							</c:when>
							<c:when test="${i != pageNumber}">
								<li class="" id="${i}">
							</c:when>
						</c:choose>
						<a
							href="${pageContext.request.contextPath}/applicationsDetail/${jobId}/${i}.html"><c:out
								value="${i}" /> </a>
						</li>
					</c:forEach>
					<c:if test="${totalPageSize>1}">
						<li id="nextPage"><a href="${pageContext.request.contextPath}/applicationsDetail/${jobId}/${pageNumber<totalPageSize?(pageNumber+1):totalPageSize}.html" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
		<!-- Modal -->
	
</body>
</html>
<script type="text/javascript">
	$(document).ready(function() {//btnClose btnCancel

		

	});
</script>


