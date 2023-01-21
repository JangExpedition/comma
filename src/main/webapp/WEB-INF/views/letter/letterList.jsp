<%@page import="letter.model.dto.Letter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Letter> letterList = (List<Letter>) request.getAttribute("letterList");
	System.out.println("letterList = " + letterList);
%>
	<section>
		<div id="letterTitle" class="fontStyle">받은 편지함</div>
	<% if (!letterList.isEmpty() && letterList != null) { %>
		<div id="letterList">
			받은 편지 내역이 존재합니다..
		</div>
	<% } else { %>
		<div id="letterList">
			받은 편지 내역이 존재하지 않습니다..
		</div>
	<% } %>
	</section>
</body>
</html>