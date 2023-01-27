<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<script>		
		const friendNick = localStorage.getItem('friendNick');
		console.log('friendNick = ' + friendNick);
	</script>
	<section>
		<div id="letterTitle" class="fontStyle">편지쓰기</div>
		<div id="writeLetter">
		    <form id="writeLetterFrm" action="<%= request.getContextPath() %>/letter/writeLetter" method="post" enctype="multipart/form-data">
	            <table id="writeLetterTable">
		            <tbody>
		                <tr>
		                    <td id="labelTd" class="fontStyle">보내는 사람</td>
		                    <td>
		                    	<label for="senderNick" id="nick"><input type="checkbox" name="senderChoice" id="senderNick" value="X" onclick="clickSenderChoice(this);" checked />닉네임으로 보내기</label>
		                    </td>
		                    <td>
		                    	<label for="senderRandom" id="anony"><input type="checkbox" name="senderChoice" id="senderRandom" value="O" onclick="clickSenderChoice(this);" />익명으로 보내기</label>
		                    </td>
						</tr>
		                <tr>
		                    <td id="labelTd" class="fontStyle">받는 사람</td>
		                    <td>
		                    	<label for="sendRandom" id="random"><input type="checkbox" name="sendChoice" id="sendRandom" value="A" onclick="clickSendChoice(this);" />임의의 누군가에게 보내기</label>
		                    </td>
		                    <td>
		                    	<label for="sendFriend" id="friend"><input type="checkbox" name="sendChoice" id="sendFriend" value="F" onclick="clickSendChoice(this);" />친구에게 보내기</label>
		                    </td>
						</tr>
		                <tr id="genderChoiceTr" style="display: none;">
		                    <td id="labelTd" class="fontStyle">성별 선택</td>
		                    <td colspan="2">
		                    	<input type="checkbox" name="genderChoice" id="genderChoiceM" value="M" onclick="clickGenderChoice(this);" /><label for="genderChoiceM">남</label>
		                    	<input type="checkbox" name="genderChoice" id="genderChoiceF" value="F" onclick="clickGenderChoice(this);" /><label for="genderChoiceF">여</label>
		                    	<input type="checkbox" name="genderChoice" id="genderChoiceX" value="X" onclick="clickGenderChoice(this);" checked /><label for="genderChoiceX">무관</label>
		                    </td>
		                </tr>
		                <tr id="ageChoiceTr" style="display: none;">
		                    <td id="labelTd" class="fontStyle">연령 선택</td>
		                    <td colspan="2">
		                    	<input type="checkbox" name="ageChoice" id="ageChoice1" value=1 onclick="clickAgeChoice(this);" /><label for="ageChoice1">10대</label>
		                    	<input type="checkbox" name="ageChoice" id="ageChoice2" value=2 onclick="clickAgeChoice(this);" /><label for="ageChoice2">20대</label>
		                    	<input type="checkbox" name="ageChoice" id="ageChoice3" value=3 onclick="clickAgeChoice(this);" /><label for="ageChoice3">30대</label>
		                    	<input type="checkbox" name="ageChoice" id="ageChoice4" value=4 onclick="clickAgeChoice(this);" /><label for="ageChoice4">40대</label>
		                    	<input type="checkbox" name="ageChoice" id="ageChoice5" value=5 onclick="clickAgeChoice(this);" /><label for="ageChoice5">50대 이상</label>
		                    	<input type="checkbox" name="ageChoice" id="ageChoice0" value=0 onclick="clickAgeChoice(this);" checked /><label for="ageChoice0">무관</label>
		                    </td>
		                </tr>
					<% if (friendsList != null) { %>
		                <tr id="friendsListTr" style="display: none;">
		                	<td></td>
		                	<td></td>
		                    <td>
		                    	<input type="text" list="friendsList" id="textFriendsList" name="friendsList" />
		                        <datalist id="friendsList">
		                    <% for (Friends friend : friendsList) { %>
		                            <%-- <option value="<%= friend.getNickname() %>"><%= friend.getNickname() %></option> --%>
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
		                    		<option value=1>폰트1</option>
		                    		<option value=2>폰트2</option>
		                    		<option value=3>폰트3</option>
		                    		<option value=4>폰트4</option>
		                    	</select>
		                    </td>
						</tr>
						<tr id="letterDesign" style="display: none;">
		                    <td>
		                    	<label for="designChoice" id="labelTd" class="fontStyle">디자인 선택</label>
		                    </td>
		                    <td colspan="2">
		                    	<select name="designChoice" id="designChoice">
		                    		<option value=1>디자인1</option>
		                    		<option value=2>디자인2</option>
		                    		<option value=3>디자인3</option>
		                    		<option value=4>디자인4</option>
		                    	</select>
		                    </td>
						</tr>
						<tr id="letterImageBtn" style="display: none;">
							<td>
								<label for="imgChoice" id="labelTd" class="fontStyle">사진 첨부</label>
							</td>
							<td colspan="2">
								<input type="file" name="imgChoice1" id="imgChoice1" accept=".jpg, .jpeg, .png" />
								<input type="file" name="imgChoice2" id="imgChoice2" accept=".jpg, .jpeg, .png" />
								<input type="file" name="imgChoice3" id="imgChoice3" accept=".jpg, .jpeg, .png" />
							</td>
						</tr>
						<tr id="letterImage" style="display: none;">
							<td colspan="3" id="letterImg">
								<img src="#" alt="" id="img1" class="letterImg" />
								<img src="#" alt="" id="img2" class="letterImg" />
								<img src="#" alt="" id="img3" class="letterImg" />
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
								<input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" />
								<input id="letterBtn" class="fontStyle" type="submit" value="편지 전송하기" />
							</td>
						</tr>
		            </tbody>
	            </table>
		    </form>
	    </div>
	</section>
	<script>
		window.onload = () => {
			const checkBox = document.querySelectorAll("input[type=checkbox]");
			checkBox.forEach((box) => {
				box.classList.add('choiceDetail');
			});
		};
		
		/*
		  폼 제출 시 내용 또는 친구를 선택하지 않은 경우 폼 제출 막는 이벤트
		*/
		writeLetterFrm.addEventListener('submit', (e) => {
			const content = e.target.content;
			const friendCheck = document.querySelector('#sendFriend');
			
			// 내용을 작성하지 않은 경우 폼 제출할 수 없음.
			if (!/^(.|\n)+$/.test(content.value)) {
				alert("내용을 작성해주세요.");
				e.preventDefault();
				content.select();
				return;
			}
			
			// 친구에게 보내는데 친구를 선택하지 않은 경우 폼 제출할 수 없음
			if (friendCheck.checked && textFriendsList.value == '') {
				alert("편지를 보낼 친구를 선택해주세요.");
				e.preventDefault();
				textFriendsList.select();
				return;
			}
		});
		
		
		/*
		  친구에게 보내기 클릭 시 닉네임으로만 보낼 수 있도록 제한
		*/
		friend.addEventListener('click', (e) => {
			anony.style.display = 'none';
			senderNick.checked = true;
			senderRandom.checked = false;
		});
		
		/*
		  임의의 누군가에게 보내는 경우 닉네임 또는 익명으로 보내기 선택 가능
		*/
		random.addEventListener('click', (e) => {
			anony.style.display = '';
			senderNick.checked = true;
			senderRandom.checked = false;
		});
	
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
			if (target.value == 'F') {
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
		
		
		/*
		  이미지 업로드 시 미리보기
		*/
		document.querySelector("#imgChoice1").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					document.querySelector("#img1").src = e.target.result;
				};
			} else{
				document.querySelector("#img1").src = "#";
			}
		});

		document.querySelector("#imgChoice2").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					document.querySelector("#img2").src = e.target.result;
				};
			} else{
				document.querySelector("#img2").src = "#";
			}
		});

		document.querySelector("#imgChoice3").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					document.querySelector("#img3").src = e.target.result;
				};
			} else{
				document.querySelector("#img3").src = "#";
			}
		});
		
		
		/*
		  친구 목록에서 편지쓰기 클릭 시 자동으로 친구 띄워주기
		*/
		if (friendNick != null) {
			const friend = document.querySelector('#sendFriend');
			friend.checked = true;
		
			anony.style.display = 'none';
			genderChoiceTr.style.display = 'none';
			ageChoiceTr.style.display = 'none';
			friendsListTr.style.display = '';
			letterFont.style.display = '';
			letterDesign.style.display = '';
			letterImage.style.display = '';
			letterImageBtn.style.display = '';
			letterContent.style.display = '';
			letterSubmit.style.display = '';
			textFriendsList.value = friendNick;
		}
		
		
		/*
		  사진 3장까지만 첨부 가능하고 미리보기 띄워줌
		
		let uploadCnt = 0;
		let uploadFiles = [];
		const getImageFiles = (e) => {
			const file = e.currentTarget.files;
			const imagePreview = document.querySelector('#letterImg');
			uploadCnt += 1;
			
			if (uploadFiles.length >= 4 || uploadCnt >= 4) {
				alert('이미지는 최대 3장까지 업로드 가능합니다.');
				uploadCnt -= 1;
				return;
			}

			// 파일 타입 검사
			if (!file[0].type.match("image/.*")) {
				alert('이미지 파일만 업로드 가능합니다.');
				return;
			}

			// 파일 갯수 검사
			if (uploadFiles.length >= 4 || uploadCnt < 4) {
				uploadFiles.push(file[0]);
				const reader = new FileReader();
				reader.onload = (e) => {
					const preview = createElement(e, file[0]);
					imagePreview.appendChild(preview);
				};
				reader.readAsDataURL(file[0]);
				console.log(uploadFiles);
			}
		};
		
		const createElement = (e, file) => {
			const img = document.createElement('img');
			img.classList.add('letterImg');
			img.src = e.target.result
			return img;
		};
		
		imgChoice.addEventListener('change', (e) => {
			getImageFiles(e);
			console.log(uploadCnt);
		});
		*/
		
		
		/*
		  사진 첨부 시 이미지 미리보기 띄우기
		
		imgChoice3.addEventListener('change', (e) => {
			const files = e.target.files;
			const reader = new FileReader();
			reader.onload = ({target}) => {
				const letterImg = document.querySelector('#letterImg3');
				letterImg.src = target.result;
				console.log(letterImg.src);
			};
			reader.readAsDataURL(files[0]);
		});
		*/
	</script>
</body>
</html>