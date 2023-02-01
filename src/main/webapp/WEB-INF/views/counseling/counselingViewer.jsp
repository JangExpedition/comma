<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page import="counseling.model.dto.Counseling" %>
<%@ page import="common.Attachment" %>
<%@ page import="counseling.model.dto.CounselingComment" %>
<%@ page import="common.OX" %>
<%@ page import="counseling.model.dto.LikeCounseling" %>
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
	
	List<LikeCounseling> likeList = (List<LikeCounseling>) request.getAttribute("likeList");
	boolean canLike = true;
	for(LikeCounseling lc : likeList){
		if(lc.getMemNick().equals(loginMember.getNickname())){
			canLike = false;
		}
	}
	
	List<Friends> friendsList = (List<Friends>) session.getAttribute("friendsList");
	int isFriend = 0;
	OX ox = null;
	for (Friends friend : friendsList) {
		if (friend.getfNickname().equals(counseling.getWriter())) {
			++isFriend;
			ox = friend.getIsFriend();
		}
	}
	
	partition = Partition.COUNSELING;
%>
<section id="csViewerSection">
	<div id="csContainer">
		<div>
		<% if (loginMember.getMemberRole() == MemberRole.U) { %>
			<button id="goBack" class="buttonStyle" onclick="back();">뒤로가기</button>
		<% } else { %>
			<button id="goBack" class="buttonStyle" onclick="adminBack();">뒤로가기</button>
		<% } %>
		</div>
		<div id="titleContainer">
			<span id="csCategory"><%= counseling.getCategory() %></span>
			<h1 id="csTitle"><%= counseling.getTitle() %></h1>
			<div id="smallBox">
				<% if(counseling.getAnonymous() == OX.X) { %>
				<div id="p1" class="writerNickname">
					<%= counseling.getWriter() %>
				</div>
				<% }else{ %>
				<div id="p1">익명</div>
				<% } %>
				<% if(isFriend == 0){ %>
					<div id="friendship" class="friendship" data-writer="<%= counseling.getWriter() %>" data-login-member="<%= loginMember.getNickname() %>">
						친구신청
					</div>
				<% } else{ 
					if(ox == OX.O){ %>
						<div id="friendshiped" class="friendship" data-writer="<%= counseling.getWriter() %>" data-login-member="<%= loginMember.getNickname() %>">
							이미 친구입니다.
						</div>
					<% }else{ %>
						<div id="friendshiping" class="friendship" data-writer="<%= counseling.getWriter() %>" data-login-member="<%= loginMember.getNickname() %>">
							신청 중
						</div>
				<% 		}
					} %>
				<form action="<%= request.getContextPath() %>/friends/friendship" name="friendRequestFrm" method="POST">
					<input type="hidden" name="fNick" value="<%= counseling.getWriter() %>" />
					<input type="hidden" name="myNick" value="<%= loginMember.getNickname() %>" />
					<input type="hidden" name="no" value="<%= counseling.getNo() %>" />
				</form>
				<script>
					friendship.addEventListener('click', (e) => {
						const nickname = "<%= counseling.getWriter() %>";
						if (confirm(`[\${nickname}]님께 친구 신청을 하시겠습니까?`)) {
							document.friendRequestFrm.submit();
						}
					});
				</script>
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
				<div id="complain">
					<img src="<%= request.getContextPath() %>/images/siren.png" id="complainImg" alt="신고아이콘" />
					<form action="<%= request.getContextPath() %>/complain/complain" method="post" name="csComplainFrm">
						<input type="hidden" name="my_nickname" value="<%= loginMember.getNickname() %>" />
						<input type="hidden" name="v_nickname" value="<%= counseling.getWriter() %>" />
						<input type="hidden" name="partition" value="<%= Partition.COUNSELING %>" />
						<input type="hidden" name="content" value="<%= counseling.getContent() %>" />
						<input type="hidden" name="part_no" value="<%= counseling.getNo() %>" />
					</form>
					<script>
						/*
						  신고 버튼 클릭 시 신고
						*/
						complainImg.addEventListener('click', (e) => {
							document.querySelector('[name=csComplainFrm]').submit();
						});
					</script>
				</div>
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
		<% if(canLike){ %>
			<button id="likeBtn" data-cs-no="<%= counseling.getNo() %>"><i id="unClickLike" class="fa-regular fa-heart"></i> 공감</button>
			<form action="<%= request.getContextPath() %>/counseling/counselingLike" id="updateLikeFrm" name="updateLikeFrm" method="POST">
				<input type="hidden" name="csNo" />
			</form>
			<script>
			document.querySelector("#likeBtn").addEventListener("click", (e)=>{
				const csNo = e.target.dataset.csNo;
				const frm = document.updateLikeFrm;
				frm.csNo.value = csNo;
				frm.submit();
			});
			</script>
		<% } else{ %>
			<button id="unlikeBtn" data-cs-no="<%= counseling.getNo() %>"><i id="clickLike" class="fa-solid fa-heart"></i> 공감</button>
			<form action="<%= request.getContextPath() %>/counseling/counselingUnlike" id="updateUnlikeFrm" name="updateUnlikeFrm" method="POST">
				<input type="hidden" name="csNo" />
			</form>
			<script>
			document.querySelector("#unlikeBtn").addEventListener("click", (e)=>{
				const csNo = e.target.dataset.csNo;
				const frm = document.updateUnlikeFrm;
				frm.csNo.value = csNo;
				frm.submit();
			});
			</script>
		<% } %>
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
		        <% if(counseling.getWriter().equals(loginMember.getNickname())){ %> 
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
						<div id="commentComplain">
							<form action="<%= request.getContextPath() %>/complain/complain" method="post" name="csCommentComplainFrm">
								<input type="hidden" name="my_nickname" value="<%= loginMember.getNickname() %>" />
								<input type="hidden" name="v_nickname" value="<%= comment.getWriter() %>" />
								<input type="hidden" name="partition" value="<%= Partition.COMMENT %>" />
								<input type="hidden" name="content" value="<%= comment.getContent() %>" />
								<input type="hidden" name="part_no" value="<%= comment.getNo() %>" />
								<button type="submit" class="complainBtn">
									<img src="<%= request.getContextPath() %>/images/siren.png" id="complainCommentImg" class="complainCommentImg" alt="신고아이콘" />
								</button>
							</form>
						</div>
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
						<div id="commentComplain">
							<form action="<%= request.getContextPath() %>/complain/complain" method="post" name="csCommentComplainFrm">
								<input type="hidden" name="my_nickname" value="<%= loginMember.getNickname() %>" />
								<input type="hidden" name="v_nickname" value="<%= comment.getWriter() %>" />
								<input type="hidden" name="partition" value="<%= Partition.COMMENT %>" />
								<input type="hidden" name="content" value="<%= comment.getContent() %>" />
								<input type="hidden" name="part_no" value="<%= comment.getNo() %>" />
								<button type="submit" class="complainBtn">
									<img src="<%= request.getContextPath() %>/images/siren.png" id="complainCommentImg" class="complainCommentImg" alt="신고아이콘" />
								</button>
							</form>
						</div>
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
	<form action="<%= request.getContextPath() %>/friend/friendship" name="toFriendshipFrm" method="POST">
		<input type="hidden" name="fNick" value="<%= counseling.getWriter() %>"/>
		<input type="hidden" name="myNick" value="<%= loginMember.getNickname() %>"/>
	</form>
	<script>
	$(".writerNickname").click((e)=>{
		$(".friendship").css("display", "flex");
	});
	
	
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
	const back = () => {
		location.href = "<%= request.getContextPath() %>/counseling/counselingList";
	};
	
	const adminBack = () => {
		location.href = "<%= request.getContextPath() %>/admin/counselingList";
	};
	
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