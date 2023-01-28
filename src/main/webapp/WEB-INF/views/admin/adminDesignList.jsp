<%@page import="style.model.dto.Part"%>
<%@page import="style.model.dto.Design"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Design> designList = (List<Design>) request.getAttribute("designList");
	String searchKeyword = request.getParameter("searchKeyword");
%>

    <section>
		<div id="adminTitle" class="fontStyle pointColor">디자인 목록</div>

		<div id="search-container">
			<label for="searchType">검색타입 : </label> 
			<input type="text" name="searchType" id="searchType" value="구분" readOnly />
	        
	        <div id="search-part" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/findStyle">
	                <input type="hidden" name="type" value="design"/>
	                <input type="radio" id="letterDesign" name="searchKeyword" value="L" <%= "L".equals(searchKeyword) ? "checked" : "" %>><label for="letterDesign"> 편지</label>
	                <input type="radio" id="diaryDesign" name="searchKeyword" value="D" <%= "D".equals(searchKeyword) ? "checked" : "" %>><label for="diaryDesign"> 일기장</label>
	                <button type="submit">검색</button>
	            </form>
			</div>
	    </div>
		
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
			} else {
		%>
					<tr>
						<td colspan="3">조회된 디자인 목록이 없습니다.</td>
					</tr>
		<%  } %>
	            </tbody>
	        </table>
		</div>
    </section>

</body>
</html>