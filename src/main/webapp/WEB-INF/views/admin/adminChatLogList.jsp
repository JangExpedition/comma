<%@page import="chat.model.dto.ChatLog"%>
<%@page import="chat.model.dto.Chat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<ChatLog> chatLogList = (List<ChatLog>) request.getAttribute("chatLogList");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	System.out.println("searchType = " + searchType);
	System.out.println("searchKeyword = " + searchKeyword);
%>

	<style>
	    #search-chatMemberNick {
	    	display: <%= searchType == null || "member_nick".equals(searchType) ? "inline-block" : "none" %>;
	    }
	    
	    #search-content {
	    	display: <%= "content".equals(searchType) ? "inline-block" : "none" %>;
	    }
	</style>
	<script>
		window.addEventListener('load', () => {
			document.querySelector("#searchType").addEventListener('change', (e) => {
				console.log(e.target.value);
	
				// div 모두 숨김
				document.querySelectorAll(".search-type").forEach((div) => {
					div.style.display = "none";
				});
				
				// 현재 선택된 값에 상응하는 div만 노출
				let id;
				switch (e.target.value) {
				case "member_nick" :
					id = "search-chatMemberNick";
					break;
				case "content" :
					id = "search-content";
					break;
				}
				
				document.querySelector("#" + id).style.display = "inline-block";
			});
		});
	</script>
	
	<section>
		<div id="adminTitle" class="fontStyle">채팅목록</div>
		
		<div id="search-container" class="fontStyle">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option value="member_nick" <%= "member_nick".equals(searchType) ? "selected" : "" %>>닉네임</option>        
	            <option value="content"  <%= "content".equals(searchType) ? "selected" : "" %>>내용</option>
	        </select>
	        <div id="search-chatMemberNick" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminChatLogFinder">
	                <input type="hidden" name="searchType" value="member_nick"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 닉네임을 입력하세요."
	                	value="<%= "member_nick".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>
	        </div>
	        <div id="search-content" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminChatLogFinder">
	                <input type="hidden" name="searchType" value="content"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 내용을 입력하세요."
	                	value="<%= "content".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>  
	        </div>
	    </div>
		
		<div id="admin-list">
			<table class="admin-list-table">
				<tbody>
					<tr class="fontStyle">
						<th>닉네임</th>
						<th>내용</th>
						<th>이미지</th>
						<th>채팅일</th>
						<th></th>
					</tr>
		<%
			if (chatLogList != null && !chatLogList.isEmpty()) {
				for (ChatLog chatLog : chatLogList) {
		%>
					<tr>
						<td><%= chatLog.getMemberNick() %></td>
						<td><%= chatLog.getContent() %></td>
						<td>
					<% if (chatLog.getOriginalFilename() != null) { %>
							<img src="<%= request.getContextPath() %>/upload/chat/<%= chatLog.getRenamedFilename() %>" class="img" alt="" />
					<% } %>
						</td>
						<td><%= chatLog.getRegDate() %></td>
						<td>
							<div class="btnFrm">
								<input type="button" id="chatLogDelBtn" class="chatDelBtn chatBtn" value="삭제" data-log-no="<%= chatLog.getNo() %>" data-log-content="<%= chatLog.getContent() %>" />
							</div>
						</td>
					</tr>
		<%
				}
			} else {
		%>
					<tr>
						<td colspan="5">조회된 채팅 로그가 없습니다.</td>
					</tr>
		<%
			}
		%>
				</tbody>
			</table>
		</div>
	</section>
	
	<form action="<%= request.getContextPath() %>/admin/adminChatLogDelete" method="post" name="chatDeleteFrm">
		<input type="hidden" name="chatLogNo" />
	</form>

	<script>
		/*
		  회원탈퇴
		*/
		document.querySelectorAll('.chatDelBtn').forEach((del) => {
			del.addEventListener('click', (e) => {
				const chatLogNo = e.target.dataset.logNo;
				const chatLogContent = e.target.dataset.logContent;
				
				if (confirm(`[\${chatLogContent}] 채팅내역을 정말로 삭제하시겠습니까?`)) {
					const frm = document.chatDeleteFrm;
					frm.chatLogNo.value = chatLogNo;
					frm.submit();
				}
			});
		});
	</script>
</body>
</html>