<%@page import="style.model.dto.Design"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Design> designList = (List<Design>) request.getAttribute("designList");
%>

    <section class="article-detail table-common con row">
		<h1 class="con" class="fontStyle"  id="designList">디자인 목록</h1>

		<div id="search-window">
			<form action="<%= request.getContextPath() %>/admin/adminDesignFinder">
				<input type="text" id="searchDesign" name="searchDesign" size="30" placeholder="검색할 디자인을 입력 해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		<div id="design-btn">
			<input type="submit"  class="fontStyle" value="디자인 추가" />
			<input type="submit"  class="fontStyle" value="디자인 수정" />
		</div>	
        
        <div class="article-writer cell">
                <div class="writer-icon">디자인</div>
        </div>
        
        <table class="cell" border="1">
            <colgroup>
                <col width="100px">
            </colgroup>
            <tbody>
	<%
		if (designList.isEmpty()) {
			for (Design design : designList) {
	%>
                <tr>
                	<td><%= design.getPart() %></td>
                </tr>
	<%
			}
		}
	%>
            </tbody>
        </table>
    </section>

</body>
</html>