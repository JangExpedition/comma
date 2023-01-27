<%@page import="common.Attachment"%>
<%@page import="customer.model.dto.Question"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Question question = (Question) request.getAttribute("question");
	List<Attachment> attachList = (List<Attachment>) request.getAttribute("attachList");
%>
	<section class="fontStyle">
		<div id="questionEnrollContainer">
			<div>
				<button id="goBack" class="buttonStyle">뒤로가기</button>
			</div>
			<div id=questionEnrollTitle class="pointColor">
				<h1>게시글 수정</h1>
			</div>
			<form id="questionUpdateFrm" name="questionUpdateFrm" action="<%= request.getContextPath() %>/customer/questionUpdate" method="POST" enctype="multipart/form-data">
				<table>
					<tr>
						<th class="lableTd pointColor">사진첨부</th>
						<td colspan="3">
					<%
					if(!attachList.isEmpty()){
						for(int i = 0; i < attachList.size(); i++){
							Attachment attach = attachList.get(i);
					%>
							<img class="alreadyImg" src="<%= request.getContextPath() %>/upload/question/<%= attach.getRenamedFilename() %>" alt=""/>
							<input type="checkbox" name="delFile" id="delFile<%= i %>" value="<%= attach.getNo() %>" />
	                  	 		<label for="delFile<%= i %>">삭제</label>
					<% 
						}
					} else {
					%>
							<input type="file" name="file1" id="file1" />
							<input type="file" name="file2" id="file2" />
							<input type="file" name="file3" id="file3" />
					<% } %>
						</td>
					</tr>
					<tr>
						<td id="titleTd" class="inputTd fontStyle" colspan="4">
							<input type="text" id="questionTitle" name="questionTitle" value="<%= question.getTitle() %>">
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div id="imgDiv">
									<img src="" alt="" id="img1" name="img1" class="img"/>
									<img src="" alt="" id="img2" name="img2" class="img"/>
									<img src="" alt="" id="img3" name="img3" class="img"/>
							</div>
						</td>
					</tr>
					<tr>
						<td id="contentTd" class="inputTd fontStyle" colspan="4">
							<textarea name="content" id="content" cols="" rows=""><%= question.getContent() %></textarea>
						</td>
					</tr>
					<tr>
						<td><input type="hidden" name="loginMember" value="<%= loginMember.getNickname() %>"/></td>
					</tr>
					<tr>
						<th colspan="4" id="submitTd"><input type="submit" id="write" class="fontStyle" value="수정하기"></th>
					<tr>
				</table>
				<input type="hidden" name="no" value="<%= question.getNo() %>"/>
			</form>
		</div>
	</section>
	<script>
		// 사진 변경 이벤트
		document.querySelector("#file1").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			const img = document.querySelector("#img1");
			const div = document.querySelector("#imgDiv");
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					div.style.height = "150px";
					document.querySelector("#content").style.height = "350px";
					img.src = e.target.result;
					img.style.display = "inline";
					div.style.display = "flex";
				};
			} else{
				document.querySelector("#imgDiv").style.height = "0";
				document.querySelector("#content").style.height = "500px";
				img.src = "";
				img.style.display = "none";
			}
			
		});
	
		document.querySelector("#file2").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			const img = document.querySelector("#img2");
			const div = document.querySelector("#imgDiv");
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					div.style.height = "150px";
					document.querySelector("#content").style.height = "350px";
					img.src = e.target.result;
					img.style.display = "inline";
					div.style.display = "flex";
				};
			} else{
				document.querySelector("#imgDiv").style.height = "0";
				document.querySelector("#content").style.height = "500px";
				img.src = "";
				img.style.display = "none";
			}
			
		});
	
		document.querySelector("#file3").addEventListener("change", (e)=>{
			const reader = new FileReader();
			const file = e.target;
			const img = document.querySelector("#img3");
			const div = document.querySelector("#imgDiv");
			
			if(file.files[0]){
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					div.style.height = "150px";
					document.querySelector("#content").style.height = "350px";
					img.src = e.target.result;
					img.style.display = "inline";
					div.style.display = "flex";
				};
			} else{
				document.querySelector("#imgDiv").style.height = "0";
				document.querySelector("#content").style.height = "500px";
				img.src = "";
				img.style.display = "none";
			}
			
		});
		
		
		// 뒤로가기 클릭 이벤트리스너
		document.querySelector("#goBack").addEventListener("click", (e)=>{
			location.href = "<%= request.getContextPath() %>/customer/questionView?no=<%= question.getNo() %>";
		});
	
		// questionUpdate 폼 제출
		document.questionUpdateFrm.onsubmit = (e) => {
			const frm = e.target;
			const no = <%= question.getNo() %>;
			console.log(no);
			
			//제목을 작성하지 않은 경우 폼제출할 수 없음.
			const titleVal = frm.questionTitle.value.trim(); // 좌우공백
			if(!/^.+$/.test(titleVal)){
				alert("제목을 작성해주세요.");
				frm.title.select();
				return false;
			}
							   
			//내용을 작성하지 않은 경우 폼제출할 수 없음.
			const contentVal = frm.content.value.trim();
			if(!/^(.|\n)+$/.test(contentVal)){
				alert("내용을 작성해주세요.");
				frm.content.select();
				return false;
			}
		};
	</script>
</body>
</html>