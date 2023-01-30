<%@page import="style.model.dto.Font"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Font> fontList = (List<Font>) session.getAttribute("fontList");
	String searchKeyword = request.getParameter("searchKeyword");
%>
	
	<section>
		<div id="adminTitle" class="fontStyle pointColor">폰트 목록</div>
	
		<div id="search-container" class="fontStyle">
	        <div id="search-name" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/findStyle">
	                <input type="hidden" name="searchType" value="font"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 폰트를 입력하세요."
	                	value="<%= searchKeyword != null ? searchKeyword : "" %>" />
	                <button type="submit">검색</button>            
	            </form>    
	        </div>
	    </div>

		<div id="fontPlusDiv">
			<input type="button" class="fontStyle" id="fontplus" value="폰트 추가" />
		</div>
		
		<div class="fontContainer">
		    <table class="table">
		        <thead class="thead">
		            <tr>
		                <th>번호</th>
		                <th>폰트 이름</th>
		                <th>폰트 링크</th>
		                <th></th>
		            </tr>
		        </thead>
		        <tbody class="tbody">
        <%
	        if (!fontList.isEmpty()) {
	        	for (Font font : fontList) {
	    %>
		            <tr style="font-family:<%= font.getName() %>">
		                <td><%= font.getRnum() %></td>
						<td><%= font.getName() %></td>
						<td><%= font.getLink() %></td>
						<td>
							<input type="button" class="fontStyle fontChange" id="fontchange" value="폰트 수정" data-font-no=<%= font.getNo() %> data-font-name="<%= font.getName() %>" data-font-link="<%= font.getLink() %>" />							
						</td>
		            </tr>
	    <%
	        	} // for end
	        } else {
        %>
        			<tr>
        				<td colspan="3">조회된 폰트가 존재하지 않습니다.</td>
        			</tr>
        <%
	        } // else end
        %>
		        </tbody>
		    </table>
		</div>
	</section>

	<!-- 폰트 추가 모달 -->
	<div id="fontEnrollBack" class="modalBack">
		<div id="fontEnrollModal" class="modal fontStyle">
			<div id="fontEnrollTitle" class="modalTitle">폰트 추가</div>
			<span id="fontEnrollClose" class="modalClose" onclick="modalClose(this);">X</span>
			<div id="fontEnroll" class="modalDiv">
				<form method="post" action="<%= request.getContextPath() %>/admin/adminFontEnroll" name="fontEnrollFrm">
					<table id="fontEnrollTable" class="modalTable">
						<tr>
							<th class="fontStyle">작성자</th>
							<td><input type="text" id="writerInput" name="writer" value="<%= loginMember.getNickname() %>" readOnly /></td>
						</tr>
						<tr>
							<th class="fontStyle">폰트이름</th>
							<td><input type="text" id="writerInput" name="name" /></td>
						</tr>
						<tr>
							<th class="fontStyle">링크</th>
							<td><input type="text" id="writerInput" name="link" /></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" id="fontEnrollBtn" class="modalBtn pointColor fontStyle" value="추가하기">                   
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<!-- 폰트 수정 모달 -->
	<div id="fontUpdateBack" class="modalBack">
		<div id="fontUpdateModal" class="modal fontStyle">
			<div id="fontUpdateTitle" class="modalTitle">폰트 수정</div>
			<span id="fontUpdateClose" class="modalClose" onclick="modalClose(this);">X</span>
			<div id="fontUpdate" class="modalDiv">
				<form method="post" action="<%= request.getContextPath() %>/admin/adminFontUpdate" name="fontUpdateFrm">
					<table id="fontUpdateTable" class="modalTable">
						<tr>
							<th class="fontStyle">작성자</th>
							<td>
								<input type="text" id="updateWriter" name="writer" value="<%= loginMember.getNickname() %>" readOnly />
								<input type="hidden" id="updateNo" name="no" />
							</td>
						</tr>
						<tr>
							<th class="fontStyle">폰트이름</th>
							<td><input type="text" id="updateName" name="name" /></td>
						</tr>
						<tr>
							<th class="fontStyle">링크</th>
							<td><input type="text" id="updateLink" name="link" /></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" id="fontUpdateBtn" class="modalBtn pointColor fontStyle" value="수정하기">                   
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	
	<script>
		const enrollModal = document.querySelector('#fontEnrollBack');
		const updateModal = document.querySelector('#fontUpdateBack');
		
		/*
		  폰트 수정 버튼 클릭 시 모달 창 띄우기
		*/
		document.querySelectorAll('.fontChange').forEach((change) => {
			change.addEventListener('click', (e) => {
				e.preventDefault();
				console.log(e.target);
				updateModal.style.display = 'flex';

				const no = e.target.dataset.fontNo;
				const name = e.target.dataset.fontName;
				const link = e.target.dataset.fontLink;
				const updateFrm = document.fontUpdateFrm;
				
				updateFrm.updateNo.value = no;
				updateFrm.updateName.value = name;
				updateFrm.updateLink.value = link;
			});
		});
		
		/*
		  폰트 추가 버튼 클릭 시 모달 창 띄우기
		*/
		document.querySelector("#fontplus").addEventListener('click', () => {
			enrollModal.style.display = 'flex';
		});
		
		/*
		  모달 창 이외의 부분 클릭 시 창 닫기
		*/
		enrollModal.addEventListener('click', (e) => {
			if(e.target !== e.currentTarget) return;
			enrollModal.style.display = 'none';
			updateModal.style.display = 'none';
		});
		
		/*
		  X 클릭 시 창 닫기
		*/
		const modalClose = (target) => {
			console.log(target.id);
			if (target.id != '') {
				enrollModal.style.display = 'none';
				updateModal.style.display = 'none';
			}
		};
	</script>
</body>
</html>

 


 
