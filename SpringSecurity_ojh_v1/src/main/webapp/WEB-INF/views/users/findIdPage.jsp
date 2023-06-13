<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- /login/all/loginPage.lg 에서 [아이디찾기] 클릭 
	 -> /login/all/findUserId.lg -> finIdPage.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>아이디찾기</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<%@ include file="../common/common_top.jsp"%>
<!-- onClick Start -->
<script type="text/javascript">
	//회원가입 
	function signUp(){
		//alert(1);
		location.href = "/login/all/signUp.lg";
	}
	
	function findUserId(){
		//alert(2);
		location.href = "/login/all/findUserId.lg";
	}
	
	function findPassword(){
		alert(3);
	}
</script>
<!-- //onClick End -->

	<!-- Login Start -->
	<div class="container-fluid py-5">
		<div class="container">
			<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s"
				style="max-width: 500px;">
				<!-- <p class="fs-5 fw-bold text-primary">로그인</p> -->
				<h1 class="display-5 mb-5">로그인</h1>
			</div>

			<div class="row justify-content-center">
				<div class="col-lg-7">
					<div class="bg-light rounded p-4 p-sm-5 wow fadeInUp"
						data-wow-delay="0.1s">
						<div class="row g-3 " >
							<form class="form-signin" action="/login.lg" method="POST">
								<div class="col-12 col-md-9 mx-auto">
									<div class="form-floating">
										<input type="text" name="userId" id="userId"
											class="form-control  border-0" placeholder="ID"  autofocus> 
										<label for="userId">ID</label>
									</div>
								</div>
								<br>
								<div class="col-12 col-md-9 mx-auto">
									<div class="form-floating">
										<input type="password" name="password" id="password"
											class="form-control border-0" placeholder="Password" autofocus>
										<label for="password">password</label>
									</div>
									<c:if test="${param.err == true}">
										<p style="color: red">ID와 Password를 확인해주세요.</p>
									</c:if>
								</div>
								<br>
								<div class="col-12 text-center" >
									<button class="btn btn-primary py-3 px-4" type="submit">로그인</button>
								</div>
								<br>
								<p>크기가 동일했으면 좋겠음
								<div class="col-12 text-center">
									<button class="btn btn-primary py-3 px-4" type="button" onclick="signUp()">회원 가입</button>
									<button class="btn btn-primary py-3 px-4" type="button" onclick="findUserId()">아이디찾기</button>
									<button class="btn btn-primary py-3 px-4" type="button" onclick="findPassword()">비밀번호찾기</button>
								</div>
							</form>
					
					
									
									
						</div><!-- row g-3 -->
					</div><!-- bg-light rounded p-4 p-sm-5 wow fadeInUp -->
					
					
				</div><!-- col-lg-7 -->
			</div><!-- row justify-content-center -->
		</div><!-- container -->
	</div><!-- container-fluid py-5-->
	<!-- //Login End -->


	<%@ include file="../common/common_bottom.jsp"%>

</html>