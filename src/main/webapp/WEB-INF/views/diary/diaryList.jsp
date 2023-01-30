<%@page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="diary.model.dto.Diary"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Iterator" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	LocalDateTime today = LocalDateTime.now();
	String formatToday = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	List<Diary> diaryList = (List<Diary>)request.getAttribute("diaryList");
	String yFilter = (String) request.getAttribute("yearFilter");
	System.out.println("yFilter" + yFilter);
	
	boolean canWrite = true;
	HashSet<String> memberHaveYearSet = (HashSet<String>)request.getAttribute("memberHaveYearSet");
	
	for(Diary diary : diaryList){
		if(diary.getRegDate().equals(formatToday)){
			canWrite = false;
		}
	}
	boolean canEdit = true;
%>
	
	<section id="diaryTotalList" class="fontStyle">
	<div id="diaryContainer">
		<div id="diaryTitle">일기장</div>
		<div id="inputBtn">
		<% 
		if(canWrite){
			if(yFilter == null) { 
		%>
			<input type="button" id="writeBtn" class="fontStyle" value="일기 작성하기" />
			<script>
				document.querySelector("#writeBtn").addEventListener('click', () => {
					location.href = "<%= request.getContextPath() %>/diary/writeDiary";
				});
			</script>
		<% } 
		} %>
		</div>
	
		<div class="yearContainer">
		<% if(yFilter == null) { %>
			<%= formatToday %>
		<% } else{ %>
			<%= yFilter %>
		<% } %>
		</div>
		<div id="diarySec">
			<div id="yearFilter">
				<p class="yFilter">#전체보기</p>
			<%
				Iterator<String> iter = memberHaveYearSet.iterator();
				while(iter.hasNext()){
			%>
				<p class="yFilter">#<%= iter.next() %></p>
			<% } %>
			</div>
			
			<% if(diaryList.isEmpty()) {%>
			<div id="noDiary">
				작성된 일기가 없습니다.
			</div>
			<% }else{ %>
			<div id="didiary">
			<% for(Diary diary : diaryList){ %>
				<div id="diary" data-diary-no="<%= diary.getNo() %>" class="onediary" >
					<div id="imgBox">
					<% if(diary.getOriginalFilename() != null){ %>
						<img src="<%= request.getContextPath() %>/upload/diary/<%= diary.getRenamedFilename() %>" alt="" class="writeImg" />
					<% } else{ %>
						<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="writeImg" />
					<% } %>
					</div>
					<div id="diaryContent">
						<p class="writeDate"><%= diary.getRegDate() %></p>
						<% if(diary.getContent().length() > 20) {%>
						<p class="writeContent"><%= diary.getContent().substring(0, 20) + "..." %></p>
						<% } else{ %>
						<p class="writeContent"><%= diary.getContent() %></p>
						<% } %>
					</div>
				</div>
			<% } // for end %>
			</div>
			<% } %>
		</div>
	</div>
	</section>
	<!-- 일기 작성 모달 -->
	<div id="diaryEnrollBack">
		<div id="diaryEnrollModal" class="modal fontStyle">
			<div id="diaryEnrollTitle"></div>
			<span id="diaryEnrollClose" onclick="modalClose(this);">X</span>
			<form id="diaryEnrollFrm" name="diaryEnrollFrm" action="<%= request.getContextPath() %>/diary/deleteDiary" method="POST">
				<input type="hidden" id="deleteDiaryNo" name="deleteDiaryNo" class="deleteDiaryNo" value="" />
				<div id="oneDiaryFlexBox">
					<div id="oneDiaryImg">
						<img id="diaryViewImg" src="" alt="첨부한 이미지" class="enrollImage" />
					</div>
					<div id="enrollContent">
 						<textarea id="nowContent" name="nowContent" readonly></textarea>
					</div>
				</div>
				<% if(canEdit) { %>
				<div id="updateDiaryBtn">
					<input id="diaryUpdateModalBtn" class="fontStyle" type="button" value="수정하기" />
					<input id="diaryDeleteFrmSubmit" class="fontStyle" type="submit" value="삭제하기" />
				</div>
				<% } %>
			</form>
		</div>
		<div id="diaryUpdateModal" class="modal fontStyle">
			<div id="diaryUpdateTitle"></div>
			<span id="diaryUpdateClose" onclick="modalClose(this);">X</span>
			<form id="diaryUpdateFrm" name="diaryUpdateFrm" action="<%= request.getContextPath() %>/diary/updateDiary" method="POST" enctype="multipart/form-data">
				<input type="hidden" id="updateDiaryNo" name="updateDiaryNo" class="diaryNo" value="" />
				<div id="oneDiaryFlexBox">
					<div id="oneDiaryImg">
						<img id="diaryUpdateImg" src="" alt="첨부한 이미지" class="enrollImage" />
					</div>
					<div id="updateContent">
 						<textarea id="editContent" name="editContent"></textarea>
					</div>
				</div>
				<% if(canEdit) { %>
				<div id="editItemBox">
					<label for="updateFile">
						<i id="enrollImageChoice" class="fa-regular fa-image"></i>
					</label>
					<input type="file" name="updateFile" id="updateFile" style="display: none;" />
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
				</div>
				<div id="updateDiaryBtn">
					<input id="diaryUpdateFrmSubmit" class="fontStyle" type="submit" value="수정하기" />
				</div>
				<% } %>
				<input type="hidden" id="fontNoInput" name="fontNo" />
				<input type="hidden" id="designNoInput" name="designNo" />
			</form>
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
							<img src="<%= request.getContextPath() %>/images/diaryImg1.png" alt="디자인1이미지" class="designImage" />
						</td>
						<td>디자인1</td>
						<td>
							<input id="choiceDesign1" type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/diaryImg2.png" alt="디자인2이미지" class="designImage" />
						</td>
						<td>디자인2</td>
						<td>
							<input id="choiceDesign2" type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/diaryImg3.jpeg" alt="디자인3이미지" class="designImage" />
						</td>
						<td>디자인3</td>
						<td class="design-btn">
							<input id="choiceDesign3" type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
		<script>
		document.querySelector("#updateFile").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			const img = document.querySelector("#diaryUpdateImg");
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					img.src = e.target.result;
				};
			} else{
				img.style.display = "none";
			}
			
		});
		
		document.querySelector("#diaryUpdateModalBtn").addEventListener("click",(e)=>{
			diaryEnrollModal.style.display = "none";
			diaryUpdateModal.style.display = "inline-block";
		});
		
		/*
		  버튼 클릭 시 모달 창 띄우기
		*/
		$(".onediary").click((e)=>{
			const diaryNo = $(event.target).parent('.onediary').data('diaryNo');
			$.ajax({
				url : "<%= request.getContextPath() %>/diary/diaryView",
				data : {diaryNo},
				dataType: "json",
				success(data){
					
					console.log("wjefijewlfjlefjkldsnfkl");
					
					const{no, writer, content, designNo, fontNo, originalFilename, renamedFilename, regDate} = data;
					
					diaryEnrollTitle.innerHTML = regDate;
					diaryUpdateTitle.innerHTML = regDate;
					
					if(originalFilename === null){
						diaryViewImg.src = "<%= request.getContextPath() %>/images/default.png";
						diaryUpdateImg.src = "<%= request.getContextPath() %>/images/default.png";
					} else{
						diaryViewImg.src = `<%= request.getContextPath() %>/upload/diary/\${renamedFilename}`;
						diaryUpdateImg.src = `<%= request.getContextPath() %>/upload/diary/\${renamedFilename}`;
 					}
					
					console.log(designNo, typeof designNo);
					switch(designNo){
					case 1: 
						diaryEnrollModal.style.backgroundImage = "url('<%=request.getContextPath() %>/images/diaryImg1.png')";
						diaryUpdateModal.style.backgroundImage = "url('<%=request.getContextPath() %>/images/diaryImg1.png')";
						break;
					case 2: 
						diaryEnrollModal.style.backgroundImage = "url('<%=request.getContextPath() %>/images/diaryImg2.png')";
						diaryUpdateModal.style.backgroundImage = "url('<%=request.getContextPath() %>/images/diaryImg2.png')";
						break;
					case 3: 
						diaryEnrollModal.style.backgroundImage = "url('<%=request.getContextPath() %>/images/diaryImg3.jpeg')";
						diaryUpdateModal.style.backgroundImage = "url('<%=request.getContextPath() %>/images/diaryImg3.jpeg')";
						break;
					}
					
					switch(fontNo){
					case 1 : 
						nowContent.style.fontFamily = "'Yeon Sung', cursive";
						editContent.style.fontFamily = "'Yeon Sung', cursive";
						break;
					case 2 : 
						nowContent.style.fontFamily = "'Nanum Gothic', sans-serif";
						editContent.style.fontFamily = "'Nanum Gothic', sans-serif";
						break;
					case 21 : 
						nowContent.style.fontFamily = "'Gaegu', cursive";
						editContent.style.fontFamily = "'Gaegu', cursive";
						break;
					case 41 : 
						nowContent.style.fontFamily = "'Hi Melody', cursive";
						editContent.style.fontFamily = "'Hi Melody', cursive";
						break;
					case 42 : 
						nowContent.style.fontFamily = "'Nanum Brush Script', cursive";
						editContent.style.fontFamily = "'Nanum Brush Script', cursive";
						break;
					case 43 : 
						nowContent.style.fontFamily = "'IBM Plex Sans KR', sans-serif";
						editContent.style.fontFamily = "'IBM Plex Sans KR', sans-serif";
						break;
					case 44 : 
						nowContent.style.fontFamily = "'East Sea Dokdo', cursive";
						editContent.style.fontFamily = "'East Sea Dokdo', cursive";
						break;
					}
					
					nowContent.value = content;
					editContent.value = content;
					
					diaryEnrollBack.style.display = "flex";
					
					const now = "<%= formatToday %>";
					
					if(regDate != now){
						document.querySelector("#editItemBox").style.display = "none";
						document.querySelector("#updateDiaryBtn").style.display = "none";
					}
					
					document.querySelector("#deleteDiaryNo").value = no;
					document.querySelector("#updateDiaryNo").value = no;
					
				}
			});
		});
		
		// 디자인 이미지 클릭하면 디자인 선택창 띄움
		enrollDesignChoice.addEventListener('click', () => {
			designChoiceModal.style.display = 'inline-block';
		}); 
		
		document.querySelector("#choiceDesign1").addEventListener("click", (e)=>{
			$("#diaryUpdateModal").css("backgroundImage", "url('<%= request.getContextPath() %>/images/diaryImg1.png')");
			designNoInput.value = 1;
		});
		
		document.querySelector("#choiceDesign2").addEventListener("click", (e)=>{
			$("#diaryUpdateModal").css("backgroundImage", "url('<%= request.getContextPath() %>/images/diaryImg2.png')");
			designNoInput.value = 2;
		});
		
		document.querySelector("#choiceDesign3").addEventListener("click", (e)=>{
			$("#diaryUpdateModal").css("backgroundImage", "url('<%= request.getContextPath() %>/images/diaryImg3.jpeg')");
			designNoInput.value = 3;
		});
		
		document.querySelector('#fontChoice').addEventListener('change', (e) => {
			document.querySelectorAll('.fontChoiceOption').forEach((option) => {
				const bool = option.selected;
				const fontName = option.dataset.fontName;
				
				if (bool) {
					editContent.style.fontFamily = `\${fontName}`;
				 	fontNoInput.value =  fontChoice.value;
				}
			});
		});
		
		</script>
	
	<form action="<%= request.getContextPath() %>/diary/diaryList" name="filterFrm">
		<input type="hidden" id="yearFilter" name="yearFilter"/>
	</form>
	<script>
	diaryEnrollFrm.addEventListener("submit", (e)=>{
		if(confirm("정말로 삭제하시겠습니까?")){
			e.target.submit();
		};
	});
	
	diaryUpdateFrm.addEventListener("submit", (e)=>{
		if(confirm("정말로 수정하시겠습니까?")){
			e.target.submit();
		};
	});
	
	/*
		일기년도 필터 메서드
	*/
	$(".yFilter").click((e)=>{
		const form = document.filterFrm;
		form.yearFilter.value = e.target.innerHTML.substr(1,);
		
		document.filterFrm.submit();
		
	});
	
	const modal = document.querySelector('#diaryEnrollBack');
	
	/*
	  모달 창 이외의 부분 클릭 시 창 닫기
	*/
	modal.addEventListener('click', (e) => {
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
	
	
	</script>

</body>
</html>