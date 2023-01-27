<%@page import="design.Design"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Design> DesignList = (List<Design>) request.getAttribute("DesignList");
%>

<link rel="stylesheet" type="text/css" href="adminDesign.css">

<h1 class="con" class="fontStyle"  id="designList">디자인 목록</h1>

	<div id="search-window">
			<form action="<%= request.getContextPath() %>/admin/adminMemberFinder">
				<input type="text" id="searchDesign" name="searchDesign" size="30" placeholder="검색할 디자인을 입력 해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		
	<div id="design-btn">
		<input type="submit"  class="fontStyle" value="디자인 추가" />
		<input type="submit"  class="fontStyle" value="디자인 수정" />
	</div>	


    <section class="article-detail table-common con row">
        <div class="article-writer cell">
                <div class="writer-icon">디자인</div>
     
        </div>
        <table class="cell" border="1">
            <colgroup>
                <col width="100px">
            </colgroup>
            <tbody>
                <tr class="article-title" id="design-name">
                    <th>디자인 이름 : </th>
                    <td colspan="3">구름</td>
                </tr>
                <tr class="article-info" id="design-num">
                    <th>디자인 번호</th>
                    <td>5</td>
                    <th>디자인 링크</th>
                      <td><a href="">www.sdfsdahbfv</a></td>
                </tr>
                <tr class="article-body" id="write">
                    <td colspan="4">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sunt deleniti
                     repellat aliquam quis labore est error iste obcaecati laborum illo? Distinctio dolorem quis at 
                     assumenda! Perferendis, libero earum! Ducimus, ratione!</td>
                </tr>
            </tbody>
        </table>
    </section>
    
    
        <section class="article-detail table-common con row">
        <div class="article-writer cell">
                <div class="writer-icon" >디자인</div>
     
        </div>
        <table class="cell" border="1">
            <colgroup>
                <col width="100px">
            </colgroup>
            <tbody>
                <tr class="article-title" id="design-name">
                    <th>디자인 이름 : </th>
                    <td colspan="3">구름</td>
                </tr>
                <tr class="article-info" id="design-num">
                    <th>디자인 번호</th>
                    <td>4</td>
                    <th>디자인 링크</th>
                     <td><a href="">www.sdfsdahbfv</a></td>
                </tr>
                <tr class="article-body" id="write">
                    <td colspan="4">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sunt deleniti
                     repellat aliquam quis labore est error iste obcaecati laborum illo? Distinctio dolorem quis at 
                     assumenda! Perferendis, libero earum! Ducimus, ratione!</td>
                </tr>
            </tbody>
        </table>
    </section>
    
    
    
    
        <section class="article-detail table-common con row">
        <div class="article-writer cell">
                <div class="writer-icon" >디자인</div>
     
        </div>
        <table class="cell" border="1">
            <colgroup>
                <col width="100px">
            </colgroup>
            <tbody>
                <tr class="article-title" id="design-name">
                    <th>디자인 이름 : </th>
                    <td colspan="3">구름</td>
                </tr>
                <tr class="article-info" id="design-num">
                    <th>디자인 번호</th>
                    <td>3</td>
                    <th>디자인 링크</th>
                     <td><a href="">www.sdqwfhbfv</a></td>
                </tr>
                <tr class="article-body" id="write">
                    <td colspan="4">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sunt deleniti
                     repellat aliquam quis labore est error iste obcaecati laborum illo? Distinctio dolorem quis at 
                     assumenda! Perferendis, libero earum! Ducimus, ratione!</td>
                </tr>
            </tbody>
        </table>
    </section>
    
    
    
    
        <section class="article-detail table-common con row">
        <div class="article-writer cell">
                <div class="writer-icon" >디자인</div>
     
        </div>
        <table class="cell" border="1">
            <colgroup>
                <col width="100px">
            </colgroup>
            <tbody>
                <tr class="article-title" id="design-name">
                    <th>디자인 이름 : </th>
                    <td colspan="3">구름</td>
                </tr>
                
                <tr class="article-info" id="design-num">
                    <th>디자인 번호</th>
                    <td>2</td>
                    <th>디자인 링크</th>
                      <td><a href="">www.sdfhbfdfv</a></td>
                </tr>
                <tr class="article-body" id="write">
                    <td colspan="4">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sunt deleniti
                     repellat aliquam quis labore est error iste obcaecati laborum illo? Distinctio dolorem quis at 
                     assumenda! Perferendis, libero earum! Ducimus, ratione!</td>
                </tr>
            </tbody>
        </table>
    </section>
    
    
    
    
        <section class="article-detail table-common con row">
        <div class="article-writer cell">
                <div class="writer-icon" >디자인</div>
     
        </div>
        <table class="cell" border="1">
            <colgroup>
                <col width="100px">
            </colgroup>
            <tbody>
                <tr class="article-title" id="design-name">
                    <th>디자인 이름 : </th>
                    <td colspan="3">구름</td>
                </tr>
                <tr class="article-info" id="design-num">
                    <th>디자인 번호</th>
                    <td>1</td>
                    <th>디자인 링크</th>
                      <td><a href="">www.sdasfdfhbfv</a></td>
                </tr>
                <tr class="article-body" id="write">
                    <td colspan="4">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sunt deleniti
                     repellat aliquam quis labore est error iste obcaecati laborum illo? Distinctio dolorem quis at 
                     assumenda! Perferendis, libero earum! Ducimus, ratione!</td>
                </tr>
            </tbody>
        </table>
    </section>

</body>
</html>