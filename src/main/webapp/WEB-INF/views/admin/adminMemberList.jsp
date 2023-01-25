<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
%>
	<section class="fontStyle">
		<div id="adminTitle" class="fontStyle">회원목록</div>
		
		<div id="search-container">
			<form action="<%= request.getContextPath() %>/admin/adminMemberFinder">
				<input type="text" id="searchNick" name="searchNick" size="30" placeholder="검색할 닉네임을 입력해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		<div id="admin-list">
			<table class="admin-list-table">
				<tbody>
					<tr>
						<th>프로필</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>회원권한</th>
						<th>생년월일</th>
						<th>나이</th>
						<th>성별</th>
						<th>누적경고횟수</th>
						<th>가입일</th>
					</tr>
		<%
			if (memberList != null && !memberList.isEmpty()) {
				for (Member member : memberList) {
		%>
					<tr>
						<td>
						<% if (member.getOriginalFilename() == null) { %>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="adminImage" />							
						<% } else { %>							
							<img src="<%= request.getContextPath() %>/upload/profile/<%= member.getRenamedFilename() %>" alt="" class="adminImage" />							
						<% } %>
						</td>
						<td><%= member.getNickname() %></td>
						<td><%= member.getEmail() %></td>
						<td><%= member.getMemberRole() %></td>
						<td><%= member.getBirthday() %></td>
						<td><%= member.getAge() %></td>
						<td><%= member.getGender() %></td>
						<td><%= member.getWarningCount() %></td>
						<td><%= member.getEnrollDate() %></td>
					</tr>
		<%
				}
			} else {
		%>
					<tr>
						<td colspan="9">조회된 회원 목록이 없습니다.</td>
					</tr>
		<%
			}
		%>
				</tbody>
			</table>
		</div>
	</section>

</body>
</html>