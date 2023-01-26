<%@page import="customer.model.dto.FAQ"%>
<%@page import="customer.model.dto.Question"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
	List<Question> questionList = (List<Question>) request.getAttribute("questionList");
	List<FAQ> faqList = (List<FAQ>) request.getAttribute("faqList");
%>

	<section id="questionTotalList" class="fontStyle">
		<div id="enrollTitle" class="pointColor fontStyle">고객센터</div>
		
		<div id="customerButton" >
			<input id="questionBtn" class="customerBtn fontStyle customerBtnClick" type="button" value="문의내역" />
			<input id="faqBtn" class="customerBtn fontStyle" type="button" value="FAQ" />
		</div>

		<div id="search-container">
			<form action="<%= request.getContextPath() %>/customer/customerFinder">
				<input type="hidden" name="searchTable" value="question" />
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
					</tr>
				</thead>
				<tbody>
			<%
				if (questionList == null || questionList.isEmpty()) {
			%>
					<tr>
						<td colspan="3">조회된 문의 내역이 없습니다..</td>
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
		<% if (loginMember != null && loginMember.getMemberRole() == MemberRole.A) { %>
			<div id="inputBtn">
				<input type="button" id="faqAddBtn" class="fontStyle" value="추가" />
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
					<div class="faqDetailTitle"><%= faq.getTitle() %></div>
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
		/*
		  질문작성 버튼 클릭 시 questionEnroll.jsp로 넘어가게 하는 이벤트리스너
		*/
		document.querySelector("#writeBtn").addEventListener('click', (e) => {
			location.href = "<%= request.getContextPath() %>/customer/questionEnroll";
		 });
		
		
		/*
		  추가 버튼 클릭 시 faqEnroll.jsp로 넘어가게 하는 이벤트리스너
		*/
		document.querySelector("#faqAddBtn").addEventListener('click', (e) => {
			location.href = "<%= request.getContextPath() %>/customer/faqEnroll";
		});
		
		
		/*
		  문의내역 클릭 시 클래스 추가 및 div 숨기거나 보이게
		*/
		questionBtn.addEventListener('click', (e) => {
			e.target.classList.add('customerBtnClick');
			faqBtn.classList.remove('customerBtnClick');
			
			questionDiv.style.display = '';
			document.querySelector('#faqDiv').style.display = 'none';
			
			document.querySelector('input[name=searchTable]').value = 'question';
		});
		
		
		/*
		  FAQ 클릭 시 클래스 추가 및 div 숨기거나 보이게
		*/
		faqBtn.addEventListener('click', (e) => {
			e.target.classList.add('customerBtnClick');
			questionBtn.classList.remove('customerBtnClick');
			
			document.querySelector('#faqDiv').style.display = '';
			questionDiv.style.display = 'none';
			
			document.querySelector('input[name=searchTable]').value = 'faq';
		});
		

        $('.faqDetailTitle').click((e) => {
            console.log($(e.target));
            $(e.target).next()
                // .slideDown(200)
                // .slideUp(300);
                .slideToggle(300)
                .siblings('.faqDetailContent').slideUp();
        });
	</script>

</body>
</html>