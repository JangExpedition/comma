<%@page import="java.util.ArrayList"%>
<%@page import="common.Attachment"%>
<%@page import="counseling.model.dto.Counseling"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Counseling> counselingList = (List<Counseling>) request.getAttribute("counselingList");
	List<Attachment> attachmentList = new ArrayList<>();
%>
	<section>
		<div id="adminTitle" class="fontStyle">고민상담소 목록</div>
		
		<div id="admin-list">
			<table class="admin-list-table">
				<tbody>
					<tr class="fontStyle">
						<th>제목</th>
						<th>작성자</th>
						<th>카테고리</th>
						<th>작성일자</th>
						<th>조회수</th>
						<th>공감수</th>
						<th></th>
					</tr>
		<%
			if (counselingList != null && !counselingList.isEmpty()) {
				for (Counseling counseling : counselingList) {
		%>
					<tr>
						<td><%= counseling.getTitle() %></td>
						<td><%= counseling.getWriter() %></td>
						<td><%= counseling.getCategory() %></td>
						<td><%= counseling.getRegDate() %></td>
						<td><%= counseling.getViews() %></td>
						<td><%= counseling.getLike() %></td>
						<td>
							<div class="btnFrm">
								<%-- <input type="button" id="detailBtn" class="detailBtn csBtn" value="상세보기" onclick="location.href='<%= request.getContextPath() %>/admin/adminCounselingView?no=<%= counseling.getNo() %>';" /> --%>
								<input type="button" id="delBtn" class="delBtn csBtn" value="삭제" data-cs-no="<%= counseling.getNo() %>" data-cs-title="<%= counseling.getTitle() %>" />
							</div>
						</td>
					</tr>
		<%
				}
			} else {
		%>
					<tr>
						<td colspan="9">조회된 고민상담소 목록이 없습니다.</td>
					</tr>
		<%
			}
		%>
				</tbody>
			</table>
		</div>
	</section>
	
	<form action="<%= request.getContextPath() %>/admin/adminCounselingDelete" method="post" name="csDeleteFrm">
		<input type="hidden" name="no" />
	</form>

	<script>
		/*
		  회원탈퇴
		*/
		document.querySelectorAll('.delBtn').forEach((del) => {
			del.addEventListener('click', (e) => {
				const csNo = e.target.dataset.csNo;
				const csTitle = e.target.dataset.csTitle;
				
				if (confirm(`[\${csTitle}] 게시글을 정말로 삭제 시키시겠습니까?`)) {
					const frm = document.csDeleteFrm;
					frm.no.value = csNo;
					frm.submit();
				}
			});
		});
	</script>
	
</body>
</html>