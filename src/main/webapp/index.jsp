<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
	<section>
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
		로그인 후 화면 임시 메서드
		*/
		document.querySelector("#loginBtn").addEventListener("click", (e)=>{
			location.href = "<%= request.getContextPath() %>/counseling/counselingList"
		})
	</script>
</body>
</html>