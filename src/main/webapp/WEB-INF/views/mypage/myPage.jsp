<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<section>
		<div id="updateContainer">
			<div id="myPageTitle">
				<h1 class="pointColor fontStyle">마이페이지</h1>
			</div>
			<form action="<%= request.getContextPath() %>/member/memberUpdate" enctype="multipart/form-data" method="POST">
				<fieldset>
					<table>
						<tbody>
							<tr id="rowspanTr">
									<th>
										프로필 사진
									</th>
									<td>
										<div class="tdDiv">
												<img src=<% if(loginMember.getOriginalFilename() == null) { %>
														"<%= request.getContextPath() %>/images/default.png"
														<% } else{ %>
														"<%= request.getContextPath() %>/upload/profile/<%= loginMember.getRenamedFilename() %>" 
														<% } %> 
														alt="" id="profileImg" name="profileImg" />
										</div>
									</td>
							</tr>
							<tr>
								<th>
									이메일
								</th>
								<td class="inputTd fontStyle">
									<div class="tdDiv">
										<input type="text" id="email" name="email" value="<%= loginMember.getEmail() %>" class="updateInput" readonly/>
										<span id="errorMsg"></span>
									</div>
								</td>
							</tr>
							<tr>
								<th>
									닉네임
								</th>
								<td class="inputTd fontStyle">
									<div class="tdDiv">
										<input type="text" id="nickname" name="nickname" value="<%= loginMember.getNickname() %>" class="updateInput" readonly/>
										<span id="errorMsg"></span>
									</div>
								</td>
							</tr>
							<tr>
								<th>
									생년월일
								</th>
								<td class="inputTd fontStyle">
									<div class="tdDiv">
										<input type="text" id="birthday" name="birthday" value="<%= loginMember.getBirthday() %> (<%= loginMember.getAge() %>세)" class="updateInput" readonly/>
										<span id="errorMsg"></span>
									</div>
								</td>
							</tr>
							<tr>
								<th>
									성별
								</th>
								<td class="inputTd fontStyle">
									<div class="tdDiv">
										<input type="text" id="gender" name="gender" value="<%= loginMember.getGender() %>" class="updateInput" readonly/>
										<span id="errorMsg"></span>
									</div>
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td class="inputTd fontStyle" >
									<input type="button" id="password" name="password" value="비밀번호 변경" class="button fontStyle updateInput" />
								</td>
							</tr>
						</tbody>
					</table>
					<div id="buttonContainer">
						<input type="submit" value="정보수정" id="updateBtn" class="button fontStyle btnStyle" />
						<input type="button" value="취소" id="resetBtn" class="button fontStyle btnStyle"/>
						<input type="button" value="회원탈퇴" id="leaveBtn" class="button fontStyle btnStyle"/>
					</div>
					<input type="file" name="updateFile" id="updateFile" accept="image/*">
				</fieldset>
			</form>
		</div>
	</section>
	<!-- Modal-->
	<!-- The Modal -->
	<div class="Modal" id="updateModal" name="updateModal">
		<div class="modalDialog" id="updateModalDialog" name="updateModalDialog">
			<!-- Modal Header -->
			<div class="modalHeader" id="updateModalHeader" name="updateModalHeader">
			  <div class="closeBtn" id="updateCloseBtn" name="updateCloseBtn">X</div>
			</div>
			<!-- Modal body -->
			<div class="modalBody" id="updateModalBody" name="updateModalBody" >
			  <form action="<%= request.getContextPath() %>/member/updateMemberPwd" id="updateFrm" name="updateFrm" method="POST">
				<fieldset id="updatePwdFset">
					<div id="updatePwdTitle">비밀번호 변경</div>
					<label for="nowPassword" class="modalLabel">현재 비밀번호</label>
					<input type="password" id="nowPassword" name="nowPassword" placeholder="현재 	비밀번호를 입력해주세요." class="inputBar" required />
					<span id="nowPwdErrorMsg" class="errorMsg fontStyle"></span>
					<label for="newPassword" class="modalLabel">새 비밀번호</label>
					<input type="password" id="newPassword" name="newPassword" placeholder="새로운 비밀번호를 입력해주세요." class="inputBar" required />
					<span id="newPwdErrorMsg" class="errorMsg fontStyle"></span>
					<label for="newpasswordCheck" class="modalLabel">새 비밀번호 확인</label>
					<input type="password" id="newpasswordCheck" name="newpasswordCheck" placeholder="새로운 비밀번호를 다시 입력해주세요." class="inputBar" required />
					<span id="newPwdCErrorMsg" class="errorMsg fontStyle"></span>
				</fieldset>
				<div class="modalFooter" id="updateModalFooter" name="updateModalFooter">
				  <button type="submit" id="updateSubmitBtn" name="updateSubmitBtn" class="btnStyle">변경</button>
				</div>
			  </form>
			</div>
		</div>
	</div>
	<!-- Modal-->
	  
	<!-- Modal-->
	<!-- The Modal -->
	<div class="Modal" id="deleteModal" name="deleteModal">
		<div class="modalDialog" id="deleteModalDialog" name="deleteModalDialog">
			<!-- Modal Header -->
			<div class="modalHeader" id="deleteModalHeader" name="deleteModalHeader">
			  <div class="closeBtn" id="deleteCloseBtn" name="deleteCloseBtn">X</div>
			</div>
			<!-- Modal body -->
			<div class="modalBody" id="deleteModalBody" name="deleteModalBody">
			  <form action="<%= request.getContextPath() %>/member/deleteMember" id="deleteFrm" name="deleteFrm" method="POST">
				<fieldset id="deleteFset">
					<div id="deleteMemberTitle">회원탈퇴</div>
					<label for="deleteCheckPassword" class="modalLabel">비밀번호</label>
					<input type="password" id="deleteCheckPassword" name="deleteCheckPassword" placeholder="비밀번호를 입력해주세요." class="inputBar" required />
					<span id="deleteMemberErrorMsg" class="errorMsg fontStyle"></span>
				</fieldset>
				<div class="modalFooter" id="deleteModalFooter" name="deleteModalFooter">
				  <button type="submit" id="deleteSubmitBtn" name="deleteSubmitBtn" class="btnStyle">탈퇴</button>
				</div>
			  </form>
			</div>
		</div>
	</div>
	<!-- Modal-->
	<form action="" id="checkFrm" name="checkFrm">
		<input type="hidden" id="checkInput" name="checkInput"/>
	</form>
	<script>
	const leaveBtn = document.querySelector("#deleteSubmitBtn");
	
	/*
	Date : 2023. 1. 18
	@장원정
	회원탈퇴 메서드
	*/
	
	$("#deleteCheckPassword").focusout((e)=>{
		cnt1 = 0;
		const errorMsg = document.querySelector("#deleteMemberErrorMsg");
		errorMsg.style.color = "tomato";
		const checkInput = e.target.value;
		const loginId = "<%= loginMember.getEmail() %>";
		
		$.ajax({
			url : "<%= request.getContextPath() %>/member/passwordCheck",
			data : {checkInput, loginId},
			dataType : "json",
			success(data){
				if(data === "<%= loginMember.getPassword() %>"){
					errorMsg.style.color = "green";
					errorMsg.innerHTML = "현재 비밀번호와 일치합니다.";
					leaveBtn.disabled = false;
				} else{
					errorMsg.innerHTML = "현재 비밀번호와 일치하지 않습니다.";
					leaveBtn.disabled = true;
				}
			},
			error : console.log
		});
		
		if(cnt1 === 1 && cnt2 === 1 && cnt3 === 1){
			updatePwdBtn.disabled = false;
		}
	}); // 현재 비밀번호 일치유무 검사 end
	
	/*
	Date : 2023. 1. 18
	@장원정
	취소버튼 메서드
	*/
	document.querySelector("#resetBtn").addEventListener("click", (e)=>{
		document.querySelector("#profileImg").src = "<%= request.getContextPath() %>/upload/profile/<%= loginMember.getRenamedFilename() %>";
		document.querySelector("#nickname").value = "<%= loginMember.getNickname() %>";
		document.querySelector("#errorMsg").style.display = "none";
	});
	
	const updateBtn = document.querySelector("#updateBtn");
	const updatePwdBtn = document.querySelector("#updateSubmitBtn");
	updateBtn.disabled = true;
	
	/*
	Date : 2023. 1. 24
	@장원정
	프로필 이미지 첨부 메서드
	*/
	document.querySelector("#profileImg").addEventListener("click", (e)=>{
		document.querySelector("#updateFile").click();
	});
	
	document.querySelector("#updateFile").addEventListener("change", (e)=>{
		const reader = new FileReader();
		const file = e.target;
		
		if(file.files[0]){
			reader.readAsDataURL(file.files[0]);
			reader.onload = (e) => {
				document.querySelector("#profileImg").src = e.target.result;
				updateBtn.disabled = false;
			};
		} else{
			document.querySelector("#profileImg").src = <% if(loginMember.getOriginalFilename() == null) { %>
				"<%= request.getContextPath() %>/images/default.png"
				<% } else{ %>
				"<%= request.getContextPath() %>/upload/profile/<%= loginMember.getRenamedFilename() %>" 
				<% } %>;
			updateBtn.disabled = true;
		}
		
	});
	
	/*
	Date : 2023. 1. 24
	@장원정
	모달창 open 메서드
	*/
	
	// 비밀번호 변경 모달
	document.querySelector("#password").addEventListener("click", (e)=>{
		document.querySelector("#updateModal").style.display = "flex";
		
		$("#updateFrm")[0].reset();
		$(".errorMsg").html("");
		updatePwdBtn.disabled = true;
		e.target.value = "비밀번호 변경";
	});
	
	// 회원탈퇴 모달
	document.querySelector("#leaveBtn").addEventListener("click", (e)=>{
		alert("정말로 탈퇴하시겠습니까?");
		document.querySelector("#deleteModal").style.display = "flex";
		
		$("#deleteFrm")[0].reset();
		$(".errorMsg").html("");
		leaveBtn.disabled = true;
	});
	
	/*
	Date : 2023. 1. 24
	@장원정
	모달창 close 메서드
	*/
	
	// 비밀번호 변경 모달
	document.querySelector("#updateCloseBtn").addEventListener("click", (e)=>{
		document.querySelector("#updateModal").style.display = "none";
	});
	document.querySelector("#updateModal").addEventListener("click", (e)=>{
		if(e.target !== e.currentTarget){
			return;
		}
		document.querySelector("#updateModal").style.display = "none";
	});
	
	// 회원탈퇴 모달
	document.querySelector("#deleteCloseBtn").addEventListener("click", (e)=>{
		document.querySelector("#deleteModal").style.display = "none";
	});
	document.querySelector("#deleteModal").addEventListener("click", (e)=>{
		if(e.target !== e.currentTarget){
			return;
		}
		document.querySelector("#deleteModal").style.display = "none";
	});
	
	/*
	Date : 2023. 1. 24
	@장원정
	비밀번호 변경 유효성 검사
	*/
	
	// 버튼 활성화 검사 변수
	let cnt1 = 0;
	let cnt2 = 0;
	let cnt3 = 0;
	
	$("#nowPassword").focusout((e)=>{
		cnt1 = 0;
		const errorMsg = document.querySelector("#nowPwdErrorMsg");
		errorMsg.style.color = "tomato";
		const checkInput = e.target.value;
		const loginId = "<%= loginMember.getEmail() %>";
		
		$.ajax({
			url : "<%= request.getContextPath() %>/member/passwordCheck",
			data : {checkInput, loginId},
			dataType : "json",
			success(data){
				if(data === "<%= loginMember.getPassword() %>"){
					errorMsg.style.color = "green";
					errorMsg.innerHTML = "현재 비밀번호와 일치합니다.";
					cnt1 = 1;
				} else{
					errorMsg.innerHTML = "현재 비밀번호와 일치하지 않습니다.";
					cnt1 = 0;
				}
			},
			error : console.log
		});
		
		if(cnt1 === 1 && cnt2 === 1 && cnt3 === 1){
			updatePwdBtn.disabled = false;
		}
	}); // 현재 비밀번호 일치유무 검사 end
	
	$("#newPassword").focusout((e)=>{
		cnt2 = 0;
		cnt3 = 0;
		document.querySelector("#newPwdCErrorMsg").innerHTML = "";
		const password = e.target.value;
		const newPwdErrorMsg = document.querySelector("#newPwdErrorMsg");
		newPwdErrorMsg.style.color = "tomato";
		
	    // 숫자 검사
	    if(!/\d/.test(password)){
	    	newPwdErrorMsg.innerHTML = "비밀번호는 하나 이상의 숫자를 반드시 포함해야 합니다.";
	    	cnt2 = 0;
	        return;
	    }
	    
	    // 문자 검사
	    if(!/[a-zㅏ-ㅣㄱ-ㅎ]/i.test(password)){
	    	newPwdErrorMsg.innerHTML = "비밀번호는 하나 이상의 문자를 반드시 포함해야 합니다.";
	    	cnt2 = 0;
	        return;
	    }
	    
	    // 특수문자 검사
	    if(!/[!@#$%^&*()]/.test(password)){
	    	newPwdErrorMsg.innerHTML = "비밀번호는 하나 이상의 특수문자를 반드시 포함해야 합니다.";
	    	cnt2 = 0;
	        return;
	    }
		
		if(!/^[a-zㅏ-ㅣㄱ-ㅎ0-9!@#$%^&*()]{4,}$/i.test(password)){
			newPwdErrorMsg.innerHTML = "비밀번호는 영문자/숫자/특수문자로 구성된 4글자이상이어야합니다.";
			cnt2 = 0;
			return;
		}
		
		if(password == document.querySelector("#nowPassword").value){
			newPwdErrorMsg.innerHTML = "현재 비밀번호와 일치합니다.";
			cnt2 = 0;
			return;
		}
		
		newPwdErrorMsg.style.color = "green";
		newPwdErrorMsg.innerHTML = "사용가능한 비밀번호입니다.";
		cnt2 = 1;
		
		if(cnt1 === 1 && cnt2 === 1 && cnt3 === 1){
			updatePwdBtn.disabled = false;
		}
	}); // 비밀번호 검사 end
	
	
	$("#newpasswordCheck").focusout((e)=>{
		cnt3 = 0;
		const pwd = document.querySelector("#newPassword").value;
		const pwdCheck = e.target.value;
		const newPwdCErrorMsg = document.querySelector("#newPwdCErrorMsg");
		newPwdCErrorMsg.style.color = "tomato";
		
		if(pwd !== pwdCheck){
			newPwdCErrorMsg.innerHTML = "비밀번호가 일치하지 않습니다.";
			cnt3 = 0;
			return;
		}
		
		newPwdCErrorMsg.style.color = "green";
		newPwdCErrorMsg.innerHTML = "비밀번호가 일치합니다.";
		cnt3 = 1;
		
		if(cnt1 === 1 && cnt2 === 1 && cnt3 === 1){
			updatePwdBtn.disabled = false;
		}
	}); // 비밀번호 일치검사 end
	
	</script>
	
</body>
</html>


