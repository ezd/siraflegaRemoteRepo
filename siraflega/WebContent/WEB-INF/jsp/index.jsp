<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
ul {
	padding: 0px;
	margin: 10px;
	list-style: none;
}

.mainTitle h2 {
	font-size: 24px;
	line-height: 28px;
	font-family: 'Open Sans', sans-serif;
	margin-bottom: 0px;
}

.subTitle {
	color: #111;
	font-family: 'Open Sans', sans-serif;
	font-size: 15px;
	font-weight: 400;
	line-height: 16px;
	margin: 0px;
}

.jobDescription {
	text-align: justify;
}
.pageBody {
	/* 	height: 470px; */
	min-height: 470px;
}
</style>
</head>
<body>
	<div class="col-md-8" >
	<div class="row pageBody">
		<ul>
			<c:forEach items="${postedJobs}" var="postedJob">

				<li><div class="mainTitle">
						<h2>
							<a href="${pageContext.request.contextPath}/jobPost/${postedJob.id}.html">${postedJob.position}</a>
						</h2>
					</div>
					<div class="subTitle">
						Company: <a href="index.php">${postedJob.company.name}</a>
						<p>Posted on:28, 2013 at 10:00 PM</p>
					</div>
					<div class="jobDescription">
						<p><c:set var="desc" value="${postedJob.discription}"/>
						${postedJob.discription}<a href="${pageContext.request.contextPath}/jobPost/${postedJob.id}.html">Read More</a></p>
					
					</div></li>
			</c:forEach>
		</ul>
</div>



		<!-- Pager -->
		<div class="row pageFooter">
		<input type="hidden" id="totalPageSize" value="${totalPageSize}">
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
								<li class="" id="${i}">
							</c:when>
						</c:choose>
						<a
							href="${pageContext.request.contextPath}/jobPosts/all/${i}.html"><c:out
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
</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
	$('#jobsPagination li').click(
			function() {
				var selectedLi = $('#jobsPagination li.active');
				var selectedId=$(this).attr('id');
				if ($(this).attr('id') == 'previousPage') {
					if ($(selectedLi).prev().attr('id') != 'previousPage') {
						window.location.replace(selectedLi.prev()
								.children('a').attr('href'));
						
					}
				} else if ($(this).attr('id') == 'nextPage') {
					if ($(selectedLi).next().attr(
							'id') != 'nextPage') {
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


