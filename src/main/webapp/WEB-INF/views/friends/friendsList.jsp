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
						<td><%= friend.getNickname() %></td>
						<td>
							<input id="friends-send-letter" class="friendsBtn fontStyle" type="button" value="편지작성" />
						</td>
						<td>
							<input class="friendsBtn fontStyle" type="button" value="친구삭제" />
						</td>
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
		document.querySelector('#friends-send-letter').addEventListener('click', () => {
			location.href = '<%= request.getContextPath() %>/letter/writeLetter';
		});
	</script>
	
</body>
</html>