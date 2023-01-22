<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="counseling.model.dto.Counseling" %>
<%
	List<Counseling> counselingList = (List<Counseling>)request.getAttribute("counselingList");
	System.out.println(counselingList);
%>

<section id="counselingTotalList" class="fontStyle">


	<div id="counselingTitle"><h1>고민 상담소</h1></div>
	
	<div id = "counseilingCategory"><select name = "category">
	<option value="" disabled selected>카테고리를 선택하세요.</option>
	<option value ="all">전체</option>
	<option value ="study">진로</option>
	<option value ="love">연애</option>
	<option value ="family">가족</option>
	<option value ="childcare">육아</option>
	<option value ="career">직장</option>
	<option value ="daily">일상</option>
	<option value ="friends">친구</option>
	</select>
	
	
	<tr>
    <td><input type = "button" id="CounselingEnroll" value="고민 게시하기"></td>
    </tr>
	<br><br>
	</div>
	
	    <div id="wrap">
    	<table>
    		<br>
    			<th>글번호</th>
    			<th>글제목</th>
    			<th>작성자</th>
    			<th>작성날짜</th>
    			<th>조회수</th>
    		</tr>
    		<% if(counselingList.isEmpty()) {%>
    			<td colspan="5">등록된 게시물이 없습니다.</td>
    		<% 
    		} else{ 
    		for(Counseling counseling : counselingList){
    		%>
				<tr>
					<td><%= counseling.getNo() %></td>
					<td><%= counseling.getTitle() %></td>
					<% if("O" == counseling.getAnonymous().toString()) { %>
					<td>익명</td>
					<% }else{ %>
					<td><%= counseling.getWriter() %></td>
					<% } %>
					<td><%= counseling.getRegDate() %></td>
					<td><%= counseling.getViews() %></td>
				</tr>
			<% } 
			} %>
				</div>
    	</table>
    </div>
    
    <script>
    document.querySelector("#CounselingEnroll").addEventListener('click', (e) => {
    	location.href = "<%= request.getContextPath() %>/counseling/counselingEnroll"
     });
    </script>
</body>
</html>
	