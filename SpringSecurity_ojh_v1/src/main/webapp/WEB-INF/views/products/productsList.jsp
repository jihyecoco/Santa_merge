<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common_top.jsp" %>
 <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center py-5">
            <h1 class="display-3 text-white mb-4 animated slideInDown">Projects</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Projects</li>
                </ol>
            </nav>
        </div>
    </div>
<!-- Page Header End -->

<!-- Projects Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <p class="fs-5 fw-bold text-primary">산타</p>
                <h1 class="display-5 mb-5">거래 게시판</h1>
            </div>
            
            <div align="right">
		    	<input type="button" class="btn btn-success" value="글쓰기" onclick="location.href='/products/user/insert.prd'">
		    	<br><br>
        	</div>
            
            <div class="col-12 text-center">
		    	<nav class="navbar navbar-light bg-light">
		  			<div class="container" style="display:table-cell; vertical-align:middle;">
		   				<form class="d-flex" action="list.bdcr" method="post">
		   					<div class="col-sm-2">
								<select name="whatColumn" class="form-select">
									<option value="">전체</option>
			   				 		<option value="name">제품명</option>
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
				</nav>
           	</div>
           	<br><hr><br>
           	
            <div class="row g-4 portfolio-container">
            	<c:forEach var="plist" items="${plist}">
            		<!-- 대표 이미지 하나 가져오기 -->
            		<c:set var="thumbnail" value="${fn:split(plist.image, ',')}"/>
            		<!-- //대표 이미지 하나 가져오기 -->
            		
                	<div class="col-lg-4 col-md-6 portfolio-item first wow fadeInUp" data-wow-delay="0.1s">
                		<div class="portfolio-inner rounded">
                			<img src="<%=request.getContextPath()%>/resources/images/products/${thumbnail[0]}" width="100%" height="300px">
                			<div class="portfolio-text">
                            	<h4 class="text-white mb-4">
                            		<c:if test="${plist.state == 1}">거래완료</c:if>
                            	</h4>
                            </div>
                		</div>
                		<br>
                		<table border="1" width="100%">
                			<tr>
                				<td width="30%" align="center">
			                		<c:if test="${plist.kind == 'a'}"><font color="blue">[판매]</font></c:if>
			                		<c:if test="${plist.kind == 'b'}"><font color="orange">[나눔]</font></c:if>
			                		<c:if test="${plist.kind == 'c'}"><font color="green">[교환]</font></c:if>
                				</td>
                				<td align="center">
			                		<a href ="detail.prd?num=${plist.productsnum}">${plist.name}</a>
                				</td>
                			</tr>
                			<tr>
                				<td colspan="2" align="center">
			                		<fmt:formatNumber value="${plist.price}" pattern="###,###"/>원
                				</td>
                			</tr>
                		</table>
                	</div>
            	</c:forEach>
            	
                   <%--  <div class="portfolio-inner rounded">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-1.jpg" alt="">
                        <div class="portfolio-text">
                            <h4 class="text-white mb-4">Landscaping</h4>
                            <div class="d-flex">
                                <a class="btn btn-lg-square rounded-circle mx-2" href="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-1.jpg" data-lightbox="portfolio"><i class="fa fa-eye"></i></a>
                                <a class="btn btn-lg-square rounded-circle mx-2" href=""><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>
                    
                <div class="col-lg-4 col-md-6 portfolio-item second wow fadeInUp" data-wow-delay="0.3s">
                    <div class="portfolio-inner rounded">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-2.jpg" alt="">
                        <div class="portfolio-text">
                            <h4 class="text-white mb-4">Pruning plants</h4>
                            <div class="d-flex">
                                <a class="btn btn-lg-square rounded-circle mx-2" href="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-2.jpg" data-lightbox="portfolio"><i class="fa fa-eye"></i></a>
                                <a class="btn btn-lg-square rounded-circle mx-2" href=""><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 portfolio-item first wow fadeInUp" data-wow-delay="0.5s">
                    <div class="portfolio-inner rounded">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-3.jpg" alt="">
                        <div class="portfolio-text">
                            <h4 class="text-white mb-4">Irrigation & Drainage</h4>
                            <div class="d-flex">
                                <a class="btn btn-lg-square rounded-circle mx-2" href="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-3.jpg" data-lightbox="portfolio"><i class="fa fa-eye"></i></a>
                                <a class="btn btn-lg-square rounded-circle mx-2" href=""><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 portfolio-item second wow fadeInUp" data-wow-delay="0.1s">
                    <div class="portfolio-inner rounded">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-4.jpg" alt="">
                        <div class="portfolio-text">
                            <h4 class="text-white mb-4">Garden Maintenance</h4>
                            <div class="d-flex">
                                <a class="btn btn-lg-square rounded-circle mx-2" href="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-4.jpg" data-lightbox="portfolio"><i class="fa fa-eye"></i></a>
                                <a class="btn btn-lg-square rounded-circle mx-2" href=""><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 portfolio-item first wow fadeInUp" data-wow-delay="0.3s">
                    <div class="portfolio-inner rounded">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-5.jpg" alt="">
                        <div class="portfolio-text">
                            <h4 class="text-white mb-4">Green Technology</h4>
                            <div class="d-flex">
                                <a class="btn btn-lg-square rounded-circle mx-2" href="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-5.jpg" data-lightbox="portfolio"><i class="fa fa-eye"></i></a>
                                <a class="btn btn-lg-square rounded-circle mx-2" href=""><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 portfolio-item second wow fadeInUp" data-wow-delay="0.5s">
                    <div class="portfolio-inner rounded">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-6.jpg" alt="">
                        <div class="portfolio-text">
                            <h4 class="text-white mb-4">Urban Gardening</h4>
                            <div class="d-flex">
                                <a class="btn btn-lg-square rounded-circle mx-2" href="<%=request.getContextPath()%>/resources/bootstrap/user/img/service-6.jpg" data-lightbox="portfolio"><i class="fa fa-eye"></i></a>
                                <a class="btn btn-lg-square rounded-circle mx-2" href=""><i class="fa fa-link"></i></a>
                            </div>
                        </div>
                    </div>
                </div> --%>
            </div>
        </div> 
     </div>
    <!-- Projects End -->
	
	
	
<%@ include file="../common/common_bottom.jsp" %>