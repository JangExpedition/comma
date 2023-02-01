<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	LocalDateTime today = LocalDateTime.now();
	String formatToday = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	List<Font> fontList = (List<Font>) session.getAttribute("fontList");
	List<Design> designList = (List<Design>) session.getAttribute("designList");
%>
<section id="writeDiarySection">
<div id="diaryEnrollBack">
		<div id="diaryEnrollModal" class="modal fontStyle">
			<div id="goBackBtn">
				<button id="goBack" class="buttonStyle" class="fontStyle" >뒤로가기</button>
			</div>
			<div id="diaryEnrollTitle" class="fontStyle">일기작성</div>
			<div id="diaryEnrollDiv" >
				<div id="diaryEnroll">
					<form id="diaryEnrollFrm" name="diaryEnrollFrm" action="<%= request.getContextPath() %>/diary/insertDiary" method="POST" enctype="multipart/form-data">
					<input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" />
						<table id="writeDiaryContent">
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
											<img id="img" name="img" src="<%= request.getContextPath() %>/images/이미지첨부.png" alt="첨부한 이미지" class="enrollImage" />
										</div>										
									</td>
									<td>
										<div id="enrollContent">
											<label for="nowContent"></label>
											<textarea name="nowContent" id="nowContent" placeholder="내용 작성"></textarea>
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
									<td colspan="2" class="submitBtn">
										<input id="diaryEnrollFrmSubmit" class="fontStyle" type="submit" value="등록하기" />
									</td>
								</tr>
							</tbody>
						</table>
						<input type="file" name="file" id="file" />
						<input type="hidden" id="fontNoInput" name="fontNo" />
						<input type="hidden" id="designNoInput" name="designNo" />
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
				<% if(designList != null || !designList.isEmpty()){ 
					int cnt = 1;
					for(Design design : designList){ %>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/upload/design/<%= design.getRenamedFilename() %>" alt="" class="designImage" />
						</td>
						<td>디자인<%= cnt %></td>
						<td>
							<input id="choiceDesign" type="button" value="선택" class="fontStyle designBtn" data-design-no="<%= design.getNo() %>" data-renamed-filename="<%= design.getRenamedFilename() %>" />
						</td>
					</tr>
				<% cnt++; 
					}
				} %>
				</tbody>
			</table>
		</div>
	</div>
	</section>
	<script>
	document.diaryEnrollFrm.addEventListener("submit", (e)=>{
		if(e.target.nowContent.value == ""){
			e.preventDefault();
			alert("내용을 작성해주세요.")
		}
	});
	
	$('.designBtn').on('click', (e) => {
		
		nowContent.style.backgroundImage = `url("<%= request.getContextPath() %>/upload/design/\${e.target.dataset.renamedFilename}")`;
		
		designNoInput.value = e.target.dataset.designNo;
		
	});
	
	document.querySelector('#fontChoice').addEventListener('change', (e) => {
		document.querySelectorAll('.fontChoiceOption').forEach((option) => {
			const bool = option.selected;
			const fontName = option.dataset.fontName;
			
			if (bool) {
				nowContent.style.fontFamily = `\${fontName}`;
			 	fontNoInput.value =  fontChoice.value;
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
			img.src = "<%= request.getContextPath() %>/images/이미지첨부.png";
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