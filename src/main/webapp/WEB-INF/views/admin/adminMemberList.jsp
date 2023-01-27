<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
%>
	<section>
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
					<tr class="fontStyle">
						<th>프로필</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>회원권한</th>
						<th>생년월일</th>
						<th>나이</th>
						<th>성별</th>
						<th>누적경고횟수</th>
						<th>가입일</th>
						<td></td>
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
						<td>
							<select class="member-role" data-member-nickname="<%= member.getNickname() %>">
								<option value="<%= MemberRole.U %>" <%= member.getMemberRole() == MemberRole.U ? "selected" : "" %> >일반사용자</option>
								<option value="<%= MemberRole.A %>" <%= member.getMemberRole() == MemberRole.A ? "selected" : "" %> >관리자</option>
								<option value="<%= MemberRole.M %>" <%= member.getMemberRole() == MemberRole.M ? "selected" : "" %> >매니저</option>
							</select>
						</td>
						<td><%= member.getBirthday() %></td>
						<td><%= member.getAge() %></td>
						<td><%= member.getGender() %></td>
						<td><%= member.getWarningCount() %></td>
						<td><%= member.getEnrollDate() %></td>
						<td>
							<form action="<%= request.getContextPath() %>/admin/deleteMember" method="post" name="memberDeleteFrm">
								<input type="hidden" name="memberEmail" value="<%= member.getEmail() %>" />
								<input type="submit" id="delMemberBtn" class="delMemberBtn" value="탈퇴" />
							</form>
						</td>
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
	
	<form action="<%= request.getContextPath() %>/admin/updateMemberRole" method="post" name="memberRoleUpdateFrm">
		<input type="hidden" name="memberNick" />
		<input type="hidden" name="memberRole" />
	</form>

	<script>
		
		
		/*
		  회원 권한 변경 시 DB도 변경
		*/
		document.querySelectorAll(".member-role").forEach((select) => {
			select.addEventListener('change', (e) => {
				console.log(e.target.value);
				console.log(e.target.dataset.memberNickname);
				
				const memberNick = e.target.dataset.memberNickname;
				const memberRole = e.target.value;
	
				if (confirm(`[\${memberNick}] 회원의 권한을 \${memberRole}로 변경하시겠습니까?`)) {
					const frm = document.memberRoleUpdateFrm;
					frm.memberNick.value = memberNick;
					frm.memberRole.value = memberRole;
					frm.submit();				
				}
				else {
					e.target.querySelector("[selected]").selected = true;
				}
				
			});
		});
		
	</script>
</body>
</html>