<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="counseling.model.dto.Counseling" %>
<%@ page import="common.Attachment" %>
<%
	List<Counseling> counselingList = (List<Counseling>)request.getAttribute("counselingList");
	System.out.println(counselingList);
	List<Attachment> attachList = (List<Attachment>)request.getAttribute("attachList");
	int counselingNo = 0;
%>
	<section id="counselingSection">
		<div id="counselingContainer">
			<div id="counselingTitle" class="fontStyle pointColor"><h1>고민 상담소</h1></div>
			<div id = "counseilingCategory">
				<select name = "category">
					<option value="" disabled selected>카테고리를 선택하세요.</option>
					<option value ="all">전체</option>
					<option value ="study">진로</option>
					<option value ="love">연애</option>
					<option value ="family">가족</option>
					<option value ="childcare">육아</option>
					<option value ="career">직장</option>
					<option value ="daily">일상</option>
					<option value ="friends">친구</option>
				</select>
			   	<input type = "button" id="CounselingEnroll" value="고민 게시하기">
			</div>
			<div id="wrap">
		    	<div class="table fontStyle">
			    		<div id="thead" class="tr pointColor">
			    			<div class="th">글번호</div>
			    			<div class="th">글제목</div>
			    			<div class="th">작성자</div>
			    			<div class="th">작성날짜</div>
			    			<div class="th">조회수</div>
			    		</div>
			    		<% if(counselingList.isEmpty()) {%>
			    			<div class="tr">
			    				<div class="td">등록된 게시물이 없습니다.</div>
			    			</div>
			    		<% 
			    		} else{ 
			    		for(Counseling counseling : counselingList){
			    			counselingNo = counseling.getNo();
			    		%>
							<div class="tr" data-counseling-no="<%= counseling.getNo() %>">
								<div class="td">
								<img src=<% for(Attachment attach : attachList){
												if(attach.getAttachNo() == counseling.getNo()){ %>
											"<%= request.getContextPath() %>/upload/counseling/<%= attach.getRenamedFilename() %>"
									<% }else{ %>
										"<%= request.getContextPath() %>/images/default.png"
									<% 	} 
												}%>
									 alt="" />
									</div>
								<div class="td"><%= counseling.getTitle() %></div>
								<% if("O" == counseling.getAnonymous().toString()) { %>
								<div class="td">익명</div>
								<% }else{ %>
								<div class="td"><%= counseling.getWriter() %></div>
								<% } %>
								<div class="td"><%= counseling.getRegDate() %></div>
								<div class="td"><%= counseling.getViews() %></div>
							</div>
						<% } 
						} %>
				</div>
		    </div>
		    <div id='pagebar' class="pointColor">
				<%= request.getAttribute("pagebar") %>
			</div>
	    </div>
    </section>
    <script>
    /*
    Date : 2023. 1. 20
    @한혜진
   	고민게시글 작성버튼 메서드
    */
    document.querySelector("#CounselingEnroll").addEventListener('click', (e) => {
    	location.href = "<%= request.getContextPath() %>/counseling/counselingEnroll"
     });
    /*
    Date : 2023. 1. 25
    @장원정
    게시글 조회 메서드
    */
    $(".tr").click((e)=>{
    	location.href = "<%= request.getContextPath() %>/counseling/CSView?no=" + $(event.target).parent('.tr').data('counselingNo');
    });
    
    </script>
</body>
</html>
	