<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	LocalDateTime today = LocalDateTime.now();
	String formatToday = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
%>
<section id="writeDiarySection">
<div id="diaryEnrollBack">
		<div id="diaryEnrollModal" class="modal fontStyle">
			<div>
				<button id="goBack" class="buttonStyle">뒤로가기</button>
			</div>
			<div id="diaryEnrollTitle">일기작성</div>
			<div id="diaryEnrollDiv">
				<div id="diaryEnroll">
					<form id="diaryEnrollFrm" name="diaryEnrollFrm" action="<%= request.getContextPath() %>/diary/insertDiary" method="POST" enctype="multipart/form-data">
					<input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" />
						<table>
							<tbody>
								<tr>
									<td colspan="2">
										<div id="enrollDate">
											<input type="date" name="nowDate" id="nowDate" class="fontStyle" value=<%= formatToday %> readonly />						
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div id="enrollImage">
											<img id="img" name="img" src="<%= request.getContextPath() %>/images/default.png" alt="첨부한 이미지" class="enrollImage" />
										</div>										
									</td>
									<td>
										<div id="enrollContent">
											<label for="nowContent"></label>
											<textarea name="nowContent" id="nowContent" cols="50" rows="12" placeholder="내용 작성"></textarea>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<label for="enrollImage">
											<i id="enrollImageChoice" class="fa-regular fa-image"></i>
										</label>
										<input type="file" name="enrollImage" id="enrollImage" style="display: none;" />
										<select name="fontChoice" id="fontChoice">
				                    	<%
				                    		if (fontList != null && !fontList.isEmpty()) {
				                    			for (Font font : fontList) {
				                    	%>
				                    				<option style="font-family:<%= font.getName() %>;" class="fontChoiceOption" value="<%= font.getNo() %>" data-font-name="<%= font.getName() %>"><%= font.getName() %></option>
				                    	<%
				                    			} // for end
				                    		} else {
				                    	%>
						                    		<option value=0>폰트선택불가</option>
				                    	<%
				                    		} // else end
				                    	%>
						                </select>
										<i id="enrollDesignChoice" class="fa-solid fa-brush"></i>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<input id="diaryEnrollFrmSubmit" class="fontStyle" type="submit" value="등록하기" />
									</td>
								</tr>
							</tbody>
						</table>
						<input type="file" name="file" id="file" />
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 디자인 선택 모달 -->
	<div id="designChoiceModal" class="fontStyle">
		<div id="designModalTitle">
			<span class="design-title">디자인 선택</span>
			<input type="button" value="X" class="fontStyle modal-close" onclick="modalClose(this);" />
			<hr />
		</div>
		<div id="designModalContent">
			<table>
				<tbody>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="디자인1이미지" class="designImage" />
						</td>
						<td>디자인1</td>
						<td>
							<input type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="디자인2이미지" class="designImage" />
						</td>
						<td>디자인2</td>
						<td>
							<input type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="디자인3이미지" class="designImage" />
						</td>
						<td>디자인3</td>
						<td class="design-btn">
							<input type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	</section>
	<script>
	
	document.querySelector('#fontChoice').addEventListener('change', (e) => {
		document.querySelectorAll('.fontChoiceOption').forEach((option) => {
			const bool = option.selected;
			const fontName = option.dataset.fontName;
			
			if (bool) {
				nowContent.style.fontFamily = `\${fontName}`;
			}
		});
	});
	
	document.querySelector("#enrollImageChoice").addEventListener("click", (e)=>{
		file.click();
	});
	
	document.querySelector("#file").addEventListener("change", (e)=>{
		const reader = new FileReader();
		const file = e.target;
		const img = document.querySelector("#img");
		
		if(file.files[0]){
			reader.readAsDataURL(file.files[0]);
			reader.onload = (e) => {
				img.src = e.target.result;
			};
		} else{
			img.style.display = "none";
		}
		
	});
	
	document.querySelector("#goBack").addEventListener('click', () => {
		location.href = "<%= request.getContextPath() %>/diary/diaryList";
	});
	
	/*
	  모달 창 이외의 부분 클릭 시 창 닫기
	*/
	designChoiceModal.addEventListener('click', (e) => {
		if(e.target !== e.currentTarget) return;
		modal.style.display = 'none';
		designChoiceModal.style.display = 'none';
	});
	
	/*
	  X 클릭 시 창 닫기
	*/
	const modalClose = (target) => {
		console.log(target.id);
		if (target.id != '') {
			modal.style.display = 'none';
		} else {
			designChoiceModal.style.display = 'none';
		}
	};
	
	// 디자인 이미지 클릭하면 디자인 선택창 띄움
	enrollDesignChoice.addEventListener('click', () => {
		designChoiceModal.style.display = 'inline-block';
	});
	</script>
</body>
</html>