<%@page import="common.Attachment"%>
<%@page import="customer.model.dto.Question"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Question question = (Question) request.getAttribute("question");
	List<Attachment> questionAttachList = question.getAttachments();
%>
	<section>
		<div id="questionDiv" class="tableDiv">
			<table id="questionViewTable">
				<tr>
					<th class="fontStyle">작성자</th>
					<td><%= question.getWriter() %></td>
				</tr>
				<tr>
					<td id="titleTd" class="inputTd fontStyle" colspan="2">
						<%= question.getTitle() %>
					</td>
				</tr>
				<tr>
					<td colspan="2">
				<%
					if (questionAttachList != null || !questionAttachList.isEmpty()) {
						for (Attachment attach : questionAttachList) {
				%>
						<img src="<%= request.getContextPath() %>/upload/question/<%= attach.getRenamedFilename() %>" alt="" class="img"/>
				<%
						}
					}
				%>
					</td>
				</tr>
				<tr>
					<td id="contentTd" class="inputTd fontStyle" colspan="2">
						<%= question.getContent() %>
					</td>
				</tr>
			</table>
		</div>
	</section>

</body>
</html>