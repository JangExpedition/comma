<%@page import="common.Attachment"%>
<%@page import="common.OX"%>
<%@page import="letter.model.dto.Letter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Letter letter = (Letter) request.getAttribute("letter");
	List<Attachment> attachList = letter.getAttachments();
	List<Friends> friendsList = (List<Friends>) session.getAttribute("friendsList");
	List<Font> fontList = (List<Font>) session.getAttribute("fontList");
	List<Design> designList = (List<Design>) session.getAttribute("designList");
	partition = Partition.LETTER;
	Boolean bool = friendsList.contains(letter.getWriter());
	System.out.println(bool);
	
	
	String designImg = "";
	for (Design design : designList) {
		if (design.getNo() == letter.getDesignNo())
			designImg = design.getRenamedFilename();
	}
	
	String fontName = "";
	for (Font font : fontList) {
		if (font.getNo() == letter.getFontNo())
			fontName = font.getName();
	}
	
	int isFriend = 0;
	OX ox = null;
	for (Friends friend : friendsList) {
		if (friend.getfNickname().equals(letter.getWriter())) {
			++isFriend;
			ox = friend.getIsFriend();
		}
	}
%>

	<section>
		<div id="letterTitle" class="fontStyle" onclick="location.href='<%= request.getContextPath() %>/letter/letterList';">받은 편지함</div>
		<div id="letterAllList">
			<div id="letterListDiv" class="letterList" style="font-family:<%= fontName %>; background-image:url('<%= request.getContextPath() %>/upload/design/<%= designImg %>'); background-size: cover;">
				<div id="letterListTitle">
					<table>
						<tr>
							<td colspan="2" class="firstTd">
								<p class="letterListInfo">
						<%
							if (letter.getWriterRole() == MemberRole.U) {
								if (letter.getAnonymous() == OX.O) {
						%>
									<span id="letterListWriter" class="fontStyle">익명</span>
						<%
								} else {
						%>
									<span id="letterListWriter" class="fontStyle"><%= letter.getWriter() != null ? letter.getWriter() : "탈퇴한 회원" %></span>
						<%
								}
							} else {
						%>
									<span id="letterListWriter" class="fontStyle">관리자</span>
						<%	
							}
						%>
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
	
	<div id="writerDiv">
<%
	if (letter.getWriterRole() != MemberRole.A && letter.getWriterRole() != MemberRole.M && letter.getAnonymous() == OX.X) {
		if (isFriend == 0) {
%>
		<input id="friendRequest" class="friendRequestBtn letterBtn" type="button" value="친구신청" />
		<script>
			/*
			  친구 신청
			*/
			friendRequest.addEventListener('click', (e) => {
				const nickname = "<%= letter.getWriter() %>";
				if (confirm(`[\${nickname}]님께 친구 신청을 하시겠습니까?`)) {
					document.friendRequestFrm.submit();
				}
			});
		</script>
<%
		} else if (isFriend != 0 && ox == OX.X) {
%>
		<input id="waitFriend" class="waitFriend" type="button" value="신청 중" disabled />
<%
		}
	}
%>
		<input id="replay" class="replayBtn letterBtn" type="button" value="답장하기" data-friend-nick="<%= letter.getWriter() %>" data-anonymous="<%= letter.getAnonymous() %>" />
	</div>
	
	<form action="<%= request.getContextPath() %>/friends/friendRequest" method="post" id="friendRequestFrm" name="friendRequestFrm">
		<input type="hidden" name="no" value="<%= letter.getNo() %>" />
		<input type="hidden" name="fNick" value="<%= letter.getWriter() %>" />
		<input type="hidden" name="myNick" value="<%= loginMember.getNickname() %>" />
	</form>
	
	<script>
		/*
		  신고 버튼 클릭 시 신고
		*/
		complainImg.addEventListener('click', (e) => {
			document.querySelector('[name=complainFrm]').submit();
		});

		
		/*
		  답장
		*/
		replay.addEventListener('click', (e) => {
			const friendNick = e.target.dataset.friendNick;
			const anonymous = e.target.dataset.anonymous;
			localStorage.setItem('friendNick', friendNick);
			localStorage.setItem('anonymous', anonymous);
			location.href = "<%= request.getContextPath() %>/letter/writeLetter";
		});
		
		
		
		
		<%--
		document.friendRequestFrm.addEventListener("submit", (e)=>{
			e.preventDefault();
			
			const formData = new FormData(e.target);
			console.log(formData);
			
			$.ajax({
				url: "<%= request.getContextPath() %>/friend/friendship",
				method: "POST",
				data: formData,
				dataType: "json",
				contentType : false,
				processData : false,
				success(data){
					console.log(data.result);
					alert(data.result);
				},
				error : console.log,
			});
		});
		--%>
		
	</script>
</body>
</html>