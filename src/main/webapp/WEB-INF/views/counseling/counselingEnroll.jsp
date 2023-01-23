<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section id="counselingTotalList" class="fontStyle">

<div id=counselingEnrollTitle>
	<h1>고민 게시판</h1>
</div>

<table>
<form action="<%= request.getContextPath() %>/counseling/insertCounseling" method="POST">
	<tr>
		<td id = "title-write">제목작성 :</td>

		<td class="inputTd fontStyle"><input type="text" id="title"
			name="title" placeholder="제목을 입력해 주세요."></td>
	</tr>


	<tr>
		<td id = "content-write">내용작성 :</td>

		<td class="inputTd fontStyle"><textarea name="content" cols="85"
				rows="15" id="content" placeholder="내용을 입력해 주세요."></textarea></td>
	</tr>


	<!-- 셀렉트 태그!  -->
	<tr>
		<td id="age-choice">공개 나이대 선택 :</td>

		<td><select name="age">
				<option value="1">10대 이상</option>
				<option value="2">20대 이상</option>
				<option value="3">30대 이상</option>
				<option value="4">40대 이상</option>
				<option value="5">50대 이상</option>
				<option value="0">연령 무관</option>
		</select></td>
	</tr>

	<!-- 라디오 박스 : 하나마 선택 -->
	<tr>
		<td id="gender-choice">공개 성별 선택 :</td>

		<td class="input fontsytle">
			<select name="gender" id="gender" name="gender" class="inputBar" required >
				<option value="A">전체</option>
				<option value="M">남자</option>
				<option value="F">여자</option>
			</select>
		</td>
	</tr>
	<!-- 익명설정  -->
	<tr>
		<td id="anonymous-choice">익명 선택 :</td>

		<td class="input fontsytle">
			<select name="anonymous" id="anonymous" name="anonymous" class="inputBar" required >
				<option value="X">닉네임으로 작성하기</option>
				<option value="O">익명으로 작성하기</option>
			</select>
		</td>
	</tr>


	<!--d 전 화면에서 선택한 카테고리 받아오기 (어떻게하는지 몰라서 일단 셀렉트 폼 작성  -->
	<tr>
		<td id="category-choice" >고민 카테고리 선택 :</td>

		<td class="input fontsytle"  id="category"><select name="category">
				<option value="" disabled selected>카테고리를 선택하세요.</option>
				<option value="STUDY">진로</option>
				<option value="LOVE">연애</option>
				<option value="FAMILY">가족</option>
				<option value="CHILDCARE">육아</option>
				<option value="CAREER">직장</option>
				<option value="DARILY">일상</option>
				<option value="FRIENDS">친구</option>
		</select>
		</td>
	</tr>



	<tr>
		<td><input type="submit" id="write" value="고민 작성하기"></td>
	<tr>
</form>
</table>
</body>
</html>
<!-- crtl shift f 줄맞춤  -->