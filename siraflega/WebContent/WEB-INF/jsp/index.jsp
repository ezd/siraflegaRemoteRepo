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
.jobDescription{
font-size: 12px;
font-family: 'Open Sans', sans-serif;
color: #4A4A4A;

}
.jobDescription p {
    margin: 2px;
}
.subTitle p {
    margin: 0px 2px;
}
.subTitle{
    font-size: smaller;
    font-family: initial;
}

.mainTitle h3 {
	font-size: 16px;
	font-family: 'Open Sans', sans-serif;
	line-height: 20px;
	margin: 1px;
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
								<button id="search" class="btn btn-default" type="button" style="height:32px;margin:0px;">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
						<!-- /.input-group -->
					</div></li>
				<c:forEach items="${postedJobs}" var="postedJob">

					<li><div class="col-xs-12 col-md-12" id="jobdisplayarea">
							<div class="mainTitle">
								<a href="${pageContext.request.contextPath}/jobPost/${postedJob.id}.html">${postedJob.position}</a>
							</div>

							<div class="jobDescription">
								<p>
									<c:set var="desc" value="${postedJob.discription}" />
									${postedJob.discription}... <a
										href="${pageContext.request.contextPath}/jobPost/${postedJob.id}.html">read
										More</a>
								</p>

							</div>
							<div class="subTitle">
								<p>For <a href="index.php">${postedJob.company.name}</a> 
								from <fmt:formatDate type="date" value="${postedJob.postedDate}" />
								to <fmt:formatDate type="date" value="${postedJob.deadLine}" />
							</div>
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
							href="${pageContext.request.contextPath}/jobPosts/${catigory}/${i}.html"><c:out
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
	$(document).ready(function() {
		$('#search').click(function(){
			var catValue=$('#jobsearchinput').val();
			if(catValue==null || catValue==""){
// 			alert("cat null");
// 			location.reload(true);
				window.location.replace('${pageContext.request.contextPath}/');
				
				}else{
					window.location.replace('${pageContext.request.contextPath}/jobPosts/'+catValue+'/1.html');
					}
			
			});
		$('#jobsPagination li').click(function() {
					var selectedLi = $('#jobsPagination li.active');
					var selectedId = $(this).attr('id');
					alert(selectedId.val());
					if ($(this).attr('id') == 'previousPage') {
						if ($(selectedLi).prev().attr('id') != 'previousPage') {
							window.location.replace(selectedLi.prev()
											.children('a')
											.attr('href'));
						}
					} else if ($(this).attr('id') == 'nextPage') {
						if ($(selectedLi).next().attr('id') != 'nextPage') {
							window.location.replace(selectedLi.next()
											.children('a')
											.attr('href'));
						}
					} else {
						$(this).siblings('li').removeClass('active');
						$('#jobsPagination li.active').next().addClass('active');

					}
				});

			$("#jobsearchinput").autocomplete({
				source : function(query, process) {
					$.ajax({
						type : 'GET',
						url : '/siraflega/catigories',
						contentType : 'application/json',
						dataType : 'json',
						data : {
							q : query.term
						},
						success : function(data) {
							process(data);
						},
						error : function(ts) {
							alert(ts.responseText);
						}
					});
				}
			});
			
		});
</script>


