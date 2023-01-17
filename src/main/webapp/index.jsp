<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<section id="background">
		<div id="centerContainer">
			<div id="welcomeBox">
				<div id="commaBox">Comma</div>
				<div id="commentBox">Rest and be comforted</div>
			</div>
			<div id="enrollAndLoginBox">
				<div id="enrollBox">
					<div id="agreeBox">By continuing you indicate that you agree to Comma’s Terms of Service and Privacy Policy.</div>
					<div id="naver_id_login" class="easyLogin"></div>
					<div id="signUpWithEmail" data-toggle="modal" data-target="#enroll_modal">Sign up with email</div>
				</div>
				<div>
					<form action="" id="loginFrm" name="loginFrm">
						<fieldset>
							<div id="loginTitle">Login</div>
							<label for="memberId">Email</label>
							<input type="email" id="memberId" name="memberId" placeholder="Your email" class="inputBar"/>
							<label for="Password">Password</label>
							<input type="text" id="password" name="password" placeholder="Your password" class="inputBar"/>
						</fieldset>
					</form>
					<div id="submitBox">
						<div id="searchPwd">
							<span>Forgot password?</span>
						</div>
						<input type="submit" value="Login" id="loginBtn" name="loginBtn" class="btnStyle">
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
			  <form action="" id="firstEnrollFrm">
				<fieldset>
					<div id="signUpTitle">Sign up</div>
					<label for="nickname">Nickname</label>
					<input type="text" id="nickname" name="nickname" placeholder="What would you like to be called?" class="inputBar">
					<label for="Email">Email</label>
					<input type="email" id="enrollMemberId" name="enrollMemberId" placeholder="Your email" class="inputBar"/>
				</fieldset>
			  </form>
			</div>
			
			<!-- Modal footer -->
			<div id="modalFooter">
			  <input type="button" value="Next" class="btnStyle">
			</div>
			
		</div>
	  </div>
	</div>
	<script>
		/*
		Date : 2023. 1. 17
		@장원정
		회원가입 모달창 open 메서드
		*/
		document.querySelector("#signUpWithEmail").addEventListener("click", (e)=>{
			document.querySelector("#enrollModal").style.display = "flex";
		});
	
		/*
		Date : 2023. 1. 17
		@장원정
		회원가입 모달창 close 메서드
		*/
		document.querySelector("#closeBtn").addEventListener("click", (e)=>{
			document.querySelector("#enrollModal").style.display = "none";
		});

		document.querySelector("#enrollModal").addEventListener("click", (e)=>{
			if(e.target !== e.currentTarget) return;
			document.querySelector("#enrollModal").style.display = "none";
		});
		
		/*
		Date : 2023. 1. 17
		@장원정
		회원가입 기재사항 미기재시 버튼 비활성화
		*/
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