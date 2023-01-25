<%@page import="common.OX"%>
<%@page import="letter.model.dto.AF"%>
<%@page import="letter.model.dto.Letter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Letter> letterList = (List<Letter>) request.getAttribute("letterList");
	System.out.println("letterList = " + letterList);
	int no = 0;
%>
	<section>
		<div id="letterTitle" class="fontStyle">받은 편지함</div>
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
				no = letter.getNo();
				if (letter.getSendWho() == AF.A) {
		%>
			<div id="letterListAnony" class="letterList letterListDiv" data-letter-no="<%= letter.getNo() %>">
				<div id="letterListTitle">
					<table>
						<tr>
							<td class="firstTd">
								<p class="letterListInfo">
									<span id="letterListWriter" class="fontStyle"><%= letter.getAnonymous() == OX.O ? "익명" : letter.getWriter() %></span>
									&nbsp;님으로부터
								</p>
							</td>
						</tr>
						<tr>
							<td>
								<p id="letterListContent"><%= letter.getContent() %></p>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<form action="<%= request.getContextPath() %>/letter/letterView" name="letterViewFrm">
				<input type="hidden" name="no" value="<%= letter.getNo() %>" />
			</form>
			<form action="<%= request.getContextPath() %>/complain/complain" method="post" name="complainFrm">
				<input type="hidden" name="my_nickname" value="<%= loginMember.getNickname() %>" />
				<input type="hidden" name="v_nickname" value="<%= letter.getWriter() %>" />
				<input type="hidden" name="partition" value="<%= partition %>" />
				<input type="hidden" name="content" value="<%= letter.getContent() %>" />
				<input type="hidden" name="part_no" value="<%= letter.getNo() %>" />
			</form>
		<%
				} else {
		%>
			<div id="letterListFriend" class="letterList letterListDiv" data-letter-no="<%= letter.getNo() %>">
				<div id="letterListTitle">
					<table>
						<tr>
							<td class="firstTd">
								<p class="letterListInfo">
									<span id="letterListWriter" class="fontStyle"><%= letter.getAnonymous() == OX.O ? "익명" : letter.getWriter() %></span>
									&nbsp;님으로부터
								</p>
							</td>
						</tr>
						<tr>
							<td>
								<p id="letterListContent"><%= letter.getContent() %></p>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<form action="<%= request.getContextPath() %>/letter/letterView" name="letterViewFrm">
				<input type="hidden" name="no" value="<%= letter.getNo() %>" />
			</form>
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
		  div 클릭 시 상세 편지 내용 페이지로 이동
		*/
		document.querySelectorAll('.letterListDiv').forEach((letterDiv) => {
			// letterDiv.style.display = 'none';
			
			letterDiv.addEventListener('click', (e) => {
				document.querySelector('[name=letterViewFrm]').submit();
			});
		});
		
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