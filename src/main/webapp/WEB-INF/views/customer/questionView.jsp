<%@page import="customer.model.dto.QuestionComment"%>
<%@page import="common.Attachment"%>
<%@page import="customer.model.dto.Question"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Question question = (Question) request.getAttribute("question");
	List<Attachment> questionAttachList = question.getAttachments();
	List<QuestionComment> qComments = (List<QuestionComment>) request.getAttribute("questionComments");
%>
	<section>
		<div id="questionDiv" class="tableDiv">
			<div id="titleContainer">
				<h1 id="questionTitle"><%= question.getTitle() %></h1>
				<div id="smallBox">
					<p><%= question.getWriter() %></p>
					<p><%= question.getRegDate() %></p>
				</div>
			</div>
			<div id="questionContent" >
				<% if(questionAttachList == null){ %>
				<% } else{ %>
					<% for(Attachment attach : questionAttachList){ %>
					<div id="imgDiv">
						<img src="<%= request.getContextPath() %>/upload/question/<%= attach.getRenamedFilename() %>" alt="" class="img" name="img" />
					</div>
					<% } %>
				<% } %>
				<%= question.getContent() %>
			</div>
			
			<div id="commentBox">
			<% if (loginMember != null && loginMember.getMemberRole() == MemberRole.A) { %>
				<div class="comment-editor">
		            <form
		            action="<%=request.getContextPath()%>/customer/questionCommentEnroll" method="post" name="questionCommentForm">
		                <input type="hidden" name="questionNo" value="<%= question.getNo() %>" />
		                <input type="hidden" name="writer" value="<%= loginMember.getNickname() %>" /> 
		                <textarea id="commentContent"name="commentContent"></textarea>
		                <div id="commentSubmitBox">
		                	<button type="submit" id="commentEnrollBtn">댓글달기</button>
		                </div>
		            </form>
		        </div>
			<% } %>
		        
	        <%
	        	if(!qComments.isEmpty()) {
	        %>
		        <table id="tbl-comment">
	        <%
	        	for(QuestionComment comment : qComments){
	        %>
		            <%-- 댓글인 경우 tr.level1 --%>
		            <tr class="level1">
		                <td>
		                    <sub class=comment-writer><%= comment.getWriter() %></sub>
		                    <sub class=comment-date><%= comment.getRegDate() %></sub>
		                    <br />
		                    <%-- 댓글내용 --%>
		                    <%= comment.getContent() %>
		                </td>
		                <td class="btnDiv">
		                    <% 
		                    	if(comment.getWriter().equals(loginMember.getNickname()) || loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) {
		                    %>
		                    		<button class="btn-delete" data-qComment-no="<%= comment.getQNo() %>" data-q-No="<%= comment.getNo() %>">삭제</button>
		                    <%
		                    	}
		                    %>
		                </td>
		            </tr>
	            <%
	        		} // for end
	            %>
		        </table>
	        <% } %>
			</div>
		</div>
		
	</section>

</body>
</html>