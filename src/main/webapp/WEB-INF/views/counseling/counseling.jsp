<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section id="counselingTotalList" class="fontStyle">


	<div id="counselingTitle"><h1>고민 상담소</h1></div>
	<form action="<%= request.getContextPath()%>/counseling/counselingList">
	<div id = "counseilingCategory"><select name = "category">
	<option value="" disabled selected>카테고리를 선택하세요.</option>
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
			<c:forEach var="posting" items="${list }">
				<tr>
					<td>${posting.num }</td>
					<td>${posting.title }</td>
					<td>${posting.name }</td>
					<td>${posting.writeDate }</td>
					<td>${posting.readCount }</td>
				</tr>
				</form>
				</div>
			</c:forEach>
    	</table>
    </div>
</body>
</html>
	