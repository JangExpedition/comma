<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section id="chat-container">	
	<h2>채팅</h2>
	<div id="msg-container">
		<ul></ul>
	</div>
	
	<div id="msg-editor" class="editor">
		<form name="chatMsgFrm">
			<textarea name="msg" id="msg" cols="30" rows="2" pattern="(.|\n)+"
				required></textarea>
			<button type="submit" id="send">Send</button>
		</form>
	</div>
</section>
<script>
document.chatMsgFrm.addEventListener("submit", (e)=>{
	e.preventDefault();
	
	const msg = {
		messageType : "CHAT_MSG",
		chatroomId : "<%= request.getParameter("chatroomId") %>",
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

