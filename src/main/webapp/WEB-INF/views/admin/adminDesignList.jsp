<%@page import="design.Design"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Design> DesignList = (List<Design>) request.getAttribute("DesignList");
%>

</body>
</html>