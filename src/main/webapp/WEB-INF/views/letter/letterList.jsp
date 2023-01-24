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
		<div id="anonyLetterList" class="letterList">
			익명에게 받은 편지 내역이 존재합니다.
		</div>
	<%
			} else {
	%>
		<div id="friendLetterList" class="letterList">
			친구에게 받은 편지 내역이 존재합니다.
		</div>
	<%
			}
		}
	%>
<% } %>
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
	</script>
</body>
</html>