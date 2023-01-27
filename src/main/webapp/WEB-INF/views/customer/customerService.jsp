<%@page import="customer.model.dto.FAQ"%>
<%@page import="customer.model.dto.Question"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
	List<Question> questionList = (List<Question>) request.getAttribute("questionList");
	List<FAQ> faqList = (List<FAQ>) request.getAttribute("faqList");
%>

	<section id="questionTotalList" class="fontStyle">
		<div id="enrollTitle" class="pointColor fontStyle">고객센터</div>
		<hr>
		
		<div id="customerButton" >
			<input type="button" value="FAQ" />
			<input type="button" value="문의내역" />
		</div>

		<div id="search-container">
			<form action="<%= request.getContextPath() %>/customer/questionFinder">
				<input type="text" id="searchContent" name="searchContent" size="30" placeholder="검색할 내용을 입력해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		<div id="questionDiv">
			<table id="questionTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
			<%
				if (questionList != null) {
			%>
					<tr>
						<td>조회된 문의 내역이 없습니다..</td>
					</tr>
			<%
				} else {
					for (Question question : questionList) {
			%>
					<tr>
						<td><%= question.getNo() %></td>
						<td>
							<a href="<%= request.getContextPath() %>/question/questionView?no=<%= question.getNo() %>"><%= question.getTitle() %></a>
						</td>
						<td><%= question.getRegDate() %></td>
					</tr>
			<%
					} // for end
				} // else end
			%>
				</tbody>
			</table>
			
			<div id="inputBtn">
				<input type="button" id="writeBtn" class="fontStyle" value="질문작성" />
			</div>
			
		</div>


		
		<div id="faqDiv">
			<table id="faqTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>내용</th>
					</tr>
				</thead>
				<tbody>
			<%
				if (faqList != null) {
			%>
					<tr>
						<td>조회된 문의 내역이 없습니다..</td>
					</tr>
			<%
				} else {
					for (FAQ faq : faqList) {
			%>
					<tr>
						<td><%= faq.getNo() %></td>
						<td><%= faq.getTitle() %></td>
						<td><%= faq.getContent() %></td>
					</tr>
			<%
					} // for end
				} // else end
			%>
				</tbody>
			</table>
		</div>

	</section>
	
	<script>
	document.querySelector("#writeBtn").addEventListener('click', (e) => {
		location.href = "<%= request.getContextPath() %>/question/questionEnroll"
	 });
	</script>

</body>
</html>