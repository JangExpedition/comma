<%@page import="common.OX"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	friendsList = (List<Friends>) session.getAttribute("friendsList");
	List<Friends> receiveFriendsList = (List<Friends>) request.getAttribute("receiveFriendsList");
	System.out.println("friendsList = " + friendsList);
	System.out.println("receiveFriendsList = " + receiveFriendsList);
%>
	<section class="fontStyle">
		<div id="friendsTitle" class="fontStyle">친구</div>
		
		<div id="search-container">
			<form action="<%= request.getContextPath() %>/friends/friendsFinder">
				<input type="hidden" name="memberNick" value="<%= loginMember.getNickname() %>" />
				<input type="text" class="fontStyle id="searchNick" name="searchNick" size="30" placeholder="검색할 닉네임을 입력해주세요." />
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
							<form action="<%= request.getContextPath() %>/friends/friendsDelete" method="post" name="friendDeleteFrm">
								<input type="hidden" name="myNick" value="<%= friend.getMyNickname() %>" />
								<input type="hidden" name="fNick" value="<%= friend.getfNickname() %>" />
								<input class="friendsBtn fontStyle" type="submit" value="친구삭제" />
							</form>
						</td>
					<% } else { %>
						<td>
							<form action="<%= request.getContextPath() %>/friends/friendsDelete" method="post" name="friendDeleteFrm">
								<input type="hidden" name="myNick" value="<%= friend.getMyNickname() %>" />
								<input type="hidden" name="fNick" value="<%= friend.getfNickname() %>" />
								<input class="friendsBtn fontStyle" type="submit" value="요청취소" />
							</form>
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
	
	<section class="fontStyle">
		<div id="friendsTitle" class="fontStyle">받은 친구 목록</div>
		
		<div id="friends-list">
			<table class="friends-list-table">
				<tbody>
		<%
			if (receiveFriendsList != null && !receiveFriendsList.isEmpty()) {
				for (Friends friend : receiveFriendsList) {
		%>
					<tr>
						<td>
						<% if (friend.getOriginalFileName() == null) { %>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="friendsImage" />							
						<% } %>
						</td>
						<td><%= friend.getfNickname() %></td>
						<td>
							<form action="<%= request.getContextPath() %>/friends/friendsUpdate" method="post" name="isFriendUpdateFrm">
								<input type="hidden" name="myNick" value="<%= friend.getfNickname() %>" />
								<input type="hidden" name="fNick" value="<%= friend.getMyNickname() %>" />
								<input class="friendsBtn fontStyle" type="submit" value="요청수락" />
							</form>
						</td>
						<td>
							<form action="<%= request.getContextPath() %>/friends/friendsDelete" method="post" name="friendDeleteFrm">
								<input type="hidden" name="myNick" value="<%= friend.getfNickname() %>" />
								<input type="hidden" name="fNick" value="<%= friend.getMyNickname() %>" />
								<input class="friendsBtn fontStyle" type="submit" value="요청삭제" />
							</form>
						</td>
					<% } %>
					</tr>
		<%
			} else {
		%>
					<tr>
						<td colspan="4">받은 친구 신청이 없습니다.</td>
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