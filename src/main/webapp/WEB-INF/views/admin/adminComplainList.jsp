<%@page import="complain.model.dto.Complain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Complain> complainList = (List<Complain>) request.getAttribute("complainList");

	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	System.out.println("searchType = " + searchType);
	System.out.println("searchKeyword = " + searchKeyword);
%>

	<style>
	    #search-villain {
	    	display: <%= searchType == null || "villain".equals(searchType) ? "inline-block" : "none" %>;
	    }
	    
	    #search-partition {
	    	display: <%= "partition".equals(searchType) ? "inline-block" : "none" %>;
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
				case "villain" :
					id = "search-villain";
					break;
				case "partition" :
					id = "search-partition";
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
		<div id="adminTitle" class="fontStyle">신고목록</div>
		
		<div id="search-container" class="fontStyle">
	        <label for="searchType">검색타입 :</label> 
	        <select id="searchType">
	            <option value="villain" <%= "villain".equals(searchType) ? "selected" : "" %>>피신고자</option>        
	            <option value="partition"  <%= "partition".equals(searchType) ? "selected" : "" %>>분류</option>
	            <option value="warning_count"  <%= "warning_count".equals(searchType) ? "selected" : "" %>>누적경고</option>
	        </select>
	        <div id="search-villain" class="search-type">
	            <form action="<%=request.getContextPath()%>/complain/complainFinder">
	                <input type="hidden" name="searchType" value="villain"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 피신고자를 입력하세요."
	                	value="<%= "villain".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>    
	        </div>
	        <div id="search-partition" class="search-type">
	            <form action="<%=request.getContextPath()%>/complain/complainFinder">
	                <input type="hidden" name="searchType" value="partition"/>
	                <input type="radio" id="letter" name="searchKeyword" value="LETTER" <%= "partition".equals(searchType) && "LETTER".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="letter"> 편지</label>
	                <input type="radio" id="counseling" name="searchKeyword" value="COUNSELING" <%= "partition".equals(searchType) && "COUNSELING".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="counseling"> 고민상담소</label>
	                <input type="radio" id="comment" name="searchKeyword" value="COMMENT" <%= "partition".equals(searchType) && "COMMENT".equals(searchKeyword) ? "checked" : "" %> />
	                <label for="comment"> 댓글</label>
	                <button type="submit">검색</button>
	            </form>
	        </div>
	        <div id="search-warningCnt" class="search-type">
	            <form action="<%=request.getContextPath()%>/complain/complainFinder">
	                <input type="hidden" name="searchType" value="warning_count"/>
	                <input type="number" name="searchKeyword"  size="25" placeholder="검색할 누적경고횟수를 입력하세요."
	                	value="<%= "warning_count".equals(searchType) ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>  
	        </div>
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
						<th></th>
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
						<td>
						<% if (complain.getWarningCnt() == 3) { %>
							<form action="<%= request.getContextPath() %>/admin/adminDeleteMemberNick" method="post" name="memberDeleteFrm">
								<input type="hidden" name="memberNick" />
								<input type="button" id="delMemberBtn" class="delMemberBtn memberBtn" value="탈퇴" data-member-nick="<%= complain.getVillain() %>" />
							</form>
							<script>
								/*
								  회원탈퇴
								*/
								document.querySelector('#delMemberBtn').addEventListener('click', (e) => {
									const memberNick = e.target.dataset.memberNick;
									
									if (confirm(`[\${memberNick}] 회원을 정말로 탈퇴시키시겠습니까?`)) {
										const frm = document.memberDeleteFrm;
										frm.memberNick.value = memberNick;
										frm.submit();
									}
								});
							</script>
						<% } %>
						</td>
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
		/*
		  신고누적횟수 변경 및 편지 안내
		*/
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