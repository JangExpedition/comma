<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div id="chatList" class="fontStyle"><h1> 채팅방 목록 </h1></div>

<form name="searchForm" action="" method="get" id="search">
       <p>
       
           <select name="searchType">
               <option value="ALL">전체검색</option>
               <option value="chatTitle">채팅방 제목</option>
               <option value="tag">해시태그</option>
               <option value="category">카테고리</option>
           </select>

           <input type="text" name="searchText" value=""  id="search_window"/>
           <input type="submit" id ="search_btn" class="fontStyle" value="검색" />
       </p>
       </form>
       

    <h1 class="title" id="chatListTitle"></h1>
    <section class="article-list table-common con" >
        <table border="1" class="fontStyle" >
            <thead>
                <tr>
                    <th>채팅방 제목 </th>
                    <th>개설일</th>
                    <th>카테고리</th>
                    <th>해시태그</th>
                    <th>채팅 참여자수</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>자바 질문방</td>
                    <td>2023.01.23</td>
                    <td>진로</td>
                    <td>#코딩 #java #KH #동현썜</td>
                    <td>120명</td>
                </tr>
                <tr>
                    <td>2030 인생상담</td>
                    <td>2022.03.04</td>
                    <td>일상</td>
                    <td>#20대이상만 #힐링 #인간관계</td>
                    <td>25명</td>

                </tr>
                <tr>
                    <td>카메라를 좋아하는 사람들</td>
                    <td>2023.01.06</td>
                    <td>전체</td>
                    <td>#취미 #정보공유 #출사</td>
                    <td>16명</td>
                </tr>
                <tr>
                    <td>일상속의 고민</td>
                    <td>2023.01.04</td>
                    <td>#일상</td>
                    <td>#비밀 #고민공유 #솔로몬</td>
                    <td>200명</td>

                </tr>
                <tr>
                    <td>맛집 추천 해주는방</td>
                    <td>2022.11.14</td>
                    <td>일상</td>
                    <td>#지역맛집 #존맛 #오늘뭐먹지?</td>
                    <td>87명</td>
                </tr>
            </tbody>
        </table>
    </section>



       <!-- 버튼 영역 -->
       <p>
           <input type="button" value="채팅방 생성하기" id="create_btn" class="fontStyle"
           onclick="location.href='<%=request.getContextPath()%>/chat/chat'" />
           
           <input type="button" value="채팅방 입장하기" id="enter_btn" class="fontStyle"
           onclick="location.href='<%=request.getContextPath()%>/chat/chatView'"/>
       </p>
       <!-- //버튼 영역 -->

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
			    			<div class="th">채팅방 이름</div>
			    			<div class="th">방장</div>
			    			<div class="th">참여인원</div>
			    			<div class="th">최대인원</div>
			    		</div>
			    		<%-- <% if(chatList.isEmpty()) {%>
			    			<div class="tr">
			    				<div class="td">현재 개설된 채팅방이 없습니다.</div>
			    			</div>
			    		<% 
			    		} else{ 
			    		}
			    		%> --%>
</div>
</div>
</div>
</section>
</body>
</html>