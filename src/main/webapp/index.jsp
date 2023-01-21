<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@page import="java.util.List"%>
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
    <% if(loginMember == null) { %>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
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
					<form action="<%= request.getContextPath() %>/member/login" id="loginFrm" name="loginFrm" method="POST">
						<fieldset>
							<div id="loginTitle" class="black fontStyle">Login</div>
							<label for="memberId" class="black fontStyle">Email</label>
							<input type="email" id="memberId" name="memberId" placeholder="Your email" class="inputBar"/>
							<label for="password" class="black fontStyle">Password</label>
							<input type="password" id="password" name="password" placeholder="Your password" class="inputBar"/>
						</fieldset>
						<div id="submitBox">
							<div id="searchPwd">
								<span class="pointColor fontStyle">Forgot password?</span>
							</div>
							<input type="submit" value="Login" id="loginBtn" name="loginBtn" class="btnStyle fontStyle">
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script>
		/*
		Date : 2023. 1. 21
		@장원정
		로그아웃 메서드
		*/
		document.querySelector("#logoutBtn").addEventListener("click", (e)=>{
			location.href = "<%= request.getContextPath() %>/member/logout";	
		});
	</script>
	<% } %>
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
					<input type="text" id="nickname" name="nickname" placeholder="4글자 이상 12글자 이하의 한글, 숫자, 영문자를 입력해주세요." class="inputBar" required />
					<span id="nickErrorMsg" class="errorMsg fontStyle"></span>
					<label for="email">이메일</label>
					<input type="email" id="email" name="email" placeholder="이메일을 입력해주세요." class="inputBar" required />
					<span id="emailErrorMsg" class="errorMsg fontStyle"></span>
				</fieldset>
				<fieldset id="secondEnrollFrm" class="enrollFset">
					<div id="signUpTitle">회원가입</div>
					<label for="code">인증번호</label>
					<input type="text" id="code" name="code" placeholder="이메일로 보낸 인증번호를 입력해주세요." class="inputBar" required />
				</fieldset>
				<fieldset id="thirdEnrollFrm" class="enrollFset">
					<div id="signUpTitle">회원가입</div>
					<label for="pwd">비밀번호</label>
					<input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요." class="inputBar" required />
					<span id="pwdErrorMsg" class="errorMsg fontStyle"></span>
					<label for="passwordCheck">비밀번호 확인</label>
					<input type="password" id="passwordCheck" name="passwordCheck" placeholder="비밀번호를 다시 입력해주세요." class="inputBar" required />
					<span id="pwdCErrorMsg" class="errorMsg fontStyle"></span>
				</fieldset>
				<fieldset id="fourthEnrollFrm" class="enrollFset">
					<div id="signUpTitle">회원가입</div>
					<label for="birth">생년월일</label>
					<input type="text" id="birth" name="birth" placeholder="생년월일 8자리를 입력주세요. (예 : 19930803)" class="inputBar" required />
					<span id="birthErrorMsg" class="errorMsg fontStyle"></span>
					<label for="gender">성별</label>
					<select name="gender" id="gender" class="inputBar" required >
						<option value="">성별</option>
						<option value="남자">남자</option>
						<option value="여자">여자</option>
					</select>
					<span id="genderErrorMsg" class="errorMsg fontStyle"></span>
				</fieldset>
			  </form>
			<!-- Modal footer -->
				<div id="modalFooter">
				  <button type="button" id="nextBtn" name="nextBtn" class="btnStyle">Next</button>
				</div>
			</div>
			
		</div>
	  </div>
	<script>	
		let cnt = 0; // 회원가입 폼 페이지 번호 변수
		const btn = document.querySelector("#nextBtn"); // 회원가입 폼 next 버튼
		let nextBool = 0; // next버튼 활성화
		let clientEmail = "";
		
		/*
		Date : 2023. 1. 17
		@장원정
		회원가입 모달창 open 메서드
		*/
		document.querySelector("#signUpWithEmail").addEventListener("click", (e)=>{
			document.querySelector("#enrollModal").style.display = "flex";
			
			document.querySelector("#firstEnrollFrm").style.display = "flex";
			document.querySelector("#secondEnrollFrm").style.display = "none";
			document.querySelector("#thirdEnrollFrm").style.display = "none";
			document.querySelector("#fourthEnrollFrm").style.display = "none";
			$("#enrollFrm")[0].reset();
			$(".errorMsg").html("");
			btn.disabled = true;
			e.target.value = "Next";
			e.target.type = "button";
			cnt = 0;
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
			if(e.target !== e.currentTarget){
				return;
			}
			document.querySelector("#enrollModal").style.display = "none";
		});
		
		/*
		Date : 2023. 1. 18
		@장원정
		회원가입 다음 폼 불러오기 메서드
		*/
		document.querySelector("#nextBtn").addEventListener("click", (e)=>{
			if(cnt === 0){
				document.querySelector("#firstEnrollFrm").style.display = "flex";
				document.querySelector("#secondEnrollFrm").style.display = "none";
				document.querySelector("#thirdEnrollFrm").style.display = "none";
				document.querySelector("#fourthEnrollFrm").style.display = "none";
				cnt = cnt + 1;
				return;
			}
			if(cnt === 1){
				emailCertify(clientEmail);
				/* btn.disabled = true; */
				
				document.querySelector("#firstEnrollFrm").style.display = "none";
				document.querySelector("#secondEnrollFrm").style.display = "flex";
				document.querySelector("#thirdEnrollFrm").style.display = "none";
				document.querySelector("#fourthEnrollFrm").style.display = "none";
				cnt = cnt + 1;
				return;
			}
			if(cnt === 2){
				btn.disabled = true;
				document.querySelector("#firstEnrollFrm").style.display = "none";
				document.querySelector("#secondEnrollFrm").style.display = "none";
				document.querySelector("#thirdEnrollFrm").style.display = "flex";
				document.querySelector("#fourthEnrollFrm").style.display = "none";
				cnt = cnt + 1;
				return;
			}
			if(cnt === 3){
				btn.disabled = true;
				document.querySelector("#firstEnrollFrm").style.display = "none";
				document.querySelector("#secondEnrollFrm").style.display = "none";
				document.querySelector("#thirdEnrollFrm").style.display = "none";
				document.querySelector("#fourthEnrollFrm").style.display = "flex";
				e.target.value = "Submit";
				e.target.type = "submit";
				cnt = cnt + 1;
				return;
			}
			if(cnt === 4){
				document.enrollFrm.submit();
				return;
			}
		});
		
		/*
		Date : 2023. 1. 18
		@장원정
		회원가입 유효성 검사 메서드
		*/
		
		$("#nickname").focusout((e)=>{
			const nickname = e.target.value;
			const nicknameErrorMsg = document.querySelector("#nickErrorMsg"); 
			nicknameErrorMsg.style.color = "tomato";
			
			// 아이디 유효성검사
			if(!/^[A-Za-z가-힣0-9]{4,12}$/.test(nickname)){
				nicknameErrorMsg.innerHTML = "사용할 수 없는 닉네임입니다.";
				nextBool = 0;
				return;
			}
			
			
			$.ajax({
				url : "<%= request.getContextPath() %>/member/selectAllMember",
				dataType: "json",
				success(data){
					const nicks = [];
					let bool = true;
					
					// 아이디 중복검사
					for(let i = 0; i < data.length; i++){
						nicks[i] = data[i].nickname;
					}
					
					nicks.forEach((nick)=>{
						console.log(nickname, typeof nickname, nick, typeof nick);
						if(nick === nickname){
							bool = false;
						} 
					}); // forEach end
					
					if(bool){
						// 성공 시
						nicknameErrorMsg.style.color = "green";
						nextBool = nextBool + 1;
						console.log(nextBool);
						nicknameErrorMsg.innerHTML = "사용가능한 닉네임입니다.";
					} else{
						// 실패 시
						nicknameErrorMsg.innerHTML = "이미 존재하는 닉네임입니다.";
						nextBool = 0;
					}
					
					if(nextBool === 2){
						btn.disabled = false;
						nextBool = 0;
					}
					
				},
				error : console.log
			}); // ajax end
			
		}); // 아이디검사 end
		
			
		$("#email").focusout((e)=>{
			const email = e.target.value;
			const emailErrorMsg = document.querySelector("#emailErrorMsg");
			emailErrorMsg.style.color = "tomato";
			
			// 이메일 유효성 검사
			if (!/^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/.test(email)) {
				emailErrorMsg.innerHTML = "유효하지 않는 이메일입니다.";
				btn.disabled = true;
		    	return;
		    };
		    
		    $.ajax({
				url : "<%= request.getContextPath() %>/member/selectAllMember",
				dataType: "json",
				success(data){
					const emails = [];
					let bool = true;
					
					// 이메일 중복검사
					for(let i = 0; i < data.length; i++){
						emails[i] = data[i].email;
					}
					
					emails.forEach((em)=>{
						console.log(em, email);
						if(email === em){
							bool = false;
						}
						
					}); // forEach end
					
					if(bool){
						// 성공 시
						emailErrorMsg.style.color = "green";
						nextBool = nextBool + 1;
						emailErrorMsg.innerHTML = "사용가능한 이메일입니다.";
						clientEmail = email;
					} else{
						// 실패 시
						emailErrorMsg.innerHTML = "이미 존재하는 이메일입니다.";
						nextBool = 0;
					}
					
				    if(nextBool === 2){
						btn.disabled = false;
						nextBool = 0;
					}
					
				},
				error : console.log
			}); // ajax end
			
		}); // 이메일검사 end
			
			
		$("#pwd").focusout((e)=>{
			const password = e.target.value;
			const pwdErrorMsg = document.querySelector("#pwdErrorMsg");
			pwdErrorMsg.style.color = "tomato";
			console.log(password);
			
		    // 숫자 검사
		    if(!/\d/.test(password)){
		    	pwdErrorMsg.innerHTML = "비밀번호는 하나 이상의 숫자를 반드시 포함해야 합니다.";
		    	nextBool = 0;
		        return;
		    }
		    
		    // 문자 검사
		    if(!/[a-zㅏ-ㅣㄱ-ㅎ]/i.test(password)){
		    	pwdErrorMsg.innerHTML = "비밀번호는 하나 이상의 문자를 반드시 포함해야 합니다.";
		    	nextBool = 0;
		        return;
		    }
		    
		    // 특수문자 검사
		    if(!/[!@#$%^&*()]/.test(password)){
		    	pwdErrorMsg.innerHTML = "비밀번호는 하나 이상의 특수문자를 반드시 포함해야 합니다.";
		    	nextBool = 0;
		        return;
		    }
			
			if(!/^[a-zㅏ-ㅣㄱ-ㅎ0-9!@#$%^&*()]{4,}$/i.test(password)){
				pwdErrorMsg.innerHTML = "비밀번호는 영문자/숫자/특수문자로 구성된 4글자이상이어야합니다.";
				nextBool = 0;
				return;
			}
			
			pwdErrorMsg.style.color = "green";
			nextBool = nextBool + 1;
			pwdErrorMsg.innerHTML = "사용가능한 비밀번호입니다.";
			
			if(nextBool === 2){
				btn.disabled = false;
				nextBool = 0;
			}
		}); // 비밀번호 검사 end
		
		
		$("#passwordCheck").focusout((e)=>{
			const pwd = document.querySelector("#pwd").value;
			const pwdCheck = e.target.value;
			const pwdCErrorMsg = document.querySelector("#pwdCErrorMsg");
			pwdCErrorMsg.style.color = "tomato";
			
			if(pwd !== pwdCheck){
				pwdCErrorMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
				nextBool = 0;
				return;
			}
			
			pwdCErrorMsg.style.color = "green";
			nextBool = nextBool + 1;
			pwdCErrorMsg.innerHTML = "비밀번호가 일치합니다.";
			
			if(nextBool === 2){
				btn.disabled = false;
				nextBool = 0;
			}
		}); // 비밀번호 일치검사 end
		
		$("#birth").focusout((e)=>{
			const birth = e.target.value;
			const birthErrorMsg = document.querySelector("#birthErrorMsg");
			birthErrorMsg.style.color = "tomato";
			
			const nowYear = new Date().getFullYear();
			
			const birthYear = birth.substr(0, 4);
			const birthMonth = birth.substr(4,2);
			const birthDate = birth.substr(7,2);
			
			let bool = true;
			
			if (birth.length <=8) {
				// 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다.
					if (1900 > birthYear || birthYear > nowYear){
						bool = false;
					} else if (birthMonth < 1 || birthMonth > 12) {
						bool = false;
					} else if (birthDate < 1 || birthDate > 31) {
						bool = false;
					} else if ((birthMonth==4 || birthMonth==6 || birthMonth==9 || birthMonth==11) && birthDate==31) {
						bool = false;
					} else if (birthMonth == 2) {

						const isleap = (birthYear % 4 == 0 && (birthYear % 100 != 0 || birthYear % 400 == 0));
						if (birthDate>29 || (birthDate==29 && !isleap)) {
							bool = false;
						} else {
							bool = true;
						} //end of if (day>29 || (day==29 && !isleap))
					} else {
						bool = true;
					}//end of if
				}
				else {
					//1.입력된 생년월일이 8자 초과할때 :  auth:false
					bool = false;
				}; // if end
				
				if(bool){
					// 성공시
					birthErrorMsg.style.color = "green";
					nextBool = nextBool + 1;
					birthErrorMsg.innerHTML = "유효한 생년월일입니다.";
				}else{
					// 실패시	
					birthErrorMsg.innerHTML = "유효하지 않는 생년월일입니다.";
					nextBool = 0;
					return;
				}
				
				if(nextBool === 2){
					btn.disabled = false;
					nextBool = 0;
				}
		}); // 생년월일 검사 end
		
		$("gender").focusout((e)=>{
			const gender = e.target.value;
			console.log(e.target);
			
			if(nextBool === 2){
				btn.disabled = false;
				nextBool = 0;
			}
		});
		
		/*
		Date : 2023. 1. 19
		@장원정
		이메일 인증 메서드
		*/
		const emailCertify = (clientEmail) => {
			
			const frmData = new FormData(document.cEmailFrm);
			
			$.ajax({
				url : "<%= request.getContextPath() %>/member/emailCertify",
    			data : {clientEmail},
    			dataType : "json",
    			success(data){
    				console.log(data);
    			},
    			error : console.log
			});
		};
		
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