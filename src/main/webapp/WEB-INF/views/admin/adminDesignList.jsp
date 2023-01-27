<%@page import="style.model.dto.Part"%>
<%@page import="style.model.dto.Design"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Design> designList = (List<Design>) request.getAttribute("designList");
%>

    <section>
		<div id="adminTitle" class="fontStyle pointColor">디자인 목록</div>

		<form action="<%= request.getContextPath() %>/admin/adminDesignFinder">
			<input type="text" id="searchDesign" class="fontStyle" name="searchDesign" size="30" placeholder="검색할 디자인을 입력 해주세요." />
			<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
		</form>
		
		<div id="designBtn">
			<input type="button" id="designPlus" class="fontStyle" value="디자인 추가" onclick="<%= request.getContextPath() %>/admin/adminDesignEnroll" />
		</div>
		
        <div id="designContainer">
	        <table class="table">
	        	<thead>
	        		<tr>
	        			<th>구분</th>
	        			<th>디자인</th>
	        			<th></th>
	        		</tr>
	        	</thead>
	            <tbody>
		<%
			if (!designList.isEmpty()) {
				for (Design design : designList) {
		%>
	                <tr>
	                	<td><%= design.getPart() == Part.D ? "일기장" : "편지" %></td>
	                	<td>
	                <%
	                	if (design.getRenamedFilename() != null) {
	                %>
	                		<img src="<%= request.getContextPath() %>/upload/design/<%= design.getRenamedFilename() %>" class="img" alt="" />
	                <%
	                	} else {
	                %>
	                		<img src="<%= request.getContextPath() %>/images/default.png" class="img" alt="" />
	                <%
	                	}
	                %>
	                	</td>
	                	<td>
	                		<form action="<%= request.getContextPath() %>/admin/adminDesignUpdate" name="designUpdateFrm">
	                			<input type="hidden" name="no" value="<%= design.getNo() %>" />
								<input type="submit" id="designChange" class="fontStyle" value="디자인 수정" />
	                		</form>
	                	</td>
	                </tr>
		<%
				}
			}
		%>
	            </tbody>
	        </table>
		</div>
    </section>

</body>
</html>