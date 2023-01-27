<%@page import="complain.model.dto.Complain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Complain> complainList = (List<Complain>) request.getAttribute("complainList");
%>
	<section>
		<div id="adminTitle" class="fontStyle">신고목록</div>
		
		<div id="search-container">
			<form action="<%= request.getContextPath() %>/complain/complainFinder">
				<input type="text" id="searchContent" name="searchContent" size="30" placeholder="검색할 닉네임을 입력해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		<div id="admin-list">
			<table class="admin-list-table">
				<tbody>
					<tr class="fontStyle">
						<th>신고자</th>
						<th>피신고자</th>
						<th>신고누적개수</th>
						<th>신고분류</th>
						<th>내용</th>
						<th>신고일</th>
					</tr>
		<%
			if (complainList != null && !complainList.isEmpty()) {
				for (Complain complain : complainList) {
		%>
					<tr>
						<td><%= complain.getWriter() %></td>
						<td><%= complain.getVillain() %></td>
						<td>
							<input class="warning-cnt" type="number" min=<%= complain.getWarningCnt() %> max=3 value="<%= complain.getWarningCnt() %>" data-member-nick="<%= complain.getVillain() %>" />
						</td>
						<td><%= complain.getPartition() %></td>
						<td><%= complain.getContent() %></td>
						<td><%= complain.getRegDate() %></td>
					</tr>
		<%
				}
			} else {
		%>
					<tr>
						<td colspan="5">조회된 신고 목록이 없습니다.</td>
					</tr>
		<%
			}
		%>
				</tbody>
			</table>
		</div>
		<form action="<%= request.getContextPath() %>/complain/warningCountUpdate" name="complainUpdateFrm" method="post">
			<input type="hidden" name="memberNick" />
			<input type="hidden" name="warningCnt" />
			<input type="hidden" name="letterContent" />
		</form>
	</section>

	<script>
		document.querySelectorAll(".warning-cnt").forEach((cnt) => {
			cnt.addEventListener('change', (e) => {
				console.log(e.target.value);
				console.log(e.target.dataset.memberNick);
				
				const memberNick = e.target.dataset.memberNick;
				const warningCnt = e.target.value;
	
				if (confirm(`[\${memberNick}] 회원의 신고누적횟수를 \${warningCnt}로 변경하시겠습니까?`)) {
					const frm = document.complainUpdateFrm;
					frm.memberNick.value = memberNick;
					frm.warningCnt.value = warningCnt;
					frm.letterContent.value = `부적절한 내용으로 경고 횟수가 증가되어 [\${warningCnt}]입니다.\n경고 3번 누적 시 회원 탈퇴되오니 이 점 유의하시기 바랍니다.`;
					frm.submit();				
				}
			});
		});
	</script>
</body>
</html>