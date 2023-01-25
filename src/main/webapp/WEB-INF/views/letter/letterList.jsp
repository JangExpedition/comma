<%@page import="common.OX"%>
<%@page import="letter.model.dto.AF"%>
<%@page import="letter.model.dto.Letter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Letter> letterList = (List<Letter>) request.getAttribute("letterList");
	System.out.println("letterList = " + letterList);
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
				if (letter.getSendWho() == AF.A) {
		%>
			<div class="letterList" data-letter-no="<%= letter.getNo() %>" onclick="letterDetail(this);">
				<div id="letterListTitle">
					<table>
						<tr>
							<td class="firstTd">
								<p class="letterListInfo">
									<span id="letterListWriter" class="fontStyle"><%= letter.getAnonymous() == OX.O ? "익명" : letter.getWriter() %></span>
									&nbsp;님으로부터
								</p>
							</td>
							<td class="secondTd">
								<p id="complain"><img src="<%= request.getContextPath() %>/images/siren.png" id="complainImg" alt="신고아이콘" /></p>
							</td>
						</tr>
					</table>
					<hr />
				</div>
				<p id="letterListContent"><%= letter.getContent() %></p>
			</div>
		<%
				} else {
		%>
			<div class="letterList" data-letter-no="<%= letter.getNo() %>" onclick="letterDetail(this);">
				<div id="letterListTitle">
					<table>
						<tr>
							<td class="firstTd">
								<p class="letterListInfo">
									<span id="letterListWriter" class="fontStyle"><%= letter.getAnonymous() == OX.O ? "익명" : letter.getWriter() %></span>
									&nbsp;님으로부터
								</p>
							</td>
							<td class="secondTd">
								<p id="complain"><img src="<%= request.getContextPath() %>/images/siren.png" id="complainImg" alt="신고아이콘" /></p>
							</td>
						</tr>
					</table>
					<hr />
				</div>
				<p id="letterListContent"><%= letter.getContent() %></p>
			</div>
		<%
				} // else end
			} // for end
		%>
	<% } // else end %>
		</div>
	</section>
	
	<section id="detailLetterSection" style="display: none;">
		<div id="detailLetter">
			<table id="detailLetterTable">
				<tr>
					<td></td>
				</tr>
			</table>
		</div>
	</section>
	
	<script>
		// 익명에게 받은 편지 클릭 시 css 변경
		letterSmallRandom.addEventListener('click', (e) => {
			console.log(e.target.classList);
			e.target.classList.remove('letterSmall');
			e.target.classList.add('letterSmallClick');
			
			letterSmallFriends.classList.remove('letterSmallClick');
			letterSmallFriends.classList.add('letterSmall');
		}); // letterSmallRandom(click) end
		
		// 친구에게 받은 편지 클릭 시 css 변경
		letterSmallFriends.addEventListener('click', (e) => {
			console.log(e.target.classList);
			e.target.classList.remove('letterSmall');
			e.target.classList.add('letterSmallClick');
			
			letterSmallRandom.classList.remove('letterSmallClick');
			letterSmallRandom.classList.add('letterSmall');
		}); // letterSmallFriends(click) end
		
		/*
		  편지 상세 내용 보기
		*/
		const letterDetail = (target) => {
			
		};
	</script>
</body>
</html>