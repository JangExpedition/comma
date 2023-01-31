<%@page import="style.model.dto.Part"%>
<%@page import="style.model.dto.Font"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	String type = (String) request.getAttribute("type");
	List<Font> fontList = (List<Font>) session.getAttribute("fontList");
	List<Design> designList = (List<Design>) session.getAttribute("designList");
	String searchKeyword = request.getParameter("searchKeyword");
%>
	
	<section>
		<div id="adminTitle" class="fontStyle pointColor">폰트 및 디자인 목록</div>
		
		<div id="styleButton" >
			<input type="hidden" name="searchType" value="<%= type %>" />
			<input id="styleFontBtn" class="styleBtn fontStyle" type="button" value="폰트" />
			<input id="styleDesignBtn" class="styleBtn fontStyle" type="button" value="디자인" />
		</div>
		
		<!-- 폰트 목록 Div -->
		<div id="fontListDiv">
			<div id="search-container">
				<form action="<%= request.getContextPath() %>/admin/findStyle">
					<input type="hidden" name="searchType" value="font" />
					<input type="text" id="searchContent" name="searchContent" size="30" placeholder="검색할 내용을 입력해주세요." />
					<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
				</form>
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
			
			    <div class="page-wrap">
			
			        <ul class="page-nation">
			            <li><a href="/board/list?p=1">1</a></li>
			            <li><a href="/board/list?p=2">2</a></li>
			            <li><a href="/board/list?p=3">3</a></li>
			            <li><a href="/board/list?p=4">4</a></li>
			            <li><a href="/board/list?p=5">5</a></li>
			        </ul>
			    </div>
			</div>
		</div>
		
		<!-- 디자인 목록 Div -->
		<div id="designListDiv" style="display: none;">
			<div id="search-container">
				<form action="<%= request.getContextPath() %>/admin/findStyle">
					<input type="hidden" name="searchType" value="design" />
	                <input type="radio" id="letterDesign" name="searchKeyword" value="L" <%= "L".equals(searchKeyword) ? "checked" : "" %>><label for="letterDesign"> 편지</label>
	                <input type="radio" id="diaryDesign" name="searchKeyword" value="D" <%= "D".equals(searchKeyword) ? "checked" : "" %>><label for="diaryDesign"> 일기장</label>
					<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
				</form>
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
							<td>
								<input type="text" id="writerInput" name="writer" value="<%= loginMember.getNickname() %>" readOnly />
							</td>
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
								<input type="file" name="upFile" id="upFile" accept="image/*" required />
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
								<input type="file" name="upFile" id="updateFile" accept="image/*" />
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
		let type = "<%= type %>" == null ? "font" : "<%= type %>";
		window.onload = (e) => {			
			if (type === 'font') {
				styleFontBtn.click();
			} else {
				styleDesignBtn.click();
			}
		};
		
		const styleFontBtnClick = (e) => {
			e.target.classList.add('styleBtnClick');
			styleDesignBtn.classList.remove('styleBtnClick');
			
			fontListDiv.style.display = '';
			document.querySelector('#designListDiv').style.display = 'none';
			
			document.querySelector('[name=searchType]').value = 'font';
		};
		
		const styleDesignBtnClick = (e) => {
			e.target.classList.add('styleBtnClick');
			styleFontBtn.classList.remove('styleBtnClick');
			
			document.querySelector('#designListDiv').style.display = '';
			fontListDiv.style.display = 'none';

			document.querySelector('[name=searchType]').value = 'design';
		};
		
		/*
		  폰트 클릭 시 클래스 추가 및 div 숨기거나 보이게
		*/
		styleFontBtn.addEventListener('click', (e) => {
			styleFontBtnClick(e);
		});
		
		/*
		  디자인 클릭 시 클래스 추가 및 div 숨기거나 보이게
		*/
		styleDesignBtn.addEventListener('click', (e) => {				
			styleDesignBtnClick(e);
		});
		
		const fontEnrollModal = document.querySelector('#fontEnrollBack');
		const fontUpdateModal = document.querySelector('#fontUpdateBack');
		const designEnrollModal = document.querySelector('#designEnrollBack');
		const designUpdateModal = document.querySelector('#designUpdateBack');
		
		/*
		  폰트 수정 버튼 클릭 시 모달 창 띄우기
		*/
		document.querySelectorAll('.fontChange').forEach((change) => {
			change.addEventListener('click', (e) => {
				e.preventDefault();
				console.log(e.target);
				fontUpdateModal.style.display = 'flex';

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
			fontEnrollModal.style.display = 'flex';
		});
		
		/*
		  모달 창 이외의 부분 클릭 시 창 닫기
		*/
		fontEnrollModal.addEventListener('click', (e) => {
			if(e.target !== e.currentTarget) return;
			fontEnrollModal.style.display = 'none';
			fontUpdateModal.style.display = 'none';
		});
		
		/*
		  디자인 수정 버튼 클릭 시 모달 창 띄우기
		*/
		document.querySelectorAll('.designChange').forEach((change) => {
			change.addEventListener('click', (e) => {
				e.preventDefault();
				console.log(e.target);
				designUpdateModal.style.display = 'flex';

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
			designEnrollModal.style.display = 'flex';
		});
		
		/*
		  모달 창 이외의 부분 클릭 시 창 닫기
		*/
		designEnrollModal.addEventListener('click', (e) => {
			if(e.target !== e.currentTarget) return;
			designEnrollModal.style.display = 'none';
			designUpdateModal.style.display = 'none';
		});
		
		/*
		  X 클릭 시 창 닫기
		*/
		const modalClose = (target) => {
			console.log(target.id);
			if (target.id != '') {
				fontEnrollModal.style.display = 'none';
				fontUpdateModal.style.display = 'none';
				designEnrollModal.style.display = 'none';
				designUpdateModal.style.display = 'none';
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
