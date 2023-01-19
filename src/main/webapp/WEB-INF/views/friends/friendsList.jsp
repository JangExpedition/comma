<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<section class="fontStyle">
		<div class="title">친구</div>
		
		<div id="search-container">
			<form action="#">
				<input type="hidden" name="memberNick" value="" />
				<input type="text" id="searchNick" name="searchNick" size="30" placeholder="검색할 닉네임을 입력해주세요." />
				<input type="button" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		<div id="friends-list">
			<table class="friends-list-table">
				<tbody>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="friendsImage" />
						</td>
						<td>test1</td>
						<td>
							<input id="friends-send-letter" class="friendsBtn fontStyle" type="button" value="편지작성" />
						</td>
						<td>
							<input class="friendsBtn fontStyle" type="button" value="친구삭제" />
						</td>
					</tr>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="friendsImage" />
						</td>
						<td>test2</td>
						<td>
							<input class="friendsBtn fontStyle" type="button" value="편지작성" />
						</td>
						<td>
							<input class="friendsBtn fontStyle" type="button" value="친구삭제" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
	
	<script>
		document.querySelector('#friends-send-letter').addEventListener('click', () => {
			location.href = '<%= request.getContextPath() %>/letter/writeLetter';
		});
	</script>
</body>
</html>