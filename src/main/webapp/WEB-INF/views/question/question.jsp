<%@page import="question.model.dto.Question"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>


<%
 List<Question> questionList = (List<Question>) request.getAttribute("questionList");
 %>

<section id="questionTotalList" class="fontStyle">
	<h1 id="enrollTitle" class="pointColor fontStyle">고객센터</h1>
	<hr>
	<div id="questionButton">
		<td colspan="6"><input type="button" value="FAQ" /></td>
		<td colspan="6"><input type="button" value="문의내역" /></td>
	</div>
	<br>
	<div id="questionList">
		<h1 id="enrollTitle" class="pointColor fontStyle">문의내역</h1>
	</div>
	<br>

	<!-- board seach area -->
	<div id="board-search">
		<div class="container">
			<div class="search-window">
				<form action="">
					<div class="search-wrap">
						<label for="search" class="blind">문의내역 검색</label> <input
							id="search" type="search" name="" placeholder="검색어를 입력해주세요."
							value="">
						<button type="submit" class="btn btn-dark">검색</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<br>

	<!-- board list area -->
	<div id="no-title-date">
		<table>
			<thead>
				<tr>
					<th scope="col" class="th-num">게시글 번호</th>
					<th scope="col" class="th-title">제목</th>
					<th scope="col" class="th-date">등록일</th>
				</tr>
			</thead>
			<tbody>
		<% 
                if (!questionList.isEmpty()) {
                	for (Question question : questionList) {
        %>
				<tr>
					<td><%= question.getNo() %></td>
					<th><a href="#!"><%= question.getTitle() %></a></th>
					<td><%= question.getRegDate() %></td>
				</tr>
		<%
                	}
                }
                else {
        %>
				<tr>
					<td>조회된 문의내역이 없습니다.</td>
				</tr>
		<%
                }
        %>
			</tbody>
		</table>
		<br>
	</div>
	<div id="inputBtn">
		<input type="button" id="writeBtn" class="fontStyle" value="질문작성" />
	</div>

	<br>
	<br>
	<br>


	<div>
		<h1 id="enrollTitle" class="pointColor fontStyle">FAQ</h1>
		<!-- board list area -->
		<div id="no-title-date">
			<table>
				<thead>
					<tr>
						<th scope="col" class="th-num">게시글 번호</th>
						<th scope="col" class="th-title">제목</th>
						<th scope="col" class="th-date">등록일</th>
					</tr>
				</thead>
		
				<tbody>
				
				<tr>
					<td>5</td>
					<th><a href="#!">편지 보낼 때 익명보장이 되는건가요?</a></th>
					<td>2022.01.06</td>
				</tr> 
				
					<tr>
						<td>4</td>
						<th><a href="#!">일기는 어떻게 쓰는건가요?</a></th>
						<td>2022.01.09</td>
					</tr>

					<tr>
						<td>3</td>
						<th><a href="#!">익명채팅방 생성은 어떤식으로 해아하나요?</a></th>
						<td>2022.01.12</td>
					</tr>

					<tr>
						<td>2</td>
						<th><a href="#!">친구신청은 어떻게 하나요?</a></th>
						<td>2022.01.17</td>
					</tr>

					<tr>
						<td>1</td>
						<th><a href="#!">편지 답장은 언제 받을 수 있는 건가요?</a></th>
						<td>2022.01.18</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

</section>
</body>
<script>
document.querySelector("#writeBtn").addEventListener('click', (e) => {
	location.href = "<%= request.getContextPath() %>/question/questionEnroll"
 });
</script>







