<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<section>
		<div id="letterTitle" class="fontStyle">편지쓰기</div>
		<div id="writeLetter">
		    <form action="" id="writeLetterFrm">
		        <fieldset>
		        	
		            <table id="writeLetterTable">
			            <tbody>
			                <tr>
			                    <td id="labelTd" class="fontStyle">보내는 사람</td>
			                    <td>
			                    	<label><input type="checkbox" name="senderChoice" id="senderNick" value="senderNick" onclick="clickSenderChoice(this);" checked />닉네임으로 보내기</label>
			                    </td>
			                    <td>
			                    	<label><input type="checkbox" name="senderChoice" id="senderRandom" value="senderRandom" onclick="clickSenderChoice(this);" />익명으로 보내기</label>
			                    </td>
							</tr>
			                <tr>
			                    <td id="labelTd" class="fontStyle">받는 사람</td>
			                    <td>
			                    	<label><input type="checkbox" name="sendChoice" id="randomMember" value="randomMember" onclick="clickSendChoice(this);" />임의의 누군가에게 보내기</label>
			                    </td>
			                    <td>
			                    	<label><input type="checkbox" name="sendChoice" id="friend" value="friend" onclick="clickSendChoice(this);" />친구에게 보내기</label>
			                    </td>
							</tr>
			                <tr id="genderChoiceTr" style="display: none;">
			                    <td>
			                    	<label for="genderChoice" id="labelTd" class="fontStyle">성별 선택</label>
			                    </td>
			                    <td colspan="2">
			                    	<label><input type="checkbox" name="genderChoice" id="genderChoice" value="M" onclick="clickGenderChoice(this);" />남</label>
			                    	<label><input type="checkbox" name="genderChoice" id="genderChoice" value="F" onclick="clickGenderChoice(this);" />여</label>
			                    	<label><input type="checkbox" name="genderChoice" id="genderChoice" value="X" onclick="clickGenderChoice(this);" checked />무관</label>
			                    </td>
			                </tr>
			                <tr id="ageChoiceTr" style="display: none;">
			                    <td>
			                    	<label for="ageChoice" id="labelTd" class="fontStyle">연령 선택</label>
			                    </td>
			                    <td colspan="2">
			                    	<label><input type="checkbox" name="ageChoice" id="ageChoice" value="1" onclick="clickAgeChoice(this);" />10대</label>
			                    	<label><input type="checkbox" name="ageChoice" id="ageChoice" value="2" onclick="clickAgeChoice(this);" />20대</label>
			                    	<label><input type="checkbox" name="ageChoice" id="ageChoice" value="3" onclick="clickAgeChoice(this);" />30대</label>
			                    	<label><input type="checkbox" name="ageChoice" id="ageChoice" value="4" onclick="clickAgeChoice(this);" />40대</label>
			                    	<label><input type="checkbox" name="ageChoice" id="ageChoice" value="5" onclick="clickAgeChoice(this);" />50대 이상</label>
			                    	<label><input type="checkbox" name="ageChoice" id="ageChoice" value="0" onclick="clickAgeChoice(this);" checked />무관</label>
			                    </td>
			                </tr>
						<% if (friendsList != null) { %>
			                <tr id="friendsListTr" style="display: none;">
			                    <td colspan="3">
			                    	<input type="text" list="friendsList"/>
			                        <datalist id="friendsList">
			                    <% for (Friends friend : friendsList) { %>
			                            <option value="<%= friend.getNickname() %>"><%= friend.getNickname() %></option>
								<% } %>
			                        </datalist>
			                    </td>
			                </tr>
						<% } else { %>
							<tr id="friendsListTr" style="display: none;">
								<td colspan="3" class="fontStyle noFriends">조회된 친구목록이 없습니다..</td>
							</tr>
						<% } %>
							<tr id="letterFont" style="display: none;">
			                    <td>
			                    	<label for="fontChoice" id="labelTd" class="fontStyle">폰트 선택</label>
			                    </td>
			                    <td colspan="2">
			                    	<select name="fontChoice" id="fontChoice">
			                    		<option value="font1">폰트1</option>
			                    		<option value="font2">폰트2</option>
			                    		<option value="font3">폰트3</option>
			                    		<option value="font4">폰트4</option>
			                    	</select>
			                    </td>
							</tr>
							<tr id="letterDesign" style="display: none;">
			                    <td>
			                    	<label for="designChoice" id="labelTd" class="fontStyle">디자인 선택</label>
			                    </td>
			                    <td colspan="2">
			                    	<select name="designChoice" id="designChoice">
			                    		<option value="design1">디자인1</option>
			                    		<option value="design2">디자인2</option>
			                    		<option value="design3">디자인3</option>
			                    		<option value="design4">디자인4</option>
			                    	</select>
			                    </td>
							</tr>
							<tr id="letterImageBtn" style="display: none;">
								<td>
									<label for="imgChoice" id="labelTd" class="fontStyle">사진 첨부</label>
								</td>
								<td colspan="2">
									<input type="file" name="imgChoice" id="imgChoice" />
								</td>
								<!-- 
								<td colspan="3" class="imgBtn">
									<label for="imgChoice" id="labelTd" class="fontStyle">
										<i id="enrollImageChoice" class="fa-regular fa-image"></i>
									</label>
									<input type="file" name="imgChoice" id="imgChoice" style="display: none;" />
								</td>
								 -->
							</tr>
							<tr id="letterImage" style="display: none;">
								<td colspan="3">
									<img class="letterImg" src="<%= request.getContextPath() %>/images/default.png" alt="" />
									<img class="letterImg" src="<%= request.getContextPath() %>/images/default.png" alt="" />
									<img class="letterImg" src="<%= request.getContextPath() %>/images/default.png" alt="" />
								</td>
							</tr>
							<tr id="letterContent" style="display: none;">
								<td colspan="3">
									<label for="content"></label>
									<textarea id="content" name="content" rows="20" cols="90" placeholder="내용을 작성해주세요."></textarea>
								</td>
							</tr>
							<tr id="letterSubmit" style="display: none;">
								<td colspan="3">
									<input id="letterBtn" class="fontStyle" type="submit" value="편지 전송하기" />
								</td>
							</tr>
			            </tbody>
		            </table>
		        </fieldset>
		    </form>
	    </div>
	</section>
	<script>
		window.onload = () => {
			const label = document.querySelectorAll("label[for]");			
			label.forEach((la) => {
				la.classList.add('fontStyle');
			});
			
			const checkBox = document.querySelectorAll("input[type=checkbox]");
			checkBox.forEach((box) => {
				console.log(box);
				box.classList.add('choiceDetail');
			});
		};
	
		/*
		  받는 사람 체크박스 하나씩만 선택 가능
		*/
		const clickSendChoice = (target) => {
			const sendChoiceCheckBox = document.getElementsByName("sendChoice");
			
			sendChoiceCheckBox.forEach((sendChoice) => {
				sendChoice.checked = false;
			});
			
			target.checked = true;
			
			// 친구에게 보내는 경우 친구목록을 임의의 누군가에게 보내는 경우 성별 및 연령 선택 행만 보이기
			if (target.value == 'friend') {
				genderChoiceTr.style.display = 'none';
				ageChoiceTr.style.display = 'none';
				friendsListTr.style.display = '';
				
				<% if (friendsList == null) { %>
					letterFont.style.display = 'none';
					letterDesign.style.display = 'none';
					letterImage.style.display = 'none';
					letterImageBtn.style.display = 'none';
					letterContent.style.display = 'none';
					letterSubmit.style.display = 'none';
					return;
				<% } %>
			} else {
				genderChoiceTr.style.display = '';
				ageChoiceTr.style.display = '';
				friendsListTr.style.display = 'none';
			}
			letterFont.style.display = '';
			letterDesign.style.display = '';
			letterImage.style.display = '';
			letterImageBtn.style.display = '';
			letterContent.style.display = '';
			letterSubmit.style.display = '';
			
		}; // clickSendChoice end
		
		
		/*
		  보내는 사람 익명 또는 닉네임 선택
		*/
		const clickSenderChoice = (target) => {
			const senderChoiceCheckBox = document.getElementsByName("senderChoice");
			
			senderChoiceCheckBox.forEach((senderChoice) => {
				senderChoice.checked = false;
			});
			
			target.checked = true;
		}; // clickSenderChoice() end
		
		
		/*
		  성별 체크박스 하나씩만 선택 가능
		*/
		const clickGenderChoice = (target) => {
			const genderChoiceCheckBox = document.getElementsByName("genderChoice");
			
			genderChoiceCheckBox.forEach((genderChoice) => {
				genderChoice.checked = false;
			});
			
			target.checked = true;
		}; // clickGenderChoice end
		
		
		/*
		  연령 체크박스 하나씩만 선택 가능
		*/
		const clickAgeChoice = (target) => {
			const ageChoiceCheckBox = document.getElementsByName("ageChoice");
			
			ageChoiceCheckBox.forEach((ageChoice) => {
				ageChoice.checked = false;
			});
			
			target.checked = true;
		}; // clickAgeChoice end
	</script>
</body>
</html>