<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section id="counselingEnrollSection" class="fontStyle">
	<div id="counselingEnrollContainer">
		<div id=counselingEnrollTitle class="pointColor">
			<h1>고민 작성</h1>
		</div>
		<form id="counselingEnrollFrm" name="counselingEnrollFrm" action="<%= request.getContextPath() %>/counseling/insertCounseling" method="POST" enctype="multipart/form-data">
			<table>
				<tr>
					<th class="lableTd pointColor">카테고리 선택</th>
					<td class="input fontsytle"  id="categoryTd">
						<select id="counselingCategory" name="counselingCategory" required>
								<option value="" selected>카테고리를 선택해주세요.</option>
								<option value="STUDY">진로</option>
								<option value="LOVE">연애</option>
								<option value="FAMILY">가족</option>
								<option value="CHILDCARE">육아</option>
								<option value="CAREER">직장</option>
								<option value="DARILY">일상</option>
								<option value="FRIENDS">친구</option>
						</select>
					</td>
					<th class="lableTd pointColor">익명 선택</th>
					<td class="input fontsytle">
						<select name="anonymous" id="anonymous" name="anonymous" class="inputBar" required >
							<option value="" selected>작성자 공개 설정</option>
							<option value="X">닉네임으로 작성하기</option>
							<option value="O">익명으로 작성하기</option>
						</select>
					</td>
					</tr>
					<tr>
					<th class="lableTd pointColor">성별 선택</th>
					<td class="input fontsytle">
						<select name="gender" id="gender" name="gender" class="inputBar" required >
							<option value="" selected>공개할 성별을 선택해주세요.</option>
							<option value="A">전체</option>
							<option value="M">남자</option>
							<option value="F">여자</option>
						</select>
					</td>
					<th class="lableTd pointColor">나이대 선택</th>
					<td>
						<select name="age" required >
							<option value="" selected>공개할 나이대를 선택해주세요.</option>
							<option value="1">10대 이상</option>
							<option value="2">20대 이상</option>
							<option value="3">30대 이상</option>
							<option value="4">40대 이상</option>
							<option value="5">50대 이상</option>
							<option value="0">연령 무관</option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="lableTd pointColor">사진첨부</th>
					<td colspan="3">
						<input type="file" name="file1" id="file1" />
						<input type="file" name="file2" id="file2" />
						<input type="file" name="file3" id="file3" />
					</td>
				</tr>
				<tr>
					<td id="titleTd" class="inputTd fontStyle" colspan="4">
						<input type="text" id="counselingTitle" name="counselingTitle" placeholder="제목을 입력해 주세요." required>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<div id="imgDiv" name="imgDiv">
							<img src="" alt="" id="img1" name="img1" class="img"/>
							<img src="" alt="" id="img2" name="img2" class="img"/>
							<img src="" alt="" id="img3" name="img3" class="img"/>
						</div>
					</td>
				</tr>
				<tr>
					<td id="contentTd" class="inputTd fontStyle" colspan="4">
						<textarea name="content" id="content" cols="" rows=""></textarea>
					</td>
				</tr>
				<tr>
					<input type="hidden" name="loginMember" value="<%= loginMember.getNickname() %>"/>
				</tr>
				<tr>
					<th colspan="4" id="submitTd"><input type="submit" id="write" class="fontStyle" value="고민 작성하기"></th>
				<tr>
			</table>
		</form>
	</div>
</section>
<script>
/*
Date : 2023. 1. 25
@장원정
프로필 이미지 첨부 메서드
*/
document.querySelector("#file1").addEventListener("change", (e)=>{
	const reader = new FileReader();
	const file = e.target;
	const img = document.querySelector("#img1");
	const div = document.querySelector("#imgDiv");
	
	if(file.files[0]){
		reader.readAsDataURL(file.files[0]);
		reader.onload = (e) => {
			div.style.height = "150px";
			document.querySelector("#content").style.height = "350px";
			img.src = e.target.result;
			img.style.display = "inline";
			div.style.display = "flex";
		};
	} else{
		document.querySelector("#imgDiv").style.height = "0";
		document.querySelector("#content").style.height = "500px";
		img.src = "";
		img.style.display = "none";
	}
	
});

document.querySelector("#file2").addEventListener("change", (e)=>{
	const reader = new FileReader();
	const file = e.target;
	const img = document.querySelector("#img2");
	const div = document.querySelector("#imgDiv");
	
	if(file.files[0]){
		reader.readAsDataURL(file.files[0]);
		reader.onload = (e) => {
			div.style.height = "150px";
			document.querySelector("#content").style.height = "350px";
			img.src = e.target.result;
			img.style.display = "inline";
			div.style.display = "flex";
		};
	} else{
		document.querySelector("#imgDiv").style.height = "0";
		document.querySelector("#content").style.height = "500px";
		img.src = "";
		img.style.display = "none";
	}
	
});

document.querySelector("#file3").addEventListener("change", (e)=>{
	const reader = new FileReader();
	const file = e.target;
	const img = document.querySelector("#img3");
	const div = document.querySelector("#imgDiv");
	
	if(file.files[0]){
		reader.readAsDataURL(file.files[0]);
		reader.onload = (e) => {
			div.style.height = "150px";
			document.querySelector("#content").style.height = "350px";
			img.src = e.target.result;
			img.style.display = "inline";
			div.style.display = "flex";
		};
	} else{
		document.querySelector("#imgDiv").style.height = "0";
		document.querySelector("#content").style.height = "500px";
		img.src = "";
		img.style.display = "none";
	}
	
});
</script>
</body>
</html>
<!-- crtl shift f 줄맞춤  -->