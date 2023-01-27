<%@page import="style.model.dto.Font"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Font> fontList = (List<Font>) request.getAttribute("fontList");
%>
	<section>
		<div id="adminTitle" class="fontStyle"><h1>폰트 목록</h1></div>
	
		<form action="<%= request.getContextPath() %>/admin/adminFontFinder">
			<input type="text" id="searchFont" name="searchFont" size="30" placeholder="검색할 폰트를 입력 해주세요." />
			<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
		</form>

		<div>
			<input type="submit" class="fontStyle" id="fontplus" value="폰트 추가" />
		</div>
		
		<div class="board">
		    <table class="table">
		        <thead class="thead">
		            <tr>
		                <td>번호</td>
		                <td>폰트 이름</td>
		                <td>폰트 링크</td>
		            </tr>
		        </thead>
		        <tbody class="tbody">
        <%
	        if (fontList.isEmpty()) {
	        	for (Font font : fontList) {
	    %>
		            <tr>
		                <td><%= font.getNo() %></td>
						<td><%= font.getName() %></td>
						<td><%= font.getLink() %></td>
						<td>
							<form action="<%= request.getContextPath() %>/admin/adminFontUpdate" name="fontUpdateFrm" method="post">
								<input type="hidden" name="no" value=<%= font.getNo() %> />
								<input type="submit" class="fontStyle" id="fontchange" value="폰트 수정" />							
							</form>
						</td>
		            </tr>
	    <%
	        	} // for end
	        } else {
        %>
        			<tr>
        				<td colspan="3">조회된 폰트가 존재하지 않습니다.</td>
        			</tr>
        <%
	        } // else end
        %>
		        </tbody>
		    </table>
		
		    <div class="page-wrap">
		
		        <ul class="page-nation">
		            <li><a href="/board/list?p=1">1</a></li>
		            <li><a href="/board/list?p=2">2</a></li>
		            <li><a href="/board/list?p=3">3</a></li>
		            <li><a href="/board/list?p=4">4</a></li>
		            <li><a href="/board/list?p=5">5</a></li>
		        </ul>
		    </div>
		</div>
	</section>
 
 	
			
 

</body>
</html>

 


 
