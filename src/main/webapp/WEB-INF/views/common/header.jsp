<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/common.css">
	<script src="<%= request.getContextPath() %>/js/jquery-3.6.1.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script src="https://kit.fontawesome.com/f16d134c1f.js" crossorigin="anonymous"></script>
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<title>쉼표 ,</title>
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
	// case "/comma/member/memberEnroll" :
	// 	link.href = "<%= request.getContextPath() %>/css/memberEnroll.css";
	// 	break;
		case "/comma/counseling/counselingList" : 
		link.href = "<%= request.getContextPath() %>/css/counseling.css";
		break;
		case "/comma/diary/diaryList" : 
		link.href = "<%= request.getContextPath() %>/css/diary.css";
		break;
		case "/comma/letter/writeLetter" :
		link.href = "<%= request.getContextPath() %>/css/letter.css"; 
		break;
	}; // switch end
	document.querySelector("head").append(link);
	</script>
</head>
<body>
	<% if(!request.getServletPath().equals("/index.jsp")){ %>
    <header>
		<div id="centerBox">
			<div id="logo">
				<h1 id="title" class="pointColor fontStyle">&nbsp;쉼표 ,</h1>
			</div>  
	        <div id="category" class="pointColor fontStyle">
				<div id="toCounseling" class="navBtn">
					<i class="fa-solid fa-house selected"></i>
					<i class="fa-regular fa-house disselected"></i>
				</div>
				<div id="toDiary" class="navBtn">
					<i class="fa-solid fa-book selected"></i>
					<i class="fa-regular fa-book disselected"></i>
				</div>
				<div id="toLetter" class="navBtn">
					<i class="fa-solid fa-envelope selected"></i>
					<i class="fa-regular fa-envelope disselected"></i>
				</div>
				<div id="toChat" class="navBtn">
					<i class="fa-sharp fa-solid fa-comments selected"></i>
					<i class="fa-regular fa-comments disselected"></i>
				</div>
				<div id="toQuestion" class="navBtn">
					<i class="fa-solid fa-square-question selected"></i>
					<i class="fa-regular fa-square-question disselected"></i>
				</div>
				<div id="toPost" class="navBtn">
					<i class="fa-solid fa-mailbox"></i>
				</div>
	     	</div>
        </div>
    </header>
    <% } %>
    <script>

	    // /*
	    // Date : 2023. 1. 12
	    // @장원정
	
	    // 헤더 열기 메서드
	    // */
	    // document.querySelector("#menuBox").addEventListener("click", (e)=>{
	    // 	document.querySelector("#menuBox").style.display = "none";
	    // 	document.querySelector("#closeBox").style.display = "flex";
	    // 	document.querySelector("#category").style.display = "block";
	    // 	$("#title").animate({fontSize: "50px"});
	    // 	$("header").animate({width: "400px"});
	    // 	$("#logo").animate({width: "400px", height: "400px"});
	    // 	$("#titleBox").animate({width: "250px", height: "250px"}).css("border", "3px solid #454a7b").css("borderRadius", "50%");
	    // }); // Event() end
	
	    // /*
	    // Date : 2023. 1. 12
	    // @장원정
	
	    // 헤더 닫기 메서드
	    // */
	    // document.querySelector("#closeBox").addEventListener("click", (e)=>{
	    // 	document.querySelector("#closeBox").style.display = "none";
	    // 	document.querySelector("#category").style.display = "none";
	    // 	$("header").animate({width: "150px"});
	    // 	document.querySelector("#menuBox").style.display = "flex";
	    // 	$("#title").animate({fontSize: "2em"});
	    // 	$("header").animate({width: "150px"});
	    // 	$("#logo").animate({width: "100%", height: "10%"});
	    // 	$("#titleBox").animate({width: "100%", height: "100%"}).css("border", "0").css("borderRadius", "0");
	    // }); // Event() end
	    
	    /*
	    Date 2023. 1. 15
	    @장원정
	    
	    타이틀 클릭시 홈화면 이동 메서드
	    */
	    document.querySelector("#title").addEventListener("click", (e)=>{
	    	location.href = "<%= request.getContextPath() %>/counseling/counselingList";
	    });

	    /*
	    Date 2023. 1. 17
	    @장원정
	    
	    홈 아이콘 클릭시 홈화면 이동 메서드
	    */
	    document.querySelector("#toCounseling").addEventListener("click", (e)=>{
	    	location.href = "<%= request.getContextPath() %>/counseling/counselingList";
	    });
	    
	    /*
	   	Date : 2023. 1. 15
	   	@장원정
	   	
	    편지쓰기jsp 이동 메서드
	    */
	    document.querySelector("#toLetter").addEventListener("click", (e)=>{
	    	location.href = "<%= request.getContextPath() %>/letter/writeLetter";
	    });
	    
	    /*
	   	Date : 2023. 1. 15
	   	@장원정
	   	
	    고객센터jsp 이동 메서드
	    */
	    document.querySelector("#toQuestion").addEventListener("click", (e)=>{
	    	location.href = "<%= request.getContextPath() %>/question/faq";
	    });
	    
	    /*
	      Date : 2023. 01. 15
	      @최민경
	      
	      diary.jsp 이동 메소드
	     */
	     document.querySelector("#toDiary").addEventListener('click', (e) => {
	    	location.href = "<%= request.getContextPath() %>/diary/diaryList"; 
	     });
    </script>