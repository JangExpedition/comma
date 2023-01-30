<%@page import="java.util.stream.Collectors"%>
<%@page import="common.OX"%>
<%@page import="letter.model.dto.AF"%>
<%@page import="letter.model.dto.Letter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Letter> letterList = (List<Letter>) request.getAttribute("letterList");
	List<Font> fontList = (List<Font>) session.getAttribute("fontList");
	List<Design> designList = (List<Design>) session.getAttribute("designList");
	System.out.println("letterList = " + letterList);
	int no = 0;
	String designImg = "";
	String fontName = "";
%>
	<section>
		<div id="letterTitle" class="fontStyle" onclick="location.href='<%= request.getContextPath() %>/letter/letterList';">받은 편지함📩</div>
		<div id="letterSmallTitle">
			<input type="button" id="letterSmallRandom" class="letterSmall fontStyle" value="익명에게 받은 편지" />
			<input type="button" id="letterSmallFriends" class="letterSmall fontStyle" value="친구에게 받은 편지" />
		</div>
		<div id="letterAllList">
	<% if (letterList == null) { %>
			<div class="letterList">
				받은 편지 내역이 존재하지 않습니다..
			</div>
	<% } else { %>
		<% 
			for (Letter letter : letterList) {
				System.out.println(letter.getSendWho());
				if (letter.getSendWho() == AF.A) {
					no = letter.getNo();
					
					for (Design design : designList) {
						if (design.getNo() == letter.getDesignNo())
							designImg = design.getRenamedFilename();
					}
					for (Font font : fontList) {
						if (font.getNo() == letter.getFontNo())
							fontName = font.getName();
					}
		%>
			<div id="letterListAnony" class="letterList letterListDiv" data-letter-no="<%= no %>" style="background-image:url('<%= request.getContextPath() %>/upload/design/<%= designImg %>'); background-size:cover; font-family:<%= fontName %>;">
				<div id="letterListTitle">
					<table>
						<tr>
							<td class="firstTd">
								<p class="letterListInfo">
						<%
							if (letter.getWriterRole() == MemberRole.U) {
								if (letter.getAnonymous() == OX.O) {
						%>
									<span id="letterListWriter" class="fontStyle">익명</span>
						<%
								} else {
						%>
									<span id="letterListWriter" class="fontStyle"><%= letter.getWriter() %></span>
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
						</tr>
						<tr>
							<td>
								<p id="letterListContent"><%= letter.getContent() %></p>
							</td>
						</tr>
						<tr>
							<td class="lastTd">
								<a href="<%= request.getContextPath() %>/letter/letterView?no=<%= letter.getNo() %>" class="fontStyle contentMore">더 읽어보기 &lt;&lt;</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<form action="<%= request.getContextPath() %>/complain/complain" method="post" name="complainFrm">
				<input type="hidden" name="my_nickname" value="<%= loginMember.getNickname() %>" />
				<input type="hidden" name="v_nickname" value="<%= letter.getWriter() %>" />
				<input type="hidden" name="partition" value="<%= partition %>" />
				<input type="hidden" name="content" value="<%= letter.getContent() %>" />
				<input type="hidden" name="part_no" value="<%= letter.getNo() %>" />
			</form>
		<%
				} else {
					no = letter.getNo();
					for (Design design : designList) {
						if (design.getNo() == letter.getDesignNo())
							designImg = design.getRenamedFilename();
					}
					for (Font font : fontList) {
						if (font.getNo() == letter.getFontNo())
							fontName = font.getName();
					}
		%>
			<div id="letterListFriend" class="letterList letterListDiv" data-letter-no="<%= no %>" style="font-family:<%= fontName %>; background-image:url('<%= request.getContextPath() %>/upload/design/<%= designImg %>'); background-size:cover;">
				<div id="letterListTitle">
					<table>
						<tr>
							<td class="firstTd">
								<p class="letterListInfo">
						<%
							if (letter.getWriterRole() == MemberRole.U) {
								if (letter.getAnonymous() == OX.O) {
						%>
									<span id="letterListWriter" class="fontStyle">익명</span>
						<%
								} else {
						%>
									<span id="letterListWriter" class="fontStyle"><%= letter.getWriter() %></span>
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
						</tr>
						<tr>
							<td>
								<p id="letterListContent"><%= letter.getContent() %></p>
							</td>
						</tr>
						<tr>
							<td class="lastTd">
								<a href="<%= request.getContextPath() %>/letter/letterView?no=<%= letter.getNo() %>" class="fontStyle contentMore">더 읽어보기 &lt;&lt;</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<form action="<%= request.getContextPath() %>/complain/complain" method="post" name="complainFrm">
				<input type="hidden" name="my_nickname" value="<%= loginMember.getNickname() %>" />
				<input type="hidden" name="v_nickname" value="<%= letter.getWriter() %>" />
				<input type="hidden" name="partition" value="<%= partition %>" />
				<input type="hidden" name="content" value="<%= letter.getContent() %>" />
				<input type="hidden" name="part_no" value="<%= letter.getNo() %>" />
			</form>
		<%
				} // else end
			} // for end
		%>
	<% } // else end %>
		</div>
	</section>
	
	<script>
		const anonyDiv = document.querySelectorAll('#letterListAnony');
		const friendDiv = document.querySelectorAll('#letterListFriend');
		
		// 익명에게 받은 편지 클릭 시 css 변경
		letterSmallRandom.addEventListener('click', (e) => {
			console.log(e.target.classList);
			e.target.classList.remove('letterSmall');
			e.target.classList.add('letterSmallClick');
			
			letterSmallFriends.classList.remove('letterSmallClick');
			letterSmallFriends.classList.add('letterSmall');
			
			anonyDiv.forEach((anony) => {
				anony.style.display = '';
			});
			
			friendDiv.forEach((friend) => {
				friend.style.display = 'none';
			});
		}); // letterSmallRandom(click) end
		
		// 친구에게 받은 편지 클릭 시 css 변경
		letterSmallFriends.addEventListener('click', (e) => {
			console.log(e.target.classList);
			e.target.classList.remove('letterSmall');
			e.target.classList.add('letterSmallClick');
			
			letterSmallRandom.classList.remove('letterSmallClick');
			letterSmallRandom.classList.add('letterSmall');
			
			anonyDiv.forEach((anony) => {
				anony.style.display = 'none';
			});
			
			friendDiv.forEach((friend) => {
				friend.style.display = '';
			});
		}); // letterSmallFriends(click) end
		
		/*
		  게시글 내용 일정 글자 수 이상은 ...으로 변경
		*/
		document.querySelectorAll('#letterListContent').forEach((letterContent) => {
			const allLength = letterContent.innerText.length;
			console.log('letterContent length = ' + allLength);
			
			const content = letterContent.innerText.substr(0, 11);
			console.log('content' + content);
			letterContent.innerText = content + '  .....';
		});
		
	</script>
</body>
</html>