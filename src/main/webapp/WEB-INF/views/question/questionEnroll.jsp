<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
	<section id="questionTotalList" class="fontStyle">
	<h1 id="enrollTitle" class="pointColor fontStyle">고객센터</h1>
	
	<form method = "get" action = "write_action.php">
        <table  style="padding-top:50px" align = center width=700 border=0 cellpadding=2 >
                <tr>
                <td height=20 align= center bgcolor=#ccc><font color=white>질문 작성</font></td>
                </tr>
                <tr>
                <br>
                <td bgcolor=white>
                <table class = "table2">
                        <tr>
                        <td>작성자</td>
                        <td><input type = text name = name size=20> </td>
                        </tr>
 
                        <tr>
                        <td>제목</td>
                        <td><input type = text name = title size=60></td>
                        </tr>
 
                        <tr>
                        <td>내용</td>
                        <td><textarea name = content cols=85 rows=15></textarea></td>
                        </tr>
 
                        <tr>
                       <td><input type = "button" id="Questionenroll" value="작성하기"></td>
               		   </tr>
               		   
               		   <tr>
                       <td><input type = "button" id="Questionenroll" value="목록"></td>
               		   </tr>
       </table>
       </table>
     </form>
</body>
</html>
