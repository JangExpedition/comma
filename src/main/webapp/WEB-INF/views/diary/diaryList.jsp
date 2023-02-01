<%@page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="diary.model.dto.Diary"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	LocalDateTime today = LocalDateTime.now();
	String formatToday = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	
	List<Font> fontList = (List<Font>) session.getAttribute("fontList");
	List<Design> designList = (List<Design>) session.getAttribute("designList");
	
	List<Diary> diaryList = (List<Diary>)request.getAttribute("diaryList");
	String yFilter = (String) request.getAttribute("yearFilter");
	HashSet<String> memberHaveYearSet = (HashSet<String>)request.getAttribute("memberHaveYearSet");
	
	boolean canWrite = true;
	
	for(Diary diary : diaryList){
		if(diary.getRegDate().equals(formatToday)){
			canWrite = false;
		}
	}
	boolean canEdit = true;
	Map<Integer, String> designMap = new HashMap<>();
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
			<% for(Diary diary : diaryList){ 
				 for(Design design : designList){ 

				if(diary.getDesignNo() == design.getNo()){
					String url = request.getContextPath() + "/upload/design/" + design.getRenamedFilename();
					designMap.put(diary.getNo(), url);
				}
			} %>
			
			<% if(diary.getDesignNo() == 0){ %>
				<div id="diary" data-diary-no="<%= diary.getNo() %>" class="onediary">
			<% } else{ %>
				<div id="diary" data-diary-no="<%= diary.getNo() %>" class="onediary" style="background-image:url('<%= designMap.get(diary.getNo()) %>')">
			<% } %>
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
<script>

$('.designBtn').on('click', (e) => {
	
	diaryUpdateModal.style.backgroundImage = `url("<%= request.getContextPath() %>/upload/design/\${e.target.dataset.renamedFilename}")`;
	
	designNoInput.value = e.target.dataset.designNo;
	
});
		
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
			
			
			switch(designNo){
			<% for(Design design : designList){ %>
			case <%= design.getNo() %>: 
				diaryEnrollModal.style.backgroundImage = "url('<%=request.getContextPath() %>/upload/design/<%= design.getRenamedFilename() %>')";
				diaryUpdateModal.style.backgroundImage = "url('<%=request.getContextPath() %>/upload/design/<%= design.getRenamedFilename() %>')";
				break;
			<% } %>
			}
			
			switch(fontNo){
				<% for(Font font : fontList){ %>
				case <%= font.getNo() %> : 
					nowContent.style.fontFamily = "<%= font.getName() %>";
					editContent.style.fontFamily = "<%= font.getName() %>";
					break;
				<% } %>
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