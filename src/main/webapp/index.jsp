<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@page import="java.util.List"%>
<%@page import="member.model.service.MemberService" %>
    <section id="firstSection">
    	<div id="hello">
    		<p id="mainTitle" class="white fontStyle">&nbsp;쉼표 ,</p>
    		<p id="comment" class="white fontStyle">잠시 쉬었다 가세요.</p>
    	</div>
    </section>
    <section id="introSection">
    	<table>
    		<tbody>
    			<tr>
    				<td class="white fontStyle">고민이나 소소한 일상을 공유할 사람이 없나요?</td>
    				<td><img src="<%= request.getContextPath() %>/images/introImg1.jpeg" alt="" class="introImg"/></td>
    			</tr>
    			<tr>
    				<td><img src="<%= request.getContextPath() %>/images/introImg2.jpeg" alt="" class="introImg" /></td>
    				<td class="white fontStyle">밖에 나가 누군가를 만나는 건 힘들고 혼자있는 건 외로워 누군가와 소통하고 싶지 않나요?</td>
    			</tr>
    			<tr>
    				<td class="white fontStyle">인생 선배나 남자 혹은 여자에게만 얻고 싶은 조언이 있나요?</td>
    				<td><img src="<%= request.getContextPath() %>/images/introImg3.jpeg" alt="" class="introImg" /></td>
    			</tr>
    			<tr>
    				<td><img src="<%= request.getContextPath() %>/images/introImg4.jpeg" alt="" class="introImg" /></td>
    				<td class="white fontStyle">일기장에 소중한 순간을 기록하고 싶지는 않나요?</td>
    			</tr>
				<tr>
					<td colspan="2" id="gapBox"></td>
				</tr>
				<tr>
					<td colspan="2" class="white fontStyle" id="lastIntro">여러분을 위해 쉼표가 있습니다.</td>
				</tr>
    		</tbody>
    	</table>
    </section>
    <section id="background">
		<div id="centerContainer">
			<div id="welcomeBox">
				<div id="commaBox" class="pointColor fontStyle">잠시 쉬었다 가세요.</div>
			</div>
			<div id="enrollAndLoginBox">
				<div id="enrollBox">
					<div id="agreeBox" class="pointColor fontStyle">By continuing you indicate that you agree to Comma’s Terms of Service and Privacy Policy.</div>
					<div id="naver_id_login" class="easyLogin"></div>
					<div id="signUpWithEmail" class="fontStyle">Sign up with email</div>
				</div>
				<div>
					<form action="" id="loginFrm" name="loginFrm">
						<fieldset>
							<div id="loginTitle" class="black fontStyle">Login</div>
							<label for="memberId" class="black fontStyle">Email</label>
							<input type="email" id="memberId" name="memberId" placeholder="Your email" class="inputBar"/>
							<label for="Password" class="black fontStyle">Password</label>
							<input type="text" id="password" name="password" placeholder="Your password" class="inputBar"/>
						</fieldset>
					</form>
					<div id="submitBox">
						<div id="searchPwd">
							<span class="pointColor fontStyle">Forgot password?</span>
						</div>
						<input type="submit" value="Login" id="loginBtn" name="loginBtn" class="btnStyle fontStyle">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Modal-->
	<!-- The Modal -->
	<div id="enrollModal">
		<div id="modalDialog">
		  
			<!-- Modal Header -->
			<div id="modalHeader">
			  <div id="closeBtn">X</div>
			</div>
			
			<!-- Modal body -->
			<div id="modalBody">
			  <form action="" id="enrollFrm" name="enrollFrm">
				<fieldset id="firstEnrollFrm" class="enrollFset">
					<div id="signUpTitle">회원가입</div>
					<label for="nickname">닉네임</label>
					<input type="text" id="nickname" name="nickname" placeholder="쉼표에서 사용할 닉네임을 입력해주세요." class="inputBar">
					<label for="email">이메일</label>
					<input type="email" id="email" name="email" placeholder="이메일을 입력해주세요." class="inputBar"/>
				</fieldset>
				<fieldset id="secondEnrollFrm" class="enrollFset">
					<div id="signUpTitle">회원가입</div>
					<label for="code">인증번호</label>
					<input type="text" id="code" name="code" placeholder="이메일로 보낸 인증번호를 입력해주세요." class="inputBar">
				</fieldset>
				<fieldset id="thirdEnrollFrm" class="enrollFset">
					<div id="signUpTitle">회원가입</div>
					<label for="pwd">비밀번호</label>
					<input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요." class="inputBar">
					<label for="passwordCheck">비밀번호 확인</label>
					<input type="password" id="passwordCheck" name="passwordCheck" placeholder="비밀번호를 다시 입력해주세요." class="inputBar"/>
				</fieldset>
				<fieldset id="fourthEnrollFrm" class="enrollFset">
					<div id="signUpTitle">회원가입</div>
					<label for="birth">생년월일</label>
					<input type="password" id="birth" name="birth" placeholder="생년월일 6자리를 입력주세요. (예 : 930803)" class="inputBar">
					<label for="passwordCheck">성별</label>
					<select name="gender" id="gender" class="inputBar">
						<option value="">성별</option>
						<option value="남자">남자</option>
						<option value="여자">여자</option>
					</select>
				</fieldset>
			  </form>
			<!-- Modal footer -->
				<div id="modalFooter">
				  <input type="button" value="Next" id="nextBtn" name="nextBtn" class="btnStyle">
				</div>
			</div>
			
		</div>
	  </div>
	  <form action="" id="checkOverlapNickFrm" name="checkOverlapNickFrm">
	  	<input type="hidden" id="forCheckOverlapNick" name="forCheckOverlapNick"/>
	  </form>
	<script>
		window.onload = () =>{
			selectAllNickname();
		};
		
		const selectAllNickname = () => {
			$.ajax({
				url : "<%= request.getContextPath() %>/member/selectAllNickname",
				dataType: "json",
				successs(data){
					data.forEach((nick) => {
						console.log(nick);
					})
				},
				error: console.log
			});
		}
	
		let cnt; // 회원가입 폼 페이지 번호 변수
		
		/*
		Date : 2023. 1. 17
		@장원정
		회원가입 모달창 open 메서드
		*/
		document.querySelector("#signUpWithEmail").addEventListener("click", (e)=>{
			document.querySelector("#enrollModal").style.display = "flex";
			cnt = 0;
		});
	
		/*
		Date : 2023. 1. 17
		@장원정
		회원가입 모달창 close 메서드
		*/
		document.querySelector("#closeBtn").addEventListener("click", (e)=>{
			document.querySelector("#enrollModal").style.display = "none";
			cnt = 0;
		});

		document.querySelector("#enrollModal").addEventListener("click", (e)=>{
			if(e.target !== e.currentTarget) return;
			document.querySelector("#enrollModal").style.display = "none";
			cnt = 0;
		});
		
		/*
		Date : 2023. 1. 18
		@장원정
		회원가입 다음 폼 불러오기 메서드
		*/
		document.querySelector("#nextBtn").addEventListener("click", (e)=>{
			if(cnt === 0){
				document.querySelector("#fourthEnrollFrm").style.display = "none";
				document.querySelector("#firstEnrollFrm").style.display = "flex";
			}
			cnt = cnt + 1;
			if(cnt === 1){
				document.querySelector("#firstEnrollFrm").style.display = "none";
				document.querySelector("#secondEnrollFrm").style.display = "flex";
			}
			if(cnt === 2){
				document.querySelector("#secondEnrollFrm").style.display = "none";
				document.querySelector("#thirdEnrollFrm").style.display = "flex";
			}
			if(cnt === 3){
				document.querySelector("#thirdEnrollFrm").style.display = "none";
				document.querySelector("#fourthEnrollFrm").style.display = "flex";
				e.target.value = "Submit";
				e.target.type = "submit";
			}
			if(cnt === 4){
				e.target.value = "Next";
				e.target.type = "button";
				document.enrollFrm.submit();
			}
		});
		
		/*
		Date : 2023. 1. 18
		@장원정
		회원가입 유효성 검사 메서드
		*/
		$("#nickname").focusout((e)=>{
			console.log(nicks);
		});
		
			
			
			
			
		
		const email = document.querySelector("#email");
		const pwd = document.querySelector("#pwd");
		const passwordCheck = document.querySelector("#passwordCheck");
		const birth = document.querySelector("#birth");
		const gender = document.querySelector("#gender");
		
				
		
		/*
		Date : 2023. 1. 18
		@장원정
		회원가입 폼제출 메서드
		*/
		document.enrollFrm.onsubmit = (e) => {
			e.preventDefault();
			document.querySelector("#closeBtn").click();
		};
		
	</script>
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("QpkQpxEPEtiAfKtw0PUw", "http://localhost:8080/comma/");
		var state = naver_id_login.getUniqState();
		naver_id_login.setButton("white", 2,40);
		naver_id_login.setDomain("http://localhost:8080/comma/");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
	</script>
</body>
</html>