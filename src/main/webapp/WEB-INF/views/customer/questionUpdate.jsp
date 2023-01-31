<%@page import="common.Attachment"%>
<%@page import="customer.model.dto.Question"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Question question = (Question) request.getAttribute("question");
	List<Attachment> attachList = question.getAttachments();
%>
	<section class="fontStyle">
		<div id="questionUpdateContainer">
			<div>
				<button id="goBack" class="buttonStyle">뒤로가기</button>
			</div>
			<div id=counselingEnrollTitle class="pointColor">
				<h1>게시글 수정</h1>
			</div>
			<%--
			<form id="questionUpdateFrm" name="questionUpdateFrm" enctype="multipart/form-data">
			--%>
			<form id="questionUpdateFrm" name="questionUpdateFrm" action="<%= request.getContextPath() %>/customer/questionUpdate" method="POST" enctype="multipart/form-data">
				<table>
					<tr>
						<th class="lableTd pointColor">사진첨부</th>
						<td colspan="3">
						<%
						if(!attachList.isEmpty()){
							int size = attachList.size();
							for(int i = 0; i < attachList.size(); i++){
								Attachment attach = attachList.get(i);
						%>
							<img class="alreadyImg" src="<%= request.getContextPath() %>/upload/question/<%= attach.getRenamedFilename() %>" alt=""/>
							<input type="checkbox" name="delFile" id="delFile<%= i %>" value="<%= attach.getNo() %>" />
                  	 		<label for="delFile<%= i %>">삭제</label>
                  	 		<input type="file" name="file<%= i + 1 %>" id="file<%= i + 1 %>" class="file" style="display:none;" />
                  	 		<br />
                  	 		<script>
                  	 			document.querySelector("#delFile<%= i %>").addEventListener('click', (e) => {
                  	 				const isChecked = document.querySelector("#delFile<%= i %>").checked;
                  	 				if (isChecked) {
                  	 					document.querySelector("#file<%= i + 1 %>").style.display = '';
                  	 				} else {
                  	 					document.querySelector("#file<%= i + 1 %>").value = '';
                  	 					document.querySelector("#file<%= i + 1 %>").style.display = 'none';
                  	 					document.querySelector("#img<%= i + 1 %>").src = '';
                  	 					document.querySelector("#img<%= i + 1 %>").style.display = 'none';
                  	 				}
                  	 			});
                  	 		</script>
						<% 
							}
							for (int j = size; j < 3; j++) {
						%>
								<input type="file" name="file<%= j + 1 %>" id="file<%= j + 1 %>" /><br />
						<%
							}
						}else{ %>
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
								<img src="" alt="" id="img1" name="img1" class="img" style="display:none;" />
								<img src="" alt="" id="img2" name="img2" class="img" style="display:none;" />
								<img src="" alt="" id="img3" name="img3" class="img" style="display:none;" />
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
					</tr>
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
			console.log(img);
			
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
				console.log(file.files[0]);
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					div.style.height = "150px";
					document.querySelector("#content").style.height = "350px";
					console.log(e.target.result);
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
				console.log(file.files[0]);
				reader.readAsDataURL(file.files[0]);
				reader.onload = (e) => {
					div.style.height = "150px";
					document.querySelector("#content").style.height = "350px";
					console.log(e.target.result);
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
				e.preventDefault();
				alert("제목을 작성해주세요.");
				frm.title.select();
				return false;
			}
							   
			//내용을 작성하지 않은 경우 폼제출할 수 없음.
			const contentVal = frm.content.value.trim();
			if(!/^(.|\n)+$/.test(contentVal)){
				e.preventDefault();
				alert("내용을 작성해주세요.");
				frm.content.select();
				return false;
			}
		};
		
		<%--
		// 비동기 폼 제출
		document.questionUpdateFrm.addEventListener('submit', (e) => {
    		// 폼 제출 방지
    		e.preventDefault();
    		
    		// FormData 객체 생성
    		const frmData = new FormData(e.target);
    		
    		$.ajax({
    			url : "<%= request.getContextPath() %>/customer/questionUpdate",
    			method : 'POST',
    			data : frmData,
    			dataType : 'json',
    			contentType : false,
    			processData : false,
    			success(data){
    				console.log(data);
    				alert(data.result);
    			},
    			error : console.log
    		});
    	});
    	--%>
	</script>
</body>
</html>