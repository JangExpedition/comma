<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
<%@ include file="/WEB-INF/views/common/header.jsp" %>
 --%>
<%
	LocalDateTime today = LocalDateTime.now();
	String formatToday = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	System.out.println(formatToday);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/common.css">
<script src="<%= request.getContextPath() %>/js/jquery-3.6.1.js"></script>
<title>쉼표 ,</title>
</head>
<body>
	<section class="fontStyle">
		<div id="diaryEnrollModal" class="fontStyle diaryEnroll-overlay">
			<div id="diaryTitle">일기장</div>
			<div class="diaryEnrollModal-window">
				<div id="diaryList">
					<form>
						<table>
							<tbody>
								<tr>
									<td><label for="fontChoice">폰트 선택 :&nbsp;&nbsp;</label></td>
									<td>
										<select name="fontChoice" id="fontChoice">
											<option value="폰트1" class="font1" selected >폰트1</option>
											<option value="폰트2" class="font2" >폰트2</option>
										</select>
									</td>
									<td><input type="button" id="designChoice" class="designChoice" value="디자인 선택" /></td>
								</tr>
								<tr>
									<td><label for="nowDate" class="labelDate">날짜 :&nbsp;&nbsp;</label></td>
									<td colspan="2"><input type="date" name="nowDate" id="nowDate" value=<%= formatToday %> readonly /></td>
								</tr>
								<tr>
									<td><label for="nowContent" class="labelContent">내용 :&nbsp;&nbsp;</label></td>
									<td colspan="2"><textarea name="nowContent" id="nowContent" cols="55" rows="20"></textarea></td>
								</tr>
								<tr>
									<td><label for="nowImage" class="labelImage">사진첨부 :&nbsp;&nbsp;</label></td>
									<td colspan="2"><input type="file" name="nowImage" id="nowImage" /></td>
								</tr>
								<tr>
									<td colspan="2"><input type="button" onclick="writeDiary();" value="일기 작성" /></td>
								</tr>
							</tbody>
						</table>
					</form>			
				</div>
			</div>
		</div>
		
		<div id="design">
			<form id="designChoiceFrm">
				
			</form>
		</div>
	</section>
	<script>
		const writeDiary = () => {
			location.href = "<%= request.getContextPath() %>/diary/diaryEnroll";
		};
	</script>
</body>
</html>