<%@page import="customer.model.dto.FAQ"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	FAQ faq = (FAQ) request.getAttribute("faq");
%>

	<section>
		<div id="faqEnrollContainer">
			<div id="goBackDiv">
				<button id="goBack" class="buttonStyle">뒤로가기</button>
			</div>
		
			<div id="enrollTitle" class="pointColor fontStyle" onclick="history.back();">고객센터</div>
		
			<form method="post" action="<%= request.getContextPath() %>/customer/faqUpdate">
				<table id="faqEnrollTable">
					<tr>
						<th class="fontStyle">작성자</th>
						<td><input type="text" id="writerInput" name="writer" value="<%= loginMember.getNickname() %>" /></td>
					</tr>
					<tr>
						<td id="titleTd" class="inputTd fontStyle" colspan="2">
							<input type="text" id="faqTitle" name="faqTitle" value="<%= faq.getTitle() %>" required>
						</td>
					</tr>
					<tr>
						<td id="contentTd" class="inputTd fontStyle" colspan="2">
							<textarea name="content" id="content" cols="" rows="" ><%= faq.getContent() %></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="hidden" name="faqNo" value="<%= faq.getNo() %>" />
							<input type="submit" id="faqEnroll" class="faqBtn fontStyle" value="수정하기">                   
						</td>
					</tr>
				</table>
			</form>
		</div>
	</section>
	
	<script>
		// 뒤로가기 클릭 이벤트리스너
		document.querySelector("#goBack").addEventListener("click", (e)=>{
			location.href = "<%= request.getContextPath() %>/customer";
		});
	</script>
</body>
</html>