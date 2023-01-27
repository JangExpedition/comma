<%@page import="customer.model.dto.FAQ"%>
<%@page import="customer.model.dto.Question"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
	String type = (String) request.getAttribute("type") == null ? "question" : (String) request.getAttribute("type");
	System.out.println("type = " + type);
	List<Question> questionList = (List<Question>) request.getAttribute("questionList");
	List<FAQ> faqList = (List<FAQ>) request.getAttribute("faqList");
%>

	<section id="questionTotalList" class="fontStyle">
		<div id="enrollTitle" class="pointColor fontStyle">고객센터</div>
		
		<div id="customerButton" >
			<input id="questionBtn" class="customerBtn fontStyle" type="button" value="문의내역" />
			<input id="faqBtn" class="customerBtn fontStyle" type="button" value="FAQ" />
		</div>

		<div id="search-container">
			<form action="<%= request.getContextPath() %>/customer/customerFinder">
				<input type="hidden" name="nickname" value="<%= loginMember.getNickname() %>" />
				<input type="hidden" name="searchType" value="<%= type %>" />
				<input type="text" id="searchContent" name="searchContent" size="30" placeholder="검색할 내용을 입력해주세요." />
				<input type="submit" id="searchBtn" class="fontStyle" value="검색" />
			</form>
		</div>
		
		<div id="questionDiv" class="tableDiv">
			<div id="inputBtn">
				<input type="button" id="writeBtn" class="fontStyle" value="질문작성" />
			</div>
			
			<table id="questionTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
						<td></td>
					</tr>
				</thead>
				<tbody>
			<%
				if (questionList == null || questionList.isEmpty()) {
			%>
					<tr>
						<td colspan="4">조회된 문의 내역이 없습니다..</td>
					</tr>
			<%
				} else {
					for (Question question : questionList) {
			%>
					<tr>
						<td><%= question.getNo() %></td>
						<td>
							<a href="<%= request.getContextPath() %>/customer/questionView?no=<%= question.getNo() %>" class="content"><%= question.getTitle() %></a>
						</td>
						<td><%= question.getRegDate() %></td>
					</tr>
			<%
					} // for end
				} // else end
			%>
				</tbody>
			</table>
		</div>


		<div id="faqDiv" class="tableDiv" style="display: none;">
		<% if (loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) { %>
			<div id="inputBtn">
				<input type="button" id="faqAddBtn" class="fontStyle" value="추가" onclick="location.href='<%= request.getContextPath() %>/customer/faqEnroll';" />
			</div>
		<% } %>
		
			<div id="faqDiv">
			
		<%
			if (faqList == null || faqList.isEmpty()) {
		%>
				<div id="faqDetail">
					조회된 FAQ가 없습니다.
				</div>
		<%
			} else {
				for (FAQ faq : faqList) {
		%>
				<div id="faqDetail">
					<div class="faqDetailTitle">
						<%= faq.getTitle() %>
					
					<% if (loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) { %>
						<div class="faqDetailBtn">
							<form action="<%= request.getContextPath() %>/customer/faqDelete" method="post">
								<input type="hidden" name="faqNo" value=<%= faq.getNo() %> />
								<input type="submit" id="faqDelBtn" class="fontStyle" value="삭제" />
							</form>
							<input type="button" id="faqUpBtn" class="fontStyle" value="수정" onclick="location.href='<%= request.getContextPath() %>/customer/faqUpdate?no=<%= faq.getNo() %>';" />
						</div>
					<% } %>
					</div>
					<div class="faqDetailContent"><%= faq.getContent() %></div>
				</div>
		<%
				} // for end
			} // else end
		%>
			</div>
		</div>

	</section>
	
	<script>
		let type = "<%= type %>";
		window.onload = (e) => {			
			if (type === 'question') {
				questionBtn.click();
			} else {
				faqBtn.click();
			}
		};
		
		
		const questionBtnClick = (e) => {
			e.target.classList.add('customerBtnClick');
			faqBtn.classList.remove('customerBtnClick');
			
			questionDiv.style.display = '';
			document.querySelector('#faqDiv').style.display = 'none';
			
			document.querySelector('[name=searchType]').value = 'question';
		};
		
		const faqBtnClick = (e) => {
			e.target.classList.add('customerBtnClick');
			questionBtn.classList.remove('customerBtnClick');
			
			document.querySelector('#faqDiv').style.display = '';
			questionDiv.style.display = 'none';
			
			document.querySelector('[name=searchType]').value = 'faq';
		};
		
		
		/*
		  질문작성 버튼 클릭 시 questionEnroll.jsp로 넘어가게 하는 이벤트리스너
		*/
		document.querySelector("#writeBtn").addEventListener('click', (e) => {
			location.href = "<%= request.getContextPath() %>/customer/questionEnroll";
		 });
		
		/*
		  문의내역 클릭 시 클래스 추가 및 div 숨기거나 보이게
		*/
		questionBtn.addEventListener('click', (e) => {
			questionBtnClick(e);
		});
		
		/*
		  FAQ 클릭 시 클래스 추가 및 div 숨기거나 보이게
		*/
		faqBtn.addEventListener('click', (e) => {				
			faqBtnClick(e);
		});
		

		$('.faqDetailTitle').click((e) => {
	        console.log($(e.target));
	        $(e.target).next()
	            .slideToggle(300)
	            .siblings('.faqDetailContent').slideUp();
	    });
	</script>

</body>
</html>