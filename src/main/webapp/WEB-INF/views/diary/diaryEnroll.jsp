<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	LocalDateTime today = LocalDateTime.now();
	String formatToday = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	System.out.println(formatToday);
%>
	<section class="fontStyle">
		<div id="diaryTitle">일기장</div>
		<div id="diaryList">
			<form>
				<table>
					<tbody>
						<tr>
							<td><label for="nowDate" class="labelDate">날짜 :&nbsp;&nbsp;</label></td>
							<td><input type="date" name="nowDate" id="nowDate" value=<%= formatToday %> readonly /></td>
						</tr>
						<tr>
							<td><label for="nowContent" class="labelContent">내용 :&nbsp;&nbsp;</label></td>
							<td><textarea name="nowContent" id="nowContent" cols="50" rows="10"></textarea></td>
						</tr>
					</tbody>
				</table>
			</form>			
		</div>
	</section>
</body>
</html>