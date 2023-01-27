<%@page import="font.Font"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Font> FontList = (List<Font>) request.getAttribute("FontList");
%>
 <div id="adminTitle" class="fontStyle">폰트 목록</div>
 
 	<div id="search-window">
			<form action="<%= request.getContextPath() %>/admin/adminMemberFinder">
				<input type="text" id="searchFonrt" name="searchFont" size="30" placeholder="검색할 폰트를 입력 해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
 
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class=" font-num">폰트 번호</th>
                    <th scope="col" class="font-name">폰트 이름 </th>
                    <th scope="col" class="font-link">폰트 링크</th>
                </tr>
                </thead>
                <tbody>
                
                    <tr>
                    <td>5</td>
                    <th>
                      <a href="#!"></a>ㅁ</th>
                    <td>링크</td>
                </tr>
                
                    <tr>
                    <td>3</td>
                    <th>
                      <a href="#!"></a>ㅁ</th>
                    <td>링크</td>
                </tr>
                
                <tr>
                    <td>3</td>
                    <th>
                      <a href="#!"></a>ㅁ</th>
                    <td>링크</td>
                </tr>

                <tr>
                    <td>2</td>
                    <th><a href="#!">다</a></th>
                    <td>링크</td>
                </tr>

                <tr>
                    <td>1</td>
                    <th><a href="#!">다</a></th>
                    <td>링크</td>
                </tr>
                
              
                </tbody>
            </table>
        </div>
    </div>




</body>
</html>
 
