<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div id="chatCreate" class="fontStyle"><h1>채팅방 개설</h1></div>

<form action="<%=request.getContextPath()%>/chat/insertChat" method="post" name="chatCreateFrm">



<fieldset class="fontStyle" id="chatCreatepage">
	<h2 id = "chatmake">채팅방 개설하기</h2>
	<hr/>
	<table>
		<tr>
			<th>채팅방 제목 :</th>
			<td><input type="text" name="chatTitle" value="" />
			</td>
		</tr>
	
		
		<!-- <tr>
			<th><label for="chatpassword"><input type="checkbox" name="chatpassword" id="chatpassword" />
			채팅방 비밀번호 : </label></th>
			<td><input type="text" name="chatPwd" value="" /></td>
		</tr> -->


		<tr>
			<th>카테고리 선택 :</th>
			<td><select name="category" id ="categorySelect">
					<option value="" disabled selected>카테고리를 선택하세요.</option>
					<option value="ALL">전체</option>
					<option value="STUDY">진로</option>
					<option value="LOVE">연애</option>
					<option value="FAMILY">가족</option>
					<option value="CHILDCARE">육아</option>
					<option value="CAREER">직장</option>
					<option value="DAILY">일상</option>
					<option value="FRIENDS">친구</option>
			</select>
			</td>
		</tr>

		<tr>
		<th>   참여 가능한 성별 : </th>
		<td>
			<select name="gender" id="gender" name="gender" class="inputBar" required >
				<option value="" selected disabled hidden>공개할 성별을 선택해주세요.</option>
				<option value="X">전체</option>
				<option value="M">남자</option>
				<option value="F">여자</option>
			</select>
		</td>
		</tr>
		<tr>
			<th>참여 연령대 :</th>
			<td><input type="radio" name="age" value="1" /> 10대 이상
			 <input type="radio" name="age" value="2" /> 20대 이상 
			 <input type="radio" name="age" value="3" /> 30대 이상 
			 <input type="radio" name="age" value="4" /> 40대 이상
			 <input type="radio" name="age" value="5" /> 50대 이상 
			 <input type="radio" name="age" value="0" /> 연령 무관
			 </td>
		</tr>

		<tr>
			<th>채팅방 최대 인원 : </th>
			<td><input type="number" name="chattingPerson" min="1"
				max="1000" value="2" /></td>
		</tr>
		
		<tr>
  			<td id=btntd colspan=2  ><input type="submit" class="fontStyle"  id="chatroomCreate" value='채팅방 생성하기' />
			</td>
		</tr>
		
		<tr>
  			<td id=btntd colspan=2  ><input type="button" class="fontStyle"  id="chatroomList" value='채팅방 목록보기' />
			</td>
		</tr>

	</table>
</fieldset>
</form>
 <script>
 chatroomList.addEventListener('click', (e) => {
	 location.href= "<%=request.getContextPath()%>/chat/chatList";
 });
</script>
</body>
</html>

