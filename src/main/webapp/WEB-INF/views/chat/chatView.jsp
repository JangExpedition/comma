<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@page import="chat.model.dto.ChatLog" %>
<%
	List<ChatLog> chatLogs = (List<ChatLog>)request.getAttribute("chatLogs");
%>
<section id="chatSection">	
	<div id="chatContainer">	
		<h2 id="chatTitle" class="fontStyle pointColor">익명채팅방</h2>
		<div id="msgContainer">
		<% if(chatLogs != null){ 
				for(ChatLog log : chatLogs){ %>
			<div class="left fontStyle"><span class="sender"><%= log.getMemberNick() %></span> <span id="message" class="pointColor"><%= log.getContent() %></span></div>
		<% }
		} %>
		</div>
		<div id="msgEditor" class="editor">
			<form name="chatMsgFrm" id="chatMsgFrm">
				<textarea name="msg" id="msg" cols="30" rows="2" pattern="(.|\n)+"
					required></textarea>
				<button type="submit" id="send" class="fontStyle">보내기</button>
			</form>
		</div>
	</div>
</section>
<script>

$(".<%= loginMember.getNickname() %>").css("align-items", "flex-end");

document.querySelector("#msg").addEventListener("keyup", (e)=>{
	if(e.keyCode === 13){
		document.querySelector("#send").click();
	};
});

document.chatMsgFrm.addEventListener("submit", (e)=>{
	e.preventDefault();
	
	
	if(/^\n/.test(e.target.msg.value)){
		console.log(e.target.msg.value);
		e.target.msg.value = null;
		return;
	};
	
	const msg = {
		messageType : "CHAT_MSG",
		chatNo : "<%= request.getParameter("chatNo") %>",
		sender : "<%= loginMember.getNickname() %>",
		message : e.target.msg.value,
		datetime : Date.now()
	};
	
	ws.send(JSON.stringify(msg));
	
	e.target.reset();
	
	e.target.msg.focus();
});
</script>	
</body>
</html>

