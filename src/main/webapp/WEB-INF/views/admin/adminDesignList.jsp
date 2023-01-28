<%@page import="style.model.dto.Part"%>
<%@page import="style.model.dto.Design"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	//List<Design> designList = (List<Design>) request.getAttribute("designList");
	String searchKeyword = request.getParameter("searchKeyword");
%>

    <section>
		<div id="adminTitle" class="fontStyle pointColor">디자인 목록</div>

		<div id="search-container">
			<label for="searchType">검색타입 : </label> 
			<input type="text" name="searchType" id="searchType" value="구분" readOnly />
	        
	        <div id="search-part" class="search-type">
	            <form action="<%=request.getContextPath()%>/admin/findStyle">
	                <input type="hidden" name="type" value="design"/>
	                <input type="radio" id="letterDesign" name="searchKeyword" value="L" <%= "L".equals(searchKeyword) ? "checked" : "" %>><label for="letterDesign"> 편지</label>
	                <input type="radio" id="diaryDesign" name="searchKeyword" value="D" <%= "D".equals(searchKeyword) ? "checked" : "" %>><label for="diaryDesign"> 일기장</label>
	                <button type="submit">검색</button>
	            </form>
			</div>
	    </div>
		
		<div id="designBtn">
			<input type="button" id="designPlus" class="fontStyle" value="디자인 추가" />
		</div>
		
        <div id="designContainer">
	        <table class="table">
	        	<thead>
	        		<tr>
	        			<th>구분</th>
	        			<th>디자인</th>
	        			<th></th>
	        		</tr>
	        	</thead>
	            <tbody>
		<%
			if (!designList.isEmpty()) {
				for (Design design : designList) {
		%>
	                <tr>
	                	<td><%= design.getPart() == Part.D ? "일기장" : "편지" %></td>
	                	<td>
	                <%
	                	if (design.getRenamedFilename() != null) {
	                %>
	                		<img src="<%= request.getContextPath() %>/upload/design/<%= design.getRenamedFilename() %>" class="img" alt="" />
	                <%
	                	} else {
	                %>
	                		<img src="<%= request.getContextPath() %>/images/default.png" class="img" alt="" />
	                <%
	                	}
	                %>
	                	</td>
	                	<td>
							<input type="button" id="designChange" class="designChange fontStyle" value="디자인 수정" data-design-no=<%= design.getNo() %> data-design-part="<%= design.getPart() %>" data-design-file="<%= design.getRenamedFilename() %>" />
	                	</td>
	                </tr>
		<%
				}
			} else {
		%>
					<tr>
						<td colspan="3">조회된 디자인 목록이 없습니다.</td>
					</tr>
		<%  } %>
	            </tbody>
	        </table>
		</div>
    </section>

	<!-- 디자인 추가 모달 -->
	<div id="designEnrollBack" class="modalBack">
		<div id="designEnrollModal" class="modal designModal fontStyle">
			<div id="designEnrollTitle" class="modalTitle">디자인 추가</div>
			<span id="designEnrollClose" class="modalClose" onclick="modalClose(this);">X</span>
			<div id="designEnroll" class="modalDiv designModalDiv">
				<form method="post" action="<%= request.getContextPath() %>/admin/adminDesignEnroll" name="designEnrollFrm" enctype="multipart/form-data">
					<table id="designEnrollTable" class="modalTable">
						<tr>
							<th class="fontStyle">작성자</th>
							<td><input type="text" id="writerInput" name="writer" value="<%= loginMember.getNickname() %>" readOnly /></td>
						</tr>
						<tr>
							<th class="fontStyle">구분</th>
							<td>
								<input type="radio" id="letter" name="part" value="L" checked /><label for="letter">편지</label>
								<input type="radio" id="diary" name="part" value="D" /><label for="diary">일기</label>
							</td>
						</tr>
						<tr>
							<th class="fontStyle">이미지</th>
							<td>
								<img id="img" src="" alt="" class="uploadImg" /><br />
								<input type="file" name="upFile" id="upFile" required />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" id="designEnrollBtn" class="modalBtn pointColor fontStyle" value="추가하기">                   
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<!-- 디자인 수정 모달 -->
	<div id="designUpdateBack" class="modalBack">
		<div id="designUpdateModal" class="modal designModal fontStyle">
			<div id="designUpdateTitle" class="modalTitle">디자인 수정</div>
			<span id="designUpdateClose" class="modalClose" onclick="modalClose(this);">X</span>
			<div id="designUpdate" class="modalDiv designModalDiv">
				<form method="post" action="<%= request.getContextPath() %>/admin/adminDesignUpdate" name="designUpdateFrm" enctype="multipart/form-data">
					<table id="designUpdateTable" class="modlaTable">
						<tr>
							<th class="fontStyle">작성자</th>
							<td>
								<input type="text" id="writerInput" name="writer" value="<%= loginMember.getNickname() %>" readOnly />
								<input type="hidden" id="updateNo" name="updateNo" />
							</td>
						</tr>
						<tr>
							<th class="fontStyle">구분</th>
							<td>
								<input type="radio" id="updateLetter" name="part" value="L" /><label for="letter">편지</label>
								<input type="radio" id="updateDiary" name="part" value="D" /><label for="diary">일기</label>
							</td>
						</tr>
						<tr>
							<th class="fontStyle">이미지</th>
							<td>
								<img id="updateImg" src="" alt="" class="uploadImg" /><br />
								<input type="file" name="upFile" id="updateFile" required />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" id="designUpdateBtn" class="modalBtn pointColor fontStyle" value="수정하기">                   
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	
	<script>
		const enrollModal = document.querySelector('#designEnrollBack');
		const updateModal = document.querySelector('#designUpdateBack');
		
		/*
		  디자인 수정 버튼 클릭 시 모달 창 띄우기
		*/
		document.querySelectorAll('.designChange').forEach((change) => {
			change.addEventListener('click', (e) => {
				e.preventDefault();
				console.log(e.target);
				updateModal.style.display = 'flex';

				const no = e.target.dataset.designNo;
				const part = e.target.dataset.designPart;
				const file = e.target.dataset.designFile;
				const updateFrm = document.designUpdateFrm;
				
				updateFrm.updateNo.value = no;
				updateFrm.updateLetter.checked = part == "<%= Part.L %>" ? true : false;
				updateFrm.updateDiary.checked = part == "<%= Part.D %>" ? true : false;
				updateFrm.updateImg.src = file != "null" ? ("<%= request.getContextPath() %>/upload/design/" + file) : "";
			});
		});
		
		/*
		  디자인 추가 버튼 클릭 시 모달 창 띄우기
		*/
		document.querySelector("#designPlus").addEventListener('click', () => {
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

		/*
		  이미지 업로드 시 미리보기
		*/
		document.querySelector("#upFile").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			const img = document.querySelector("#img");
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					img.src = e.target.result;
					img.style.display = "inline";
				};
			} else{
				img.src = "";
				img.style.display = "none";
			}
		});


		/*
		  이미지 업로드 시 미리보기
		*/
		document.querySelector("#updateFile").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			const img = document.querySelector("#updateImg");
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					img.src = e.target.result;
					img.style.display = "inline";
				};
			} else{
				img.src = "";
				img.style.display = "none";
			}
		});
	</script>

</body>
</html>