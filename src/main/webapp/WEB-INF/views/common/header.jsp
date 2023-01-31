<%@page import="style.model.dto.Design"%>
<%@page import="style.model.dto.Font"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="complain.model.dto.Partition"%>
<%@page import="friends.model.dto.Friends"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.model.dto.Member" %>
<%@page import="java.sql.Connection" %>
<%@page import="common.JdbcTemplate" %>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	String msg = (String) session.getAttribute("msg");
	if(msg != null) session.removeAttribute("msg");
	//List<Friends> friendsList = (List<Friends>) session.getAttribute("friendsList");
	//List<Font> fontList = (List<Font>) session.getAttribute("fontList");
	//List<Design> designList = (List<Design>) session.getAttribute("designList");
	Partition partition = null;
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/common.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Dongle:wght@300;400&family=East+Sea+Dokdo&family=Gaegu:wght@300;400&family=Gamja+Flower&family=Hi+Melody&family=IBM+Plex+Sans+KR:wght@200;300;400&family=Jua&family=Moon+Dance&family=Nanum+Brush+Script&family=Nanum+Gothic&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Rubik+Bubbles&family=Sunflower:wght@300;500&family=Yeon+Sung&display=swap" rel="stylesheet">
	<script src="<%= request.getContextPath() %>/js/jquery-3.6.1.js"></script>
<% if (loginMember != null) { %>
	<script src="<%= request.getContextPath() %>/js/ws.js"></script>
<% } %>
	<script>
	<% if(msg != null) { %>
		alert("<%= msg %>");
	<% } %>
	</script>
	<title> 쉼표 ,</title>
	<script>
	/*
	Date : 2023. 1. 13
	@장원정
	
	페이지 별 CSS 파일 구분 메서드
	*/
	
	const link = document.createElement("link");
	link.rel = "stylesheet";
	
	switch(location.pathname){
	case "/comma/" : 
		link.href = "<%= request.getContextPath() %>/css/index.css";
		break;
	case "/comma/member/memberEnroll" :
		link.href = "<%= request.getContextPath() %>/css/memberEnroll.css";
		break;
	case "/comma/letter/writeLetter" :
	case "/comma/letter/letterList" :
	case "/comma/letter/letterView" :
		link.href = "<%= request.getContextPath() %>/css/letter.css"; 
		break;
	case "/comma/diary/diaryList" :
		link.href = "<%= request.getContextPath() %>/css/diary.css";
		break;
	case "/comma/diary/writeDiary" :
		link.href = "<%= request.getContextPath() %>/css/writeDiary.css";
		break;
	case "/comma/mypage/mypage" :
		link.href = "<%= request.getContextPath() %>/css/mypage.css";
		break;
	case "/comma/friends/friendsList" :
	case "/comma/friends/friendsFinder" :
		link.href = "<%= request.getContextPath() %>/css/friends.css";
		break;
	case "/comma/counseling/counselingList" :
		link.href = "<%= request.getContextPath() %>/css/counseling.css";
		break;
	case "/comma/counseling/counselingEnroll" :
		link.href = "<%= request.getContextPath() %>/css/counselingEnroll.css";
		break;
	case "/comma/customer" :
	case "/comma/customer/customerFinder" :
		link.href = "<%= request.getContextPath() %>/css/customer.css";
		break;
	case "/comma/customer/questionEnroll" :
		link.href = "<%= request.getContextPath() %>/css/questionEnroll.css";
		break;
	case "/comma/customer/questionView" :
		link.href = "<%= request.getContextPath() %>/css/questionView.css";
		break;
	case "/comma/customer/questionUpdate" :
		link.href = "<%= request.getContextPath() %>/css/questionUpdate.css";
		break;
	case "/comma/customer/faqEnroll" :
	case "/comma/customer/faqUpdate" :
		link.href = "<%= request.getContextPath() %>/css/faqEnroll.css";
		break;
	case "/comma/chat/chat" :
		link.href = "<%= request.getContextPath() %>/css/chat.css";
		break;
	case "/comma/chat/chatView" :
		link.href = "<%= request.getContextPath() %>/css/chatView.css";
		break;
	case "/comma/chat/chatList" :
		link.href = "<%= request.getContextPath() %>/css/chatList.css";
		break;
	case "/comma/admin/adminMemberList" :
	case "/comma/admin/adminMemberFinder" :
	case "/comma/complain/complain" :
	case "/comma/complain/complainFinder" :
	case "/comma/admin/adminChatList" :
	case "/comma/admin/adminChatLog" :
	case "/comma/admin/adminChatFinder" :
	case "/comma/admin/adminChatLogFinder" :
	case "/comma/admin/counselingList" :
	case "/comma/admin/counselingFinder" :
		link.href = "<%= request.getContextPath() %>/css/admin.css";
		break;
	case "/comma/counseling/CSView" :
		link.href = "<%= request.getContextPath() %>/css/counselingViewer.css";
		break;
	case "/comma/counseling/counselingUpdate" :
		link.href = "<%= request.getContextPath() %>/css/counselingUpdate.css";
		break;
	case "/comma/admin/adminStyleList" :
	case "/comma/admin/adminFontList" :
	case "/comma/admin/adminDesignList" :
	case "/comma/admin/findStyle" :
		link.href = "<%= request.getContextPath() %>/css/adminStyle.css";
		break;
		
	}; // switch end
	document.querySelector("head").append(link);
