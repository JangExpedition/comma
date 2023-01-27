<%@page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="diary.model.dto.Diary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	LocalDateTime today = LocalDateTime.now();
	String formatToday = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	System.out.println(formatToday);
	List<Diary> diaryList = (List<Diary>)request.getAttribute("diaryList");
	System.out.println("diaryList = " + diaryList);
	String yFilter = formatToday.substring(0, 4);
%>
	
	<section id="diaryTotalList" class="fontStyle">
	<div id="diaryContainer">
	<div id="diaryTitle">일기장</div>
	<div id="inputBtn"><input type="button" id="writeBtn" class="fontStyle" value="일기 작성하기" /></div>
	<div id="diarySec">
		<div id="yearFilter">
		<p class="yFilter">#2023</p>
		<p class="yFilter">#2022</p>
		<p class="yFilter">#2021</p>
		<p class="yFilter">#2020</p>
		<p class="yFilter">#2019</p>
		<p class="yFilter">#2018</p>
		<p class="yFilter">#2017</p>
		</div>
		
		<% if(diaryList.isEmpty()) {%>
			<div>
				일기를 작성해보세요!
			</div>
		<% }else{ %>
		<div id="didiary">
			<div class="yearContainer">2023</div>
		<% for(Diary diary : diaryList){ 
			if(diary.getRegDate().toString().substring(0, 4).equals(yFilter)) %>
					<div id="diary">
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
							<div>
								<% if(diary.getRegDate().toString().equals(formatToday)){  %>
								<button id="updateBtn">수정하기</button>
								<% } %>
							</div>
						</div>
					</div>
		<% } %>
		</div>
		<% } %>
		</div>
	</div>
	</section>
	
	<!-- 일기 작성 모달 -->
	<div id="diaryEnrollBack">
		<div id="diaryEnrollModal" class="modal fontStyle">
			<div id="diaryEnrollTitle">일기작성</div>
			<span id="diaryEnrollClose" onclick="modalClose(this);">X</span>
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
											<img src="<%= request.getContextPath() %>/images/default.png" alt="첨부한 이미지" class="enrollImage" />
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
										<i id="enrollFontChoice" class="fa-solid fa-font"></i>
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
	
	<script>
	document.querySelector("#updateBtn").addEventListener("click", (e)=>{
		
		modal.style.display = 'flex';
	});
	/*
		일기년도 필터 메서드
	*/
	$(".yFilter").click((e)=>{
		console.log("sadfsadfd");
	});
	
	const modal = document.querySelector('#diaryEnrollBack');
	
	/*
	  일기쓰기 버튼 클릭 시 모달 창 띄우기
	*/
	document.querySelector("#writeBtn").addEventListener('click', () => {
		console.log(modal);
		modal.style.display = 'flex';
	});
	
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