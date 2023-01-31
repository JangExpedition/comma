<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<section>
		<div id="questionEnrollContainer">
			<div id="goBackDiv">
				<button id="goBack" class="buttonStyle">뒤로가기</button>
			</div>
			
			<div id="enrollTitle" class="pointColor fontStyle" onclick="history.back();">문의내역</div>
			
			<form method="post" action="<%= request.getContextPath() %>/customer/questionEnroll" enctype="multipart/form-data">
				<table id="questionEnrollTable">
					<tr>
						<th class="fontStyle">작성자</th>
						<td><input type="text" id="writerInput" name="writer" value="<%= loginMember.getNickname() %>" /></td>
					</tr>
					<tr>
						<th class="fontStyle">사진첨부</th>
						<td>
							<input type="file" name="file1" id="file1" />
							<input type="file" name="file2" id="file2" />
							<input type="file" name="file3" id="file3" />
						</td>
					</tr>
					<tr>
						<td id="titleTd" class="inputTd fontStyle" colspan="2">
							<input type="text" id="questionTitle" name="questionTitle" placeholder="제목을 입력해 주세요." required>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="imgDiv">
								<img src="" alt="" id="img1" name="img1" class="img"/>
								<img src="" alt="" id="img2" name="img2" class="img"/>
								<img src="" alt="" id="img3" name="img3" class="img"/>
							</div>
						</td>
					</tr>
					<tr>
						<td id="contentTd" class="inputTd fontStyle" colspan="2">
							<textarea name="content" id="content" cols="" rows=""></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" id="QuestionEnroll" class="questionBtn fontStyle" value="작성하기">                   
						</td>
					</tr>
				</table>
			</form>
		</div>
	</section>
	
	<script>
		// 뒤로가기 클릭 이벤트리스너
		document.querySelector("#goBack").addEventListener("click", (e)=>{
			location.href = "<%= request.getContextPath() %>/customer";
		});
		/*
		  이미지 첨부
		*/
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
	</script>
</body>
</html>
