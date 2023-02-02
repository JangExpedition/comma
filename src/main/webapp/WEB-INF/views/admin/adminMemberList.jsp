<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Member> memberList = (List<Member>) request.getAttribute("memberList");
	
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	System.out.println("searchType = " + searchType);
	System.out.println("searchKeyword = " + searchKeyword);
%>
	<style>
	    #search-memberNick {
	    	display: <%= searchType == null || "nickname".equals(searchType) ? "inline-block" : "none" %>;
	    }
	    
	    #search-gender {
	    	display: <%= "gender".equals(searchType) ? "inline-block" : "none" %>;
	    }
	    
	    #search-warningCnt {
	    	display: <%= "warning_count".equals(searchType) ? "inline-block" : "none" %>;
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
				case "nickname" :
					id = "search-memberNick";
					break;
				case "gender" :
					id = "search-gender";
					break;
				case "warning_count" :
					id = "search-warningCnt";
					break;
				}
				
				document.querySelector("#" + id).style.display = "inline-block";
			});
		});
	</script>
	<section>
		<div id="adminTitle" class="fontStyle">회원목록</div>
		
		<div id="search-container" class="fontStyle">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option value="nickname" <%= "nickname".equals(searchType) ? "selected" : "" %>>닉네임</option>        
	            <option value="gender"  <%= "gender".equals(searchType) ? "selected" : "" %>>성별</option>
	            <option value="warning_count"  <%= "warning_count".equals(searchType) ? "selected" : "" %>>누적경고</option>
	        </select>
	        <div id="search-memberNick" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminMemberFinder">
	                <input type="hidden" name="searchType" value="nickname"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 닉네임을 입력하세요."
	                	value="<%= "member_nickname".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>    
	        </div>
	        <div id="search-gender" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminMemberFinder">
	                <input type="hidden" name="searchType" value="gender"/>
	                <input type="radio" name="searchKeyword" id="genderM" value="M" <%= "gender".equals(searchType) && "M".equals(searchKeyword) ? "checked" : "" %>><label for="genderM"> 남</label>
	                <input type="radio" name="searchKeyword" id="genderF" value="F" <%= "gender".equals(searchType) && "F".equals(searchKeyword) ? "checked" : "" %>><label for="genderF"> 여</label>
	                <button type="submit">검색</button>
	            </form>
	        </div>
	        <div id="search-warningCnt" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/adminMemberFinder">
	                <input type="hidden" name="searchType" value="warning_count"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 누적경고횟수를 입력하세요."
	                	value="<%= "warning_count".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>  
	        </div>
	    </div>
		
		<div id="admin-list">
			<table class="admin-list-table">
				<tbody>
					<tr class="fontStyle">
						<th>프로필</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>권한</th>
						<th>생년월일</th>
						<th>나이</th>
						<th>성별</th>
						<th>누적경고</th>
						<th>가입일</th>
						<th></th>
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
							<div class="btnFrm">
						<% if (member.getMemberRole() == MemberRole.U) { %>
								<input type="button" id="sendLetterBtn" class="sendLetterBtn memberBtn" value="편지" data-member-nick="<%= member.getNickname() %>" />
								<script>
									/*
									  해당 회원에게 편지 보내기
									*/
									document.querySelectorAll('.sendLetterBtn').forEach((send) => {
										send.addEventListener('click', (e) => {
											localStorage.setItem('friendNick', e.target.dataset.memberNick);
											location.href = '<%= request.getContextPath() %>/letter/writeLetter';
										});
									});
								</script>
						<% } %>
						<% if (!member.getEmail().equals(loginMember.getEmail())) { %>
								<input type="button" id="delMemberBtn" class="delMemberBtn memberBtn" value="탈퇴" data-member-nick="<%= member.getNickname() %>" data-member-email="<%= member.getEmail() %>" />
						<% } %>
							</div>
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
	<form action="<%= request.getContextPath() %>/admin/deleteMember" method="post" name="memberDeleteFrm">
		<input type="hidden" name="memberEmail" />
	</form>
	<script>
		/*
		  회원탈퇴
		*/
		document.querySelectorAll('.delMemberBtn').forEach((del) => {
			del.addEventListener('click', (e) => {
				e.preventDefault();
				
				const memberNick = e.target.dataset.memberNick;
				const memberEmail= e.target.dataset.memberEmail;
				
				if (confirm(`[\${memberNick}] 회원을 정말로 탈퇴시키시겠습니까?`)) {
					const frm = document.memberDeleteFrm;
					frm.memberEmail.value = memberEmail;
					frm.submit();
				}
			});
		});
		
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