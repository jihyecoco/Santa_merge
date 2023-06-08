<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %>  
<style type="text/css">
	.err{
		color:red;
		font-weight: bold;
		font-size: 9px;
	}
</style>

    <!-- boardInsertForm.jsp<br> -->
    
<%
	String[] cateArr = {"정보","후기","추천","잡담"};
%>

<center>
<form:form commandName="board" action="/board/user/insert.br" method="post" enctype="multipart/form-data">
<div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <p class="fs-5 fw-bold text-primary"></p>
                <h1 class="display-5 mb-5">자유게시판 글쓰기</h1>
            </div>
<table border="1" class="table">
	<tr>
		<td>이름</td>
		<td>
			<input type="text" name="userid" size="60" value="${board.userid}">
			<form:errors cssClass="err" path="userid"/>
		</td>
	</tr> 
	<tr class="col-sm-6">
		<td>카테고리</td>
		<td>
			<select name="category">
				<option value="">선택하세요</option>
				<c:forEach var="cate" items="<%= cateArr%>">
					<option value="${cate}" <c:if test="${board.category == cate}">selected</c:if>>${cate}
				</c:forEach>
			</select>
			<form:errors cssClass="err" path="category"/>
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>
			<input type="text" name="subject" size="70" value="${board.subject}">
			<form:errors cssClass="err" path="subject"/>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="content" rows="20" cols="70">${board.content}</textarea>		
			<form:errors cssClass="err" path="content"/>
		</td>	
	</tr>
	<tr>
		<td>이미지</td>
		<td>
			<input type="file" name="upload" id="upload">
			<form:errors cssClass="err" path="image"/>
		</td>
	</tr>
	<tr height="30">
		<td colspan="2" align="center">
			<input type="submit" value="글쓰기" class="btn btn-success">
			<input type="reset" value="다시작성" class="btn btn-success">
			<input type="button" value="목록" class="btn btn-success" onclick="location.href='/board/all/list.br?pageNumber=${pageNumber}'">
		</td>
	</tr>
</table>
        </div>
    </div>
</form:form>
</center>  

<%@ include file="../common/common_bottom.jsp"%> 
