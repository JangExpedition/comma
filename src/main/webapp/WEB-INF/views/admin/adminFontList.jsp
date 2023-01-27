<%@page import="font.Font"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Font> FontList = (List<Font>) request.getAttribute("FontList");
%>
 <div id="adminTitle" class="fontStyle"><h1>폰트 목록</h1></div>
 
 	<div id="search-window">
			<form action="<%= request.getContextPath() %>/admin/adminMemberFinder">
				<input type="text" id="searchFonrt" name="searchFont" size="30" placeholder="검색할 폰트를 입력 해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
 
 <section class="main">

        <h1 class="d-none">게시판</h1>
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

                        <tr>
                            <td>6</td>
                              <td>구름</td>
                              <td><a href="">www.sdfdgdg</a></td>
                        </tr>

                        <tbody class="tbody">

                            <tr>
                                <td>5</td>
                                <td>손편지</td>
                                <td><a href="">www.sdfhbfv</a></td>
                            </tr>
                            
                             <tr>
                                <td>4</td>
                                <td>손편지</td>
                                <td><a href="">www.sdfhbfv</a></td>
                            </tr>
                            
                             <tr>
                                <td>3</td>
                                <td>손편지</td>
                                <td><a href="">www.sdfhbfv</a></td>
                            </tr>
                            
                             <tr>
                                <td>2</td>
                                <td>손편지</td>
                                <td><a href="">www.sdfhbfv</a></td>
                            </tr>
                            
                            
                              <tr>
                                <td>1</td>
                                <td>손편지</td>
                                <td><a href="">www.sdfhbfv</a></td>
                            </tr>
                            
                            
                        </tbody>
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

 


 
