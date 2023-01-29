<%@page import="chat.model.dto.Chat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Chat> chatList = (List<Chat>) request.getAttribute("chatList");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	System.out.println("searchType = " + searchType);
	System.out.println("searchKeyword = " + searchKeyword);
%>
	<style>
	    #search-chatName {
	    	display: <%= searchType == null || "name".equals(searchType) ? "inline-block" : "none" %>;
	    }
	    
	    #search-captin {
	    	display: <%= "captin".equals(searchType) ? "inline-block" : "none" %>;
	    }
	    
	    #search-gender {
	    	display: <%= "able_gender".equals(searchType) ? "inline-block" : "none" %>;
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
				case "name" :
					id = "search-chatName";
					break;
				case "captin" :
					id = "search-captin";
					break;
				case "able_gender" :
					id = "search-gender";
					break;
				}
				
				document.querySelector("#" + id).style.display = "inline-block";
			});
		});
	</script>
	<section>
		<div id="adminTitle" class="fontStyle" onclick="location.href='<%= request.getContextPath() %>/admin/adminChatList';">채팅목록</div>
		
		<div id="search-container" class="fontStyle">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option value="name" <%= "name".equals(searchType) ? "selected" : "" %>>채팅방이름</option>        
	            <option value="captin"  <%= "captin".equals(searchType) ? "selected" : "" %>>방장</option>
	            <option value="able_gender"  <%= "able_gender".equals(searchType) ? "selected" : "" %>>성별</option>
	        </select>
	        <div id="search-chatName" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminChatFinder">
	                <input type="hidden" name="searchType" value="name"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 채팅방명을 입력하세요."
	                	value="<%= "name".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>    
	        </div>
	        <div id="search-captin" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminChatFinder">
	                <input type="hidden" name="searchType" value="captin"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 방장 닉네임을 입력하세요."
	                	value="<%= "captin".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>  
	        </div>
	        <div id="search-gender" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminChatFinder">
	                <input type="hidden" name="searchType" value="able_gender"/>
	                <input type="radio" name="searchKeyword" value="M" <%= "able_gender".equals(searchType) && "M".equals(searchKeyword) ? "checked" : "" %>> 남
	                <input type="radio" name="searchKeyword" value="F" <%= "able_gender".equals(searchType) && "F".equals(searchKeyword) ? "checked" : "" %>> 여
	                <input type="radio" name="searchKeyword" value="X" <%= "able_gender".equals(searchType) && "X".equals(searchKeyword) ? "checked" : "" %>> 무관
	                <button type="submit">검색</button>
	            </form>
	        </div>
	    </div>
		
		<div id="admin-list">
			<table class="admin-list-table">
				<tbody>
					<tr class="fontStyle">
						<th>채팅방이름</th>
						<th>방장</th>
						<th>제한성별</th>
						<th>제한연령</th>
						<th>참여인원</th>
						<th>최대인원</th>
						<th>생성일</th>
						<th></th>
					</tr>
		<%
			if (chatList != null && !chatList.isEmpty()) {
				for (Chat chat : chatList) {
		%>
					<tr>
						<td><%= chat.getChatName() %></td>
						<td><%= chat.getCaptin() %></td>
						<td><%= chat.getAbleGender() %></td>
						<td><%= chat.getAbleAge() %></td>
						<td><%= chat.getNowCount() %></td>
						<td><%= chat.getAbleCount() %></td>
						<td><%= chat.getRegDate() %></td>
						<td>
							<div class="btnFrm">
								<input type="button" id="chatLogBtn" class="chatLogBtn chatBtn" value="로그보기" onclick="location.href='<%= request.getContextPath() %>/admin/adminChatLog?no=<%= chat.getNo() %>';" />
								<%-- <input type="button" id="chatMemberBtn" class="chatMemberBtn chatBtn" value="참여회원" data-chat-no="<%= chat.getNo() %>" /> --%>
								<input type="button" id="chatDelBtn" class="chatDelBtn chatBtn" value="삭제" data-chat-no="<%= chat.getNo() %>" data-chat-name="<%= chat.getChatName() %>" />
							</div>
						</td>
					</tr>
		<%
				}
			} else {
		%>
					<tr>
						<td colspan="8">조회된 채팅 목록이 없습니다.</td>
					</tr>
		<%
			}
		%>
				</tbody>
			</table>
		</div>
	</section>
	
	<form action="<%= request.getContextPath() %>/admin/adminChatDelete" method="post" name="chatDeleteFrm">
		<input type="hidden" name="chatNo" />
	</form>

	<script>
		/*
		  회원탈퇴
		*/
		document.querySelectorAll('.chatDelBtn').forEach((del) => {
			del.addEventListener('click', (e) => {
				const chatNo = e.target.dataset.chatNo;
				const chatName = e.target.dataset.chatName;
				
				if (confirm(`[\${chatName}] 채팅방을 정말로 삭제하시겠습니까?`)) {
					const frm = document.chatDeleteFrm;
					frm.chatNo.value = chatNo;
					frm.submit();
				}
			});
		});
	</script>
</body>
</html>