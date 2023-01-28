<%@page import="common.OX"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	friendsList = (List<Friends>) session.getAttribute("friendsList");
	System.out.println("friendsList = " + friendsList);
%>
	<section class="fontStyle">
		<div id="friendsTitle" class="fontStyle">친구</div>
		
		<div id="search-container">
			<form action="<%= request.getContextPath() %>/friends/friendsFinder">
				<input type="hidden" name="memberNick" value="<%= loginMember.getNickname() %>" />
				<input type="text" id="searchNick" name="searchNick" size="30" placeholder="검색할 닉네임을 입력해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		<div id="friends-list">
			<table class="friends-list-table">
				<tbody>
		<%
			if (friendsList != null && !friendsList.isEmpty()) {
				for (Friends friend : friendsList) {
		%>
					<tr>
						<td>
						<% if (friend.getOriginalFileName() == null) { %>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="friendsImage" />							
						<% } %>
						</td>
						<td><%= friend.getfNickname() %></td>
						<td>
							<input id="friends-send-letter" class="friendsBtn fontStyle" type="button" data-friend-nick="<%= friend.getfNickname() %>" value="편지작성" />
						</td>
					<% if (friend.getIsFriend() == OX.O) { %>
						<td>
							<input class="friendsBtn fontStyle" type="button" value="친구삭제" />
						</td>
					<% } else { %>
						<td>
							<input class="friendsBtn fontStyle" type="button" value="요청취소" />
						</td>
					<% } %>
					</tr>
		<%
				}
			} else {
		%>
					<tr>
						<td colspan="4">조회된 친구 목록이 없습니다.</td>
					</tr>
		<%
			}
		%>
				</tbody>
			</table>
		</div>
	</section>
	
	<script>
		/*
		  편지 작성 버튼 클릭 시 펀지 작성 페이지로 이동하는 메소드
		*/
		document.querySelectorAll('#friends-send-letter').forEach((sendBtn) => {
			sendBtn.addEventListener('click', (e) => {
				const friendNick = e.target.dataset.friendNick;
				localStorage.setItem('friendNick', friendNick);
				location.href = '<%= request.getContextPath() %>/letter/writeLetter';				
			});
		});
	</script>
</body>
</html>