</script>
</head>
<body>
	<% if(loginMember != null){ %>
    <header>
        <div id="logo">
        	<div id="titleBox">
            	<h1 id="title" class="pointColor fontStyle">&nbsp;쉼표 ,</h1>
            </div>
        </div>  
        <div id="centerBox">
	        <div id="category" class="pointColor fontStyle">
	        	<div id="notification"></div>
	        <% if (loginMember.getMemberRole() == MemberRole.U) { %>
				<div id="toFriends" class="navBtn">친구</div>
				<script>
				 /*
			      Date : 2023. 1. 25
			      @최민경
			    
			      friendsList.jsp 이동 메서드
			    */
				document.querySelector("#toFriends").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/friends/friendsList";	
				});
			    
				</script>
			<% } else { %>
				<div id="toAdminMemberList" class="navBtn">회원</div>
				<script>
				/*
			      Date : 2023. 1. 25
			      @최민경
			    
			      adminMemberList.jsp 이동 메서드
			    */
				document.querySelector("#toAdminMemberList").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/admin/adminMemberList";	
				});
				</script>
			<% } %>
			
			<% if (loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) { %>
				<%--
				<div id="toStyleList" class="navBtn">폰트 및 디자인</div>
				<script>
				/*
			      Date : 2023. 1. 27
			      @한혜진
			    
			      adminStyleList.jsp 이동 메서드
			    */
				document.querySelector("#toStyleList").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/admin/adminStyleList";	
				});
				
				</script>
				 --%>
				 
				<div id="toFontList" class="navBtn">폰트</div>
				<script>
				/*
			      Date : 2023. 1. 27
			      @한혜진
			    
			      adminFontList.jsp 이동 메서드
			    */
				document.querySelector("#toFontList").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/admin/adminFontList";	
				});
				
				</script>
				
				<div id="toDesignList" class="navBtn">디자인</div>
				<script>
				/*
			      Date : 2023. 1. 27
			      @한혜진
			    
			      adminDesignList.jsp 이동 메서드
			    */
				document.querySelector("#toDesignList").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/admin/adminDesignList";	
				});
				
				</script>
				
				<div id="toComplainList" class="navBtn">신고</div>
				<script>
				/*
			      Date : 2023. 1. 27
			      @최민경
			    
			      adminComplainList.jsp 이동 메서드
			    */
				document.querySelector("#toComplainList").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/complain/complain";	
				});
				</script>
			<% } %>
			
			<% if (loginMember.getMemberRole() == MemberRole.U) { %>
				<div id="toDiary" class="navBtn">일기장</div>
				<script>
			    /*
			      Date : 2023. 01. 15
			      @최민경
			      
			      diary.jsp 이동 메소드
			     */
			     document.querySelector("#toDiary").addEventListener('click', (e) => {
			    	location.href = "<%= request.getContextPath() %>/diary/diaryList"; 
			     });
				</script>
			<% } %>
			
				<div id="toPost" class="navBtn">우편함</div>
				<div id="toLetter" class="navBtn">편지쓰기</div>
			<% if (loginMember.getMemberRole() == MemberRole.A || loginMember.getMemberRole() == MemberRole.M) { %>
				<div id="toAdminChatList" class="navBtn">익명채팅</div><script>
				/*
			    Date : 2023. 1. 23
			    @한혜진
			    
			    익명채팅방 메서드
			    */
			    
				document.querySelector("#toAdminChatList").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/admin/adminChatList";	
				});
				</script>
			<% } else { %>
				<div id="toChat" class="navBtn">익명채팅방</div>
				<script>
				/*
			    Date : 2023. 1. 23
			    @한혜진
			    
			    익명채팅방 메서드
			    */
			    
				document.querySelector("#toChat").addEventListener("click", (e)=>{
					location.href = "<%= request.getContextPath() %>/chat/chatList";	
				});
				</script>
			<% } %>
			
			<% if (loginMember.getMemberRole() == MemberRole.U) { %>
				<div id="toCounseling" class="navBtn">고민상담소</div>
				<script>
				    /*
				    Date : 2023. 01. 19
				    @한혜진
				    
				    counseling.jsp 이동 메소드
				    */
				    document.querySelector("#toCounseling").addEventListener('click', (e) => {
				    	location.href = "<%= request.getContextPath() %>/counseling/counselingList"; 
				     });
				</script>
			<% } else { %>
				<div id="toAdminCounseling" class="navBtn">고민상담소</div>
				<script>
				    /*
				    Date : 2023. 01. 19
				    @한혜진
				    
				    counseling.jsp 이동 메소드
				    */
				    document.querySelector("#toAdminCounseling").addEventListener('click', (e) => {
				    	location.href = "<%= request.getContextPath() %>/admin/counselingList"; 
				     });
				</script>
			<% } %>
				<div id="toMypage" class="navBtn">마이페이지</div>
				<div id="toQuestion" class="navBtn">고객센터</div>
				<div id="logoutBtn" class="navBtn">로그아웃</div>
	     	</div>
        </div>
        <div id="menuBox">
        	<div class="menuBar"></div>
        	<div class="menuBar"></div>
        	<div class="menuBar"></div>
        	<div class="menuBar"></div>
        </div>
        <div id="closeBox" class="pointColor fontStyle">X</div>
    </header>
    <script>
	    /*
	    Date : 2023. 1. 12
	    @장원정
	
	    헤더 열기 메서드
	    */
	    document.querySelector("#menuBox").addEventListener("click", (e)=>{
	    	document.querySelector("#menuBox").style.display = "none";
	    	document.querySelector("#closeBox").style.display = "flex";
	    	document.querySelector("#category").style.display = "block";
	    	$("#title").animate({fontSize: "50px"});
	    	$("header").animate({width: "400px"});
	    	$("#logo").animate({width: "400px", height: "400px"});
	    	$("#titleBox").animate({width: "250px", height: "250px"}).css("border", "3px solid #454a7b").css("borderRadius", "50%");
	    }); // Event() end
	
	    /*
	    Date : 2023. 1. 12
	    @장원정
	
	    헤더 닫기 메서드
	    */
	    document.querySelector("#closeBox").addEventListener("click", (e)=>{
	    	document.querySelector("#closeBox").style.display = "none";
	    	document.querySelector("#category").style.display = "none";
	    	$("header").animate({width: "150px"});
	    	document.querySelector("#menuBox").style.display = "flex";
	    	$("#title").animate({fontSize: "2em"});
	    	$("header").animate({width: "150px"});
	    	$("#logo").animate({width: "100%", height: "10%"});
	    	$("#titleBox").animate({width: "100%", height: "100%"}).css("border", "0").css("borderRadius", "0");
	    }); // Event() end
	    
	    /*
	    Date 2023. 1. 15
	    @장원정
	    
	    타이틀 클릭시 홈화면 이동 메서드
	    */
	    document.querySelector("#title").addEventListener("click", (e)=>{
	    	location.href = "<%= request.getContextPath() %>/";
	    })
	    
	    /*
	   	Date : 2023. 1. 15
	   	@장원정
	   	
	    편지쓰기jsp 이동 메서드
	    */
	    document.querySelector("#toLetter").addEventListener("click", (e)=>{
	    	location.href = "<%= request.getContextPath() %>/letter/writeLetter";
	    });
	    
	    /*
	    Date : 2023. 01. 18
	    @한혜진
	    
	    myPage.jsp 이동 메소드
	    */
	    document.querySelector("#toMypage").addEventListener('click', (e) => {
	    	location.href = "<%= request.getContextPath() %>/mypage/mypage"; 
	     });
	    
	    /*
	    Date : 2023. 01. 18
	    @한혜진
	    
	    question.jsp 이동 메소드
	    */
	    document.querySelector("#toQuestion").addEventListener('click', (e) => {
	    	location.href = "<%= request.getContextPath() %>/customer"; 
	     });
	    
	    /*
	      Date: 2023. 01. 20
	      @최민경
	      
	      letterList.jsp 이동 메소드
	    */
	    document.querySelector("#toPost").addEventListener('click', (e) => {
	    	location.href = "<%= request.getContextPath() %>/letter/letterList";
	    });
	    
	    
		/*
		Date : 2023. 1. 21
		@장원정
		로그아웃 메서드
		*/
		document.querySelector("#logoutBtn").addEventListener("click", (e)=>{
			location.href = "<%= request.getContextPath() %>/member/logout";	
		});
	    
	    </script>
	    <% } %>
