<%@page import="customer.model.dto.QuestionComment"%>
<%@page import="common.Attachment"%>
<%@page import="customer.model.dto.Question"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Question question = (Question) request.getAttribute("question");
	List<Attachment> questionAttachList = question.getAttachments();
	QuestionComment qComment = (QuestionComment) request.getAttribute("questionComment");
%>
	<section>
		<div id="questionDiv" class="tableDiv">
			<div id="titleContainer">
				<h1 id="questionTitle"><%= question.getTitle() %></h1>
				<div id="smallBox">
					<p><%= question.getWriter() %></p>
					<p><%= question.getRegDate() %></p>
			<%
				boolean canEdit = loginMember != null && 
							(loginMember.getMemberRole() == MemberRole.A ||
								loginMember.getNickname().equals(question.getWriter()) ||
								loginMember.getMemberRole() == MemberRole.M);
				if(canEdit){
			%>
					<div id="editBox">
						<input id="editBtn" type="button" value="수정하기" onclick="updateQuestion()" class="buttonStyle">
						<input type="button" value="삭제하기" onclick="deleteQuestion()" class="buttonStyle">
					</div>
				</div>
			<%
				}
			%>
			</div>
			<div id="questionContent" >
				<%
				if(questionAttachList != null || !questionAttachList.isEmpty()){
					for(Attachment attach : questionAttachList){
				%>
					<div id="imgDiv">
						<img src="<%= request.getContextPath() %>/upload/question/<%= attach.getRenamedFilename() %>" alt="" class="img" name="img" />
					</div>
					<% } %>
				<% } %>
				<%= question.getContent() %>
			</div>
			
			<div id="commentBox">
			<% if (loginMember != null && loginMember.getMemberRole() == MemberRole.A && qComment == null) { %>
				<div class="comment-editor">
		            <form
		            action="<%=request.getContextPath()%>/customer/questionCommentEnroll" method="post" name="questionCommentForm">
		                <input type="hidden" name="questionNo" value="<%= question.getNo() %>" />
		                <input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" /> 
		                <textarea id="commentContent" name="commentContent"></textarea>
		                <div id="commentSubmitBox">
		                	<button type="submit" id="commentEnrollBtn">댓글달기</button>
		                </div>
		            </form>
		        </div>
			<% } %>
		        
	        <%
	        	if(qComment != null) {
	        %>
		        <table id="tbl-comment">
		            <%-- 댓글인 경우 tr.level1 --%>
		            <tr class="level1">
		                <td>
		                    <sub class=comment-writer><%= qComment.getWriter() %></sub>
		                    <sub class=comment-date><%= qComment.getRegDate() %></sub>
		                    <br />
	                    	<%= qComment.getContent() %>
		                </td>
	                    <% 
	                    	if(loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) {
	                    %>
		                <td class="btnDiv">
							<form action="<%= request.getContextPath() %>/customer/commentDelete" name="qCommentDeleteFrm" method="POST">
							   	<input type="hidden" name="no" value="<%= qComment.getNo() %>" />
							   	<input type="hidden" name="qNo" value="<%= question.getNo() %>"/>
							   	<input type="submit" class="btn-delete" value="삭제" />
							</form>
	                    <%  } %>
		                </td>
		            </tr>
		        </table>
	        <% } %>
			</div>
		</div>
		<form action="<%= request.getContextPath() %>/customer/commentUpdate" name="qCommentUpdateFrm" method="POST">
		   	<input type="hidden" name="no"/>
		   	<input type="hidden" name="qNo" />
		   	<input type="hidden" name="writer" />
		   	<input type="hidden" name="content" />
		</form>
		
	</section>
	
<% if(canEdit) { %>
	<form action="<%= request.getContextPath() %>/customer/questionDelete" name="questionDeleteFrm" method="POST">
		<input type="hidden" name="no" value="<%= question.getNo() %>"/>
	</form>
	<script>
		const updateQuestion = () => {
			location.href = "<%= request.getContextPath() %>/customer/questionUpdate?no=<%= question.getNo() %>";	
		};
	
		const deleteQuestion = () => {
			if(confirm("정말 게시글을 삭제하겠습니까?")){
				document.questionDeleteFrm.submit();
			}	
		};
		
	</script>
<% } %>

</body>
</html>