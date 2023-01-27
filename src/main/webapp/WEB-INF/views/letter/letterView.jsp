<%@page import="common.Attachment"%>
<%@page import="common.OX"%>
<%@page import="letter.model.dto.Letter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Letter letter = (Letter) request.getAttribute("letter");
	System.out.println("letter = " + letter);
	List<Attachment> attachList = letter.getAttachments();
	partition = Partition.LETTER;
%>
	<section>
		<div id="letterTitle" class="fontStyle" onclick="history.back();">받은 편지함</div>
		<div id="letterAllList">
			<div id="letterListDiv" class="letterList">
				<div id="letterListTitle">
					<table>
						<tr>
							<td colspan="2" class="firstTd">
								<p class="letterListInfo">
									<span id="letterListWriter" class="fontStyle"><%= letter.getAnonymous() == OX.O ? "익명" : letter.getWriter() %></span>
									&nbsp;님으로부터
								</p>
							</td>
							<td class="secondTd">
								<p id="complain"><img src="<%= request.getContextPath() %>/images/siren.png" id="complainImg" alt="신고아이콘" /></p>
							</td>
						</tr>
						<tr>
							<td colspan="3">
						<%
							if (attachList != null) {
								for (Attachment attach : attachList) {
						%>
								<img src="<%= request.getContextPath() %>/upload/letter/<%= attach.getRenamedFilename() %>" alt="" class="letterDetailImg" />
						<%
								}
							}
						%>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<p id="letterListContent"><%= letter.getContent() %></p>
							</td>
						</tr>
					</table>
					<form action="<%= request.getContextPath() %>/complain/complain" method="post" name="complainFrm">
						<input type="hidden" name="my_nickname" value="<%= loginMember.getNickname() %>" />
						<input type="hidden" name="v_nickname" value="<%= letter.getWriter() %>" />
						<input type="hidden" name="partition" value="<%= partition %>" />
						<input type="hidden" name="content" value="<%= letter.getContent() %>" />
						<input type="hidden" name="part_no" value="<%= letter.getNo() %>" />
					</form>
				</div>
			</div>
		</div>
	</section>
	
	<script>
		complainImg.addEventListener('click', (e) => {
			document.querySelector('[name=complainFrm]').submit();
		});
	</script>
</body>
</html>