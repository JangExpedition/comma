<%@page import="customer.model.dto.FAQ"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<FAQ> faqList = (List<FAQ>) request.getAttribute("faqList");
%>

	<section>
		<div id="enrollTitle" class="pointColor fontStyle" onclick="history.back();">고객센터</div>
	
		<form method="post" action="<%= request.getContextPath() %>/customer/faqEnroll">
			<table id="faqEnrollTable">
				<tr>
					<th class="fontStyle">작성자</th>
					<td><input type="text" id="writerInput" name="writer" value="<%= loginMember.getNickname() %>" /></td>
				</tr>
				<tr>
					<td id="titleTd" class="inputTd fontStyle" colspan="2">
						<input type="text" id="faqTitle" name="faqTitle" placeholder="제목을 입력해 주세요." required>
					</td>
				</tr>
				<tr>
					<td id="contentTd" class="inputTd fontStyle" colspan="2">
						<textarea name="content" id="content" cols="" rows="" placeholder="내용을 작성해 주세요."></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" id="faqEnroll" class="faqBtn fontStyle" value="등록하기">                   
					</td>
				</tr>
			</table>
		</form>
	</section>
</body>
</html>