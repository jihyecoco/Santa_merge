<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %> 

    <!-- noticeList.jsp<br> -->

<!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">공지사항</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                </ol>
            </nav>
        </div>
    </div>
<!-- Page Header End -->    
    

<center>
<!-- Projects Start -->
<div class="container-xxl py-5">
	<div class="container">
		<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
			<p class="fs-5 fw-bold text-primary"></p>
            <h3 class="display-5 mb-5">공지사항 게시판</h3>
        </div> 

		<nav class="navbar navbar-light bg-light">
  			<div class="container" style="display:table-cell; vertical-align:middle;">
   				<form class="d-flex" action="/notice/all/list.no" method="post">
   				 	<div class="col-sm-2">
	   				 	<select name="whatColumn" class="form-select">
							<option value="">전체검색
							<option value="subject">제목
							<option value="content">내용
	   				 	</select>
   				 	</div>
   				 	<div class="col-sm-8">
     					<input class="form-control me-2" type="text" name="keyword">
      				</div>
      				<div class="col-sm-2" align="center">
      					<button class="btn btn-outline-success" type="submit">Search</button>
      				</div>
    			</form>
 			 </div>
		</nav><br>
<table border="1" class="table">
	<tr>
		<th>글번호</th>
		<th>작성자</th>
		<th>제목</th>
		<th>조회수</th>
		<th>작성일</th>		
	</tr>
	
	<c:if test="${fn:length(lists) == 0}">
		<tr>
			<td colspan="5" align="center">
				게시판에 게시된 글이 없습니다.
			</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty lists}">
	<c:forEach var="notice" items="${lists}">
		<tr>
			<td>${notice.num}</td>
			<td>${notice.userid}</td>
			<td><a href="detail.no?num=${notice.num}&pageNumber=${pageInfo.pageNumber}">${notice.subject}</a></td>
			<td>${notice.readcount}</td>
			<td>
				<fmt:parseDate var="newDay" value="${notice.regdate}" pattern="yyyy-MM-dd"/>				
				<fmt:formatDate var="fNewDay" value="${newDay}" pattern="yyyy-MM-dd"/>
				${fNewDay }
			</td>		
		</tr>
	</c:forEach>
	</c:if>
	<tr>
		<td colspan="5" align="right">
			<input type="button" value="글쓰기" class="btn btn-success" onclick="location.href='/notice/admin/insert.no?pageNumber=${pageInfo.pageNumber}'">
		</td>
	</tr>
</table><br>
${pageInfo.pagingHtml}
</center>    
     </div>
</div>
<%@ include file="../common/common_bottom.jsp"%>
