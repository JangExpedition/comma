<%@page import="chat.model.dto.Chat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	List<Chat> chatList = (List<Chat>)session.getAttribute("chatList");
	if(!chatList.isEmpty()){
		System.out.println(chatList.get(0).getChatPwd());
	}
%>
<section id="chatSection">
	<div id="chatContainer">
		<div id="chatTitle" class="fontStyle pointColor"><h1>익명 채팅방</h1></div>
		<div id = "chatCategory">
			<select name="category" id ="chatCate">
					<option value="" disabled selected>카테고리를 선택하세요.</option>
					<option value="ALL">전체</option>
					<option value="STUDY">진로</option>
					<option value="LOVE">연애</option>
					<option value="FAMILY">가족</option>
					<option value="CHILDCARE">육아</option>
					<option value="CAREER">직장</option>
					<option value="DAILY">일상</option>
					<option value="FRIENDS">친구</option>
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
		    			for(Chat chat : chatList) { 
		    			String canEnter = (chat.getAbleCount() == chat.getNowCount() ? "cant" : "can" );
		    			System.out.println("chatList.jsp = " + chat + "==============");
		    			%>
		    		<div class="tr <%= canEnter %>" data-chat-no="<%= chat.getNo() %>">
						<div class="td"><%= chat.getChatName() %></div>
						<div class="td"><%= chat.getCaptin() %></div>
						<div class="td"><%= chat.getNowCount() %></div>
						<div class="td"><%= chat.getAbleCount() %></div>
					</div>
					<%
		    			}
		    		}
		    		%>
			</div>
		</div>
	</div>
	<div id="pwdBackground">
		<div id="pwdBox">
			<div id="XBox" class="fontStyle"><div id="X">X</div></div>
			<span id="infoPwd" class="fontStyle white">비밀번호가 있는 채팅방입니다.</span>
			<form action="" name="insertPwd">
				<input id="chatPwd" type="password" placeholder="비밀번호를 입력해주세요." />
				<input type="submit" id="insertPwdBtn" class="fontStyle" value="입력" />
			</form>
		</div>
	</div>
</section>
<form action="<%= request.getContextPath() %>/chat/chatList" name="changeCsCateFrm">
	<input type="hidden" id="chatCate" name="chatCate" />
</form>
<script>
	document.querySelector("#chatCate").addEventListener("change", (e)=>{
		const frm = document.changeCsCateFrm;
		frm.chatCate.value = e.target.value;
		frm.submit();
	});

	$(".tr").css("pointEvent", "none");
	
	let pwd = 0;
	let chatNo = 0;
    
	
	$(".tr").click((e)=>{
		chatNo = $(event.target).parent('.tr').data('chatNo');
		$.ajax({
			url : "<%= request.getContextPath() %>/chat/selectOneChat",
			dataType: "json",
			data: {chatNo},
			success(data){
				const nowCount = data.nowCount;
				const ableCount = data.ableCount;
				
				if(nowCount == ableCount){
					alert("정원이 가득찬 채팅방입니다.");
					return;
				}
				
				if(data.chatPwd == null){
					location.href = "<%= request.getContextPath() %>/chat/chatView?chatNo=" + chatNo;
				}else{
					pwd = data.chatPwd;
					pwdBackground.style.display = "flex";
				}
				
			}
		})
	});
	
	document.querySelector("#X").addEventListener("click", (e)=>{
		chatPwd.value = "";
		document.querySelector("#pwdBackground").style.display = "none";
	});
	document.querySelector("#pwdBackground").addEventListener("click", (e)=>{
		if(e.target !== e.currentTarget){
			return;
		}
		chatPwd.value = "";
		document.querySelector("#pwdBackground").style.display = "none";
	});
	
	document.insertPwd.addEventListener("submit", (e)=>{
		e.preventDefault();
		console.log(pwd, chatPwd.value);
		if(pwd == chatPwd.value){
			location.href = "<%= request.getContextPath() %>/chat/chatView?chatNo=" + chatNo;
		} else{
			alert("비밀번호가 일치하지 않습니다.");
			chatPwd.value = "";
		}
	});
	
	document.querySelector("#ctreateChat").addEventListener('click', (e) => {
		location.href = "<%= request.getContextPath() %>/chat/chat";
	 });
</script>
</body>
</html>