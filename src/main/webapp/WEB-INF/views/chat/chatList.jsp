<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section id="counselingSection">
		<div id="counselingContainer">
			<div id="counselingTitle" class="fontStyle pointColor"><h1>고민 상담소</h1></div>
			<div id = "counseilingCategory">
				<select name = "category">
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
			   	<input type = "button" id="CounselingEnroll" value="고민 게시하기">
			</div>
			<div id="wrap">
		    	<div class="table fontStyle">
			    		<div id="thead" class="tr pointColor">
			    			<div class="th">채팅방 이름</div>
			    			<div class="th">방장</div>
			    			<div class="th">참여인원</div>
			    			<div class="th">최대인원</div>
			    		</div>
			    		<%-- <% if(chatList.isEmpty()) {%>
			    			<div class="tr">
			    				<div class="td">현재 개설된 채팅방이 없습니다.</div>
			    			</div>
			    		<% 
			    		} else{ 
			    		}
			    		%> --%>
</div>
</div>
</div>
</section>
</body>
</html>