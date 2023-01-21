<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section id="counselingTotalList" class="fontStyle">

<div id=counselingEnrollTitle>
	<h1>고민 게시판</h1>
</div>

<table>
	<tr>
		<td>제목작성 :</td>

		<td class="inputTd fontStyle"><input type="text" id="title"
			name="title" placeholder="제목을 입력해 주세요."></td>
	</tr>


	<tr>
		<td>내용작성 :</td>

		<td class="inputTd fontStyle"><textarea name="content" cols="85"
				rows="15" id="content" placeholder="내용을 입력해 주세요."></textarea></td>
	</tr>

	<!-- 셀렉트 태그  -->
	<tr>
		<td>공개 나이대 선택 :</td>

		<td><select name="age">
				<option value="10">10대 이상</option>
				<option value="20">20대 이상</option>
				<option value="30">30대 이상</option>
				<option value="40">40대 이상</option>
				<option value="50">50대 이상</option>
				<option value="irrelevant">연령 무관</option>
		</select></td>
	</tr>

	<!-- 라디오 박스 : 하나마 선택 -->
	<tr>
		<td>공개 성별 선택 :</td>

		<td class="input fontsytle">남자 <input type="radio" name="gender"
			value="남자"> 여자 <input type="radio" name="gender" value="여자">
			전체공개 <input type="radio" name="gender" value="전체공개">
		</td>
	</tr>


	<!--d 전 화면에서 선택한 카테고리 받아오기 (어떻게하는지 몰라서 일단 셀렉트 폼 작성  -->
	<tr>
		<td>고민 카테고리 선택 :</td>

		<td class="input fontsytle"><select name="category">
				<option value="" disabled selected>카테고리를 선택하세요.</option>
				<option value="study">진로</option>
				<option value="love">연애</option>
				<option value="family">가족</option>
				<option value="childcare">육아</option>
				<option value="career">직장</option>
				<option value="daily">일상</option>
				<option value="friends">친구</option>
		</select></td>
	</tr>



	<tr>
		<td><input type="submit" id="write" value="고민 작성하기"></td>
	<tr>
</table>
</body>
</html>

<!-- crtl shift f 줄맞춤  -->