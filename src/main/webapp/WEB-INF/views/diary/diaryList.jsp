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
		if(formatToday.substring(0, 4).equals(yFilter)) { 
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
		<%= formatToday.substring(0, 4) %>
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
		<% } %>
		</div>
		</div>
	</section>
	<!-- 일기 작성 모달 -->
	<div id="diaryEnrollBack">
		<div id="diaryEnrollModal" class="modal fontStyle">
			<div id="diaryEnrollTitle"></div>
			<span id="diaryEnrollClose" onclick="modalClose(this);">X</span>
			<form id="diaryEnrollFrm" name="diaryEnrollFrm" action="<%= request.getContextPath() %>/diary/insertDiary" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" />
				<div id="oneDiaryFlexBox">
					<div id="oneDiaryImg">
						<img id="diaryViewImg" src="" alt="첨부한 이미지" class="enrollImage" />
					</div>
					<div id="enrollContent">
						<div id="nowContent" name="nowContent"></div>
					</div>
				</div>
				<% if(canEdit) { %>
				<div id="editItemBox">
					<label for="enrollImage">
						<i id="enrollImageChoice" class="fa-regular fa-image"></i>
					</label>
					<input type="file" name="enrollImage" id="enrollImage" style="display: none;" />
					<i id="enrollFontChoice" class="fa-solid fa-font"></i>
					<i id="enrollDesignChoice" class="fa-solid fa-brush"></i>
				</div>
				<div id="updateDiaryBtn">
					<input id="diaryUpdateFrmSubmit" class="fontStyle" type="submit" value="수정하기" />
					<input id="diaryDeleteFrmSubmit" class="fontStyle" type="submit" value="삭제하기" />
				</div>
				<% } %>
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
		<script>
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
					if(originalFilename === null){
						diaryViewImg.src = "<%= request.getContextPath() %>/images/default.png";
					} else{
						diaryViewImg.src = `<%= request.getContextPath() %>/upload/diary/\${renamedFilename}`;
 					}
					
					nowContent.innerHTML = content;
					
					diaryEnrollBack.style.display = "flex";
					
					const now = "<%= formatToday %>";
					
					if(regDate != now){
						document.querySelector("#editItemBox").style.display = "none";
						document.querySelector("#updateDiaryBtn").style.display = "none";
					}
					
				}
			});
		});
		</script>
		<% } %>
		</div>
	
	<form action="<%= request.getContextPath() %>/diary/diaryList" name="filterFrm">
		<input type="hidden" id="yearFilter" name="yearFilter"/>
	</form>
	<script>
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
	
	// 디자인 이미지 클릭하면 디자인 선택창 띄움
	enrollDesignChoice.addEventListener('click', () => {
		designChoiceModal.style.display = 'inline-block';
	}); 
	</script>

</body>
</html>