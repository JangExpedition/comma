<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page import="counseling.model.dto.Counseling" %>
<%@ page import="common.Attachment" %>
<%
	Counseling counseling = (Counseling)request.getAttribute("counseling");
	List<Attachment> attachList = counseling.getAttachments();
%>
<section id="csViewerSection">
	<div id="csContainer">
		<div id="titleContainer">
			<span id="csCategory"><%= counseling.getCategory() %></span>
			<h1 id="csTitle"><%= counseling.getTitle() %></h1>
			<div id="smallBox">
				<p><%= counseling.getWriter() %></p>
				<p><%= counseling.getRegDate() %></p>
			</div>
		</div>
		<% if(attachList.isEmpty()){ %>
		<div id="csContent" >
			<%= counseling.getContent() %>
		</div>
		<% } else{ %>
		<div id="csContent" >
			<div id="imgDiv" name="imgDiv">
				<img src="<%= attachList.get(0) != null ? attachList.get(0).getRenamedFilename() : null %>" alt="" id="img1" name="img1" class="img"/>
				<img src="<%= attachList.get(1) != null ? attachList.get(1).getRenamedFilename() : null %>" alt="" id="img2" name="img2" class="img"/>
				<img src="<%= attachList.get(2) != null ? attachList.get(2).getRenamedFilename() : null %>" alt="" id="img3" name="img3" class="img"/>
			</div>
			<%= counseling.getContent() %>
		</div>
		<% } %>
	</div>
</section>
</body>
</html>