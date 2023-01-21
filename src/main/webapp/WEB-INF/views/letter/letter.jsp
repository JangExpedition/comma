<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<section>
		<div id="writeLetter">
		    <form action="" id="writeLetterFrm">
		        <fieldset>
		            <table id="writeLetterTable">
			            <thead>
			                <tr>
			                    <th id="letterTitle" class="fontStyle" colspan="3">편지쓰기</th>
			                </tr>
			            </thead>
			            <tbody>
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
					letterContent.style.display = 'none';
					letterSubmit.style.display = 'none';
					return;
				<% } %>
			} else {
				genderChoiceTr.style.display = '';
				ageChoiceTr.style.display = '';
				friendsListTr.style.display = 'none';
			}
			letterContent.style.display = '';
			letterSubmit.style.display = '';
			
		}; // clickSendChoice end
		
		
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