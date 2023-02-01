<%@page import="java.util.ArrayList"%>
<%@page import="common.Attachment"%>
<%@page import="counseling.model.dto.Counseling"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Counseling> counselingList = (List<Counseling>) request.getAttribute("counselingList");
	List<Attachment> attachmentList = new ArrayList<>();

	String orderBy = request.getParameter("orderBy");
	String searchKeyword = request.getParameter("searchKeyword");
%>
	<section>
		<div id="adminTitle" class="fontStyle">고민상담소 목록</div>
		
		<div id="search-container" class="fontStyle">
	        <div id="search-category" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/counselingFinder" name="counselingFinderFrm">
	                <input type="hidden" name="searchType" value="category"/>
	                <input type="radio" id="all" name="searchKeyword" value="all" <%= searchKeyword == null || "all".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="all"> 전체</label>
	                <input type="radio" id="daily" name="searchKeyword" value="DAILY" <%= "DAILY".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="daily"> 일상</label>
	                <input type="radio" id="career" name="searchKeyword" value="CAREER" <%= "CAREER".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="career"> 직장</label>
	                <input type="radio" id="love" name="searchKeyword" value="LOVE" <%= "LOVE".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="love"> 연애</label>
	                <input type="radio" id="friends" name="searchKeyword" value="FRIENDS" <%= "FRIENDS".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="friends"> 친구</label>
	                <input type="radio" id="family" name="searchKeyword" value="FAMILY" <%= "FAMILY".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="family"> 가족</label>
	                <input type="radio" id="study" name="searchKeyword" value="STUDY" <%= "STUDY".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="study"> 진로</label>
	                <input type="radio" id="childcare" name="searchKeyword" value="CHILDCARE" <%= "CHILDCARE".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="childcare"> 육아</label>
	                <button type="submit">검색</button>
	                <br />
	                <div id="orderByList">
		                <select name="orderBy" id="orderBy" class="fontStyle">
							<option value="reg_date" <%= orderBy == null || "reg_date".equals(orderBy) ? "selected" : "" %>>작성일자순</option>
							<option value="views" <%= "views".equals(orderBy) ? "selected" : "" %>>조회수순</option>
							<option value="cs_like" <%= "cs_like".equals(orderBy) ? "selected" : "" %>>공감수순</option>
						</select>
	                </div>
	            </form>
	        </div>
	    </div>
		
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
		
		/*
		  정렬 조건 변경 시 폼 제출 메소드
		*/
		document.querySelector('#orderBy').addEventListener('change', (e) => {
			console.log('ddd');
			document.counselingFinderFrm.submit();
		});
	</script>
	
</body>
</html>