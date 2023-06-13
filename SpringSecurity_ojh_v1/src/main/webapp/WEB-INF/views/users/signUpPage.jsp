<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원가입</title>
<%@ include file="../common/common_top.jsp"%>
<%
	String[] genderArr = {"남자", "여자"};
%>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/* 아이디 중복체크 */
	$(document).ready(function(){
		var isCheck = false;
		var use = "";
		$('#userId_check').click(function(){ // 중복체크 버튼 눌렀을 때
			//alert(1);
			isCheck = true;
			$.ajax({
				url : '/users/user/userId_check.us',
				data : ({
					input_userId : $('input[name=userId]').val()
				}),
				success : function(data){ //사용가능 yes , 불가능 no
					if($('input[name=userId]').val()==""){
						$('#userId_check_result').html("<font color='red' size='3px'>아이디를 입력하세요.</font>");
						$('input[name=userId]').focus();
					}else if(data == 'NO'){
						$('#userId_check_result').html("<font color='red' size='3px'>이미 등록된 아이디입니다.</font>");
						$('#userId_check_result').show();
						use = "impossible";
					}else if(data == 'YES'){
						$('#userId_check_result').html("<font color='blue' size='3px'>사용가능한 아이디입니다.</font>");
						$('#userId_check_result').show();
						use = "possible";
					}
				}//success
			});//ajax
		});//click
		
		$('#userId').keydown(function(){
			$('#userId_check_result').css('display', 'none');
		});//keydown
		
		$('input[name=submit]').click(function(){ //등록하기 클릭했을때
			if(!isCheck){
				alert('아이디 중복체크는 필수입니다.');
				return false;
			}
			if($('input[name=userId]').val() == ""){
				alert('아이디를 입력하세요');
				return false;
			}
			if(use == 'impossible'){
				alert('중복된 아이디입니다');
				$('input[name=userId]').select();
				return false;
			}
			
		});//click
	})//ready
	/*//아이디 중복체크 */
	
	/* 연락처 자동 하이픈 처리 */
	function formatPhoneNumber(input) {
	    var phoneNumber = input.value.replace(/-/g, ''); // 하이픈 제거
	
	    // 패턴 설정
	    var pattern = /^(\d{3})(\d{3,4})(\d{4})$/;
	 	// 사용자가 입력한 연락처가 숫자인지 판별 - 숫자이면 하이픈추가, 숫자가 아니면 하이픈추가X
	 	// isNaN - 매개변수가 숫자가 아니면 true, 숫자이면 false를 반환
	    if (!isNaN(phoneNumber)) {
	        // 하이픈 삽입
	        input.value = phoneNumber.replace(pattern, '$1-$2-$3');
	    }
	}
	/*//연락처 자동 하이픈 처리 */
	
	/* 카카오 API를 이용한 주소불러오기 */
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("addresssExtra").value = extraAddr;
                
                } else {
                   // document.getElementById("addresssExtra").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addressSub").focus();
            }
        }).open();
    }
    /*//카카오 API를 이용한 주소불러오기 */

</script>
<style>
	.err{
		font-size : 7px;
		color: red;
		font-weight : bold;
	}
</style>

<h1>signUpPage.jsp</h1>
<!-- SignUp Start -->
<form:form commandName="userBean" name="signUpform" action="/login/all/signUp.lg" method="post">

<div class="container-fluid py-5">
    <div class="container">
        <div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
            <p class="fs-5 fw-bold text-primary"></p>
            <h1 class="display-5 mb-5">회원가입</h1>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="bg-light rounded p-4 p-sm-5 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="row g-3">
                    <!-- 입력받는 값이 아닌 칼럼 
                    - 등급(user_role) default r01 → '일반'(관리자등급의 계정 추가는 관리자페이지에서)
					- 회원가입일(regdate) sysdate
					- 회원상태값(status) - defalut Y → '가입'
                    -->
                    
                    	<!-- userId - 아이디 -->
                    	<div class="col-6">
                    		<h5>아이디</h5> 
                            <div class="form-floating">
                                <input type="text" class="form-control" name="userId" id="userId" 
                                value="${userBean.userId}" autofocus> 
                                <label for="userId">아이디</label>
                            </div>
                            <form:errors cssClass="err" path="userId"/>
                        </div>
                        
                        <!-- //userId - 아이디 -->
                        <!-- userId_check - 아이디 중복체크 -->
                    	<div class="col-6">
                    		<h5>라인맞추기</h5> 
                            <input type="button" class="btn btn-secondary btn-sm" value="중복체크" id="userId_check">
                            <span id="userId_check_result"></span>
                        </div>
                        
                        <!-- //userId_check - 아이디 중복체크 -->
                        <!-- password - 비밀번호 -->
                    	<div class="col-12">
                    		<h5>비밀번호</h5>
                            <div class="form-floating">
                                <input type="text" class="form-control border-0" name="password" id="password" 
                                value="${userBean.password}" autofocus> 
                                <label for="password">비밀번호</label>
                            </div>
                            <form:errors cssClass="err" path="password"/>
                        </div>
                        <!-- //password - 비밀번호 -->
                        
                        <!-- name - 이름 -->
                    	<div class="col-12">
                    		<h5>이름</h5>
                            <div class="form-floating">
                                <input type="text" class="form-control border-0" name="name" id="name" 
                                value="${userBean.name}" autofocus> 
                                <label for="name">이름</label>
                            </div>
                            <form:errors cssClass="err" path="name"/>
                        </div>
                        <!-- //name - 이름 -->
                        
                        <!-- birth - 생년월일 -->
                    	<div class="col-12">
                    		<h5>생년월일</h5>
                            <div class="form-floating">
                                <input type="text" class="form-control border-0" name="birth" id="birth" 
                                 value="${userBean.birth}" autofocus> 
                                <label for="birth">생년월일</label>
                            </div>
                            <form:errors cssClass="err" path="birth"/>
                        </div> 
                        <!-- //birth - 생년월일 -->
                        
                        <!-- gender - 성별 -->
                    	<div class="col-12">
	                    	<h5>성별</h5>
	                        <div class="form-floating">
                        		<c:set var="gender" value="<%= genderArr %>"/>
                        		<c:forEach var="gender" items="${gender}">
                        			<input type="radio" class=" form-check-input border-0" name="gender" id="gender" value="${gender}"
										<c:if test="${userBean.gender eq gender}">checked</c:if>
									>${gender} &nbsp;&nbsp;&nbsp;
                        		</c:forEach>
	                        </div>
                            <form:errors cssClass="err" path="gender"/>
                        </div>
                        <!-- //gender - 성별 -->
                        
                        <!-- email - 이메일 -->
                        <div class="col-md-12">
	                        <h5>이메일</h5>
	                         <div class="form-floating">
	                            <input type="text" class="form-control" name="email" id="email" 
									value="${userBean.email}" autofocus> 
	                             <label for="email">이메일</label>
	                         </div>
	                         <form:errors cssClass="err" path="email"/>
                         </div>
                        <!-- //email - 이메일 -->
                        
                        <!-- phone - 연락처 -->
                        <div class="col-12">
						    <h5>연락처</h5>
						    <div class="form-floating">
						        <input type="tel" class="form-control border-0" name="phone" id="phone"
						            value="${userBean.phone}" placeholder="010-****-****"
						            oninput="formatPhoneNumber(this)" autofocus>
						        <label for="phone">연락처</label>
						    </div>
						    <form:errors cssClass="err" path="phone" />
						</div>
                       <!-- //phone - 연락처 -->
                       
                       <!-- address & addressSub - 주소 & 상세주소 -->
                       <div class="col-12">
	                       <h5>주소</h5>
	                       <div style="float: left; width: 50%;">
	                        	<input type="text" class="form-control border-0" name="postcode" id="postcode" >
	                       </div> 	
	                       <div  style="float: right; width: 40%;">	
                            	<input type="button" class="btn btn-success" onclick="execDaumPostcode()" value="우편번호 찾기">
	                       </div>
                       </div> 
                        <div class="col-12">
                            <div class="form-floating">
                            	<input type="text" class="form-control" name="address" id="address" 
                            	value="${userBean.address}">
                            	<label for="address">주소</label>
                            	<form:errors cssClass="err" path="address"/>
                         	</div> 
                        </div>		
                        <div class="col-12">
	                        <div class="form-floating">
								<input type="text" class="form-control" name="addressSub" id="addressSub" 
								value="${userBean.addressSub}" >
								<label for="addressSub">상세주소</label>
	                          	<form:errors cssClass="err" path="addressSub"/>
	                        </div> 
                        </div>		
						<!-- //address & addressSub - 주소 & 상세주소 -->      
						                  
                        <div class="col-12 text-center">
                        	<input type="reset" class="btn btn-primary py-3 px-4" value="취소">
                           	<input type="submit" name="submit" class="btn btn-primary py-3 px-4" value="회원가입">
                        </div>
                        
                    </div><!-- //row g-3 -->
                </div><!-- //bg-light rounded p-4 p-sm-5 wow fadeInUp -->
            </div><!-- //col-lg-7 -->
        </div><!-- //row justify-content-center -->
    </div><!-- //container -->
</div><!-- //container-fluid py-5 -->
</form:form>
<!-- SignUp End -->


<%@ include file="../common/common_bottom.jsp"%>
</html>