<%@page import="font.Font"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Font> FontList = (List<Font>) request.getAttribute("FontList");
%>

</body>
</html>