<%@page import="chat.model.dto.Chat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Chat> chatList = (List<Chat>)request.getAttribute("chatList");
%>
<section id="chatSection">
	<div id="chatContainer">
		<div id="chatTitle" class="fontStyle pointColor"><h1>익명 채팅방</h1></div>
		<div id = "chatCategory">
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
		   	<input type = "button" id="ctreateChat" value="채팅방 개설하기">
		</div>
		<div id="wrap">
	    	<div class="table fontStyle">
		    		<div id="thead" class="tr pointColor">
		    			<div class="th">채팅방 이름</div>
		    			<div class="th">방장</div>
		    			<div class="th">참여인원</div>
		    			<div class="th">최대인원</div>
		    		</div>
		    		<% if(chatList.isEmpty()) {%>
		    			<div class="tr">
		    				<div class="td" id="noRoom">현재 개설된 채팅방이 없습니다.</div>
		    			</div>
		    		<% 
		    		} else{ 
		    			for(Chat chat : chatList) { %>
		    		<div class="tr" data-chat-no="<%= chat.getNo() %>">
						<div class="td"><%= chat.getChatName() %></div>
						<div class="td"><%= chat.getCaptin() %></div>
						<div class="td"><%-- <%= chatMemberList.get %> --%></div>
						<div class="td"><%= chat.getAbleCount() %></div>
					</div>
					<%
		    			}
		    		}
		    		%>
			</div>
		</div>
	</div>
</section>
<script>
	/*
	Date : 2023. 1. 27
	@장원정
	게시글 조회 메서드
	*/
	$(".tr").click((e)=>{
		location.href = "<%= request.getContextPath() %>/chat/chatView?chatNo=" + $(event.target).parent('.tr').data('chatNo');
	});
	/*
	Date : 2023. 1. 27
	@장원정
	게시글 조회 메서드
	*/
	document.querySelector("#ctreateChat").addEventListener('click', (e) => {
		location.href = "<%= request.getContextPath() %>/chat/chat";
	 });
</script>
</body>
</html>