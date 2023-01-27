<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page import="counseling.model.dto.Counseling" %>
<%@ page import="common.Attachment" %>
<%@ page import="counseling.model.dto.CounselingComment" %>
<%@ page import="common.OX" %>
<%
	Counseling counseling = (Counseling)request.getAttribute("counseling");
	List<Attachment> attachList = counseling.getAttachments();
	List<CounselingComment> comments = (List<CounselingComment>) request.getAttribute("comments");
	boolean adopt = false;
	CounselingComment adoptComment = null;
	for(CounselingComment comment : comments){
		if(comment.getChoice() == OX.O){
			adoptComment = comment;
			adopt = true;
		}
	}
%>
<section id="csViewerSection">
	<div id="csContainer">
		<div>
			<button id="goBack" class="buttonStyle">뒤로가기</button>
		</div>
		<div id="titleContainer">
			<span id="csCategory"><%= counseling.getCategory() %></span>
			<h1 id="csTitle"><%= counseling.getTitle() %></h1>
			<div id="smallBox">
				<% if(counseling.getAnonymous() == OX.X) { %>
				<div id="p1"><%= counseling.getWriter() %></div>
				<% }else{ %>
				<div id="p1">익명</div>
				<% } %>
				<div id="p2"><%= counseling.getRegDate() %></div>
				<%
					boolean canEdit = loginMember != null && 
										(loginMember.getMemberRole() == MemberRole.A ||
											loginMember.getNickname().equals(counseling.getWriter()) ||
											loginMember.getMemberRole() == MemberRole.M);
					if(canEdit){
				%>
				
				<div id="editBox">
					<input id="editBtn" type="button" value="수정하기" onclick="updateCounseling()" class="buttonStyle">
					<input type="button" value="삭제하기" onclick="deleteCounseling()" class="buttonStyle">
				</div>
				<%
					}
				%>
			</div>
		</div>
		<div id="csContent" >
			<% if(attachList == null){ %>
			<% } else{ %>
				<% for(Attachment attach : attachList){ %>
				<div id="imgDiv" name="imgDiv">
					<img src="<%= request.getContextPath() %>/upload/counseling/<%= attach.getRenamedFilename() %>" alt="" id="img" name="img" />
				</div>
				<% } %>
			<% } %>
			<%= counseling.getContent() %>
		</div>
		<div id="likeBox">
			<button id="likeBtn"><i id="clickLike" class="fa-solid fa-heart"></i><i id="unClickLike" class="fa-regular fa-heart"></i> 공감</button>
		</div>
		<div id="commentBox">
			<div class="comment-editor">
	            <form
	            action="<%=request.getContextPath()%>/counseling/csCommentEnroll" method="post" name="csCommentForm">
	                <input type="hidden" name="csNo" value="<%= counseling.getNo() %>" />
	                <input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" />
	                <input type="hidden" name="commentLevel" value="X" />
	                <input type="hidden" name="commentRef" value="0" />    
	                <textarea id="commentContent"name="commentContent"></textarea>
	                <div id="commentSubmitBox">
	                	<button type="submit" id="commentEnrollBtn">댓글달기</button>
	                </div>
	            </form>
	        </div>
	        <% if(adoptComment != null){ %>
	        <div id="adoptComment">
	        	<div id="adoptCommentData">
		       		<sub class=comment-writer><%= adoptComment.getWriter() %></sub>
		            <sub class=comment-date><%= adoptComment.getRegDate() %></sub>
		            <br />
		            <%= adoptComment.getContent() %>
		        </div>
		        <% if(!adoptComment.getWriter().equals(loginMember.getNickname())){ %> 
	            <div id="btnContainer">
	            	<button class="buttonStyle btn-adopt" data-cs-comment-no="<%= adoptComment.getCommentNo() %>" data-cs-no="<%= adoptComment.getNo() %>" data-choice="X">채택취소</button>
	            </div>
	            <% } %>
	        </div>
	        <% } %>
	        <!--table#tbl-comment-->
	        <%
	        	if(!comments.isEmpty()){
	        %>
	        <table id="tbl-comment">
	        <%
	        	for(CounselingComment comment : comments){
	        		if(comment.getCommentLevel() == OX.X){
	        %>
	            <tr class="level1">
	                <td>
	                    <sub class=comment-writer><%= comment.getWriter() %></sub>
	                    <sub class=comment-date><%= comment.getRegDate() %></sub>
	                    <br />
	                    <%= comment.getContent() %>
	                </td>
	                <td class="btnDiv">
	                	<% if(!comment.getWriter().equals(loginMember.getNickname()) && counseling.getWriter().equals(loginMember.getNickname())) { %>
	                	<% if(!adopt){ %>
	                	<button class="buttonStyle btn-adopt" data-cs-comment-no="<%= comment.getCommentNo() %>" data-cs-no="<%= comment.getNo() %>" data-choice="O">채택</button>
	                	<% 
	                			}
	                		}
	                	%>
	                    <button class="buttonStyle btn-reply" value="<%= comment.getCommentNo() %>">답글</button>
	                    <% 
	                    	if(comment.getWriter().equals(loginMember.getNickname()) || loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) {
	                    %>
	                    		<button class="buttonStyle btn-delete" data-cs-comment-no="<%= comment.getCommentNo() %>" data-cs-no="<%= comment.getNo() %>">삭제</button>
	                    <%
	                    	}
	                    %>
	                </td>
	            </tr>
	           <%
	        		} else{
	           %>
	            <tr class="level2">
	                <td>
	                    <sub class=comment-writer><%= comment.getWriter() %></sub>
	                    <sub class=comment-date><%= comment.getRegDate() %></sub>
	                <br />
	                    <%= comment.getContent() %>
	                </td>
	                <td>
	                <% 
	                if(comment.getWriter().equals(loginMember.getNickname()) || loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) {
	                    %>
	                		<button class="buttonStyle btn-delete" data-cs-comment-no="<%= comment.getCommentNo() %>" data-cs-no="<%= comment.getNo() %>">삭제</button>
	                <%
	                    }
	                %>
	                </td>
	            </tr>
	            <%
	        			} // if...else end
	        		} // for end
	            %>
	        </table>
	        <% } %>
		</div>
	</div>
	<form action="<%= request.getContextPath() %>/counseling/csCommentDelete" name="csCommentDeleteFrm" method="POST">
	   	<input type="hidden" name="no"/>
	   	<input type="hidden" name="csNo"/>
	</form>
	<form action="<%= request.getContextPath() %>/counseling/comentAdopt" name="comentAdoptFrm" method="POST">
		<input type="hidden" name="no" />
	   	<input type="hidden" name="csNo"/>
		<input type="hidden" name="choice" />
	</form>
	<script>
	document.querySelectorAll(".btn-adopt").forEach((button) => {
		button.onclick = (e) => {
			const no = e.target.dataset.csCommentNo;
			const csNo = e.target.dataset.csNo;
			const choice = e.target.dataset.choice;
			const frm = document.comentAdoptFrm;
			if(choice == "O"){
				if(confirm("댓글을 채택하시겠습니까?")){
					frm.no.value = no;
					frm.choice.value = choice;
					frm.csNo.value = csNo;
					frm.submit();
				}
			}else {
				if(confirm("댓글채택을 취소하시겠습니까?")){
					frm.no.value = no;
					frm.choice.value = choice;
					frm.csNo.value = csNo;
					frm.submit();
				}
			}	
		};
	});
	
	// 뒤로가기 메서드
	document.querySelector("#goBack").addEventListener("click", (e)=>{
		location.href = "<%= request.getContextPath() %>/counseling/counselingList";
	});
	
	// 댓글 삭제
	document.querySelectorAll(".btn-delete").forEach((button) => {
		button.onclick = (e) => {
				const no = e.target.dataset.csCommentNo;
				const csNo = e.target.dataset.csNo;
				const frm = document.csCommentDeleteFrm;
			if(confirm("정말로 삭제하시겠습니까?")){
				frm.no.value = no;
				frm.csNo.value = csNo;
				frm.submit();
			}
		}
	});
	
	// 대댓글 달기
	document.querySelectorAll(".btn-reply").forEach((button) => {
		button.onclick = (e) => {
			console.log(e.target.value);
			const tr = `
			<tr>
				<td colspan="2" style="text-align:left">
					<form id="cocomentEnrollFrm" action="<%=request.getContextPath()%>/counseling/csCommentEnroll" method="post" name="boardCommentFrm">
		                <input type="hidden" name="csNo" value="<%= counseling.getNo() %>" />
		                <input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" />
		                <input type="hidden" name="commentLevel" value="O" />
		                <input type="hidden" name="commentRef" value="\${e.target.value}" />    
		                <textarea id="cocoment" name="commentContent" cols="58" rows="1"></textarea>
		                <button type="submit" class="buttonStyle">등록</button>
		            </form>
	            </td>
	         </tr>
			`;
			
			const target = e.target.parentElement.parentElement; // tr
			console.log(target);
			target.insertAdjacentHTML("afterend", tr);
			
			button.onclick = null; // 이벤트핸들러 제거
				
		}
	});

	/* 
	이벤트버블링을 통해 부모요소에서 이벤트 핸들링
	*/
	document.body.addEventListener("submit", (e)=>{
		console.log("ahwfohwlekfjklsjfildsik");
		
		if(e.target.name === 'csCommentForm'){
			
			// 유효성검사
			const content = e.target.content;
			if(!/^(.|\n)+$/.test(content.value)){
				e.preventDefault();
				alert('내용을 작성해주세요');
				content.focus();
			}
		}
	}); 
	</script>
	<% if(canEdit) { %>
	<form action="<%= request.getContextPath() %>/counseling/counselingDelete" name="counselingDeleteFrm" method="POST">
		<input type="hidden" name="no" value="<%= counseling.getNo() %>"/>
	</form>
	<script>
		const updateCounseling = () => {
			location.href = "<%= request.getContextPath() %>/counseling/counselingUpdate?no=<%= counseling.getNo() %>";	
		};
	
		const deleteCounseling = () => {
			if(confirm("정말 게시글을 삭제하겠습니까?")){
				document.counselingDeleteFrm.submit();
			}	
		};
		
	</script>
	<% } %>
</section>
</body>
</html>