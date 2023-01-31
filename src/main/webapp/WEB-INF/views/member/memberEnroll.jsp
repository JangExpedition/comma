<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<section>
		<div id="enrollBox">
			<h1 id="enrollTitle" class="pointColor fontStyle">회원가입</h1>
			<form action="">
				<fieldset>
					<table>
						<tbody>
							<tr>
								<td class="labelTd fontStyle"><label for="memberId">아이디</label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="inputTd fontStyle" colspan="3"><input type="text" id="memberId" name="memberId"/></td>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							</tr>
							<tr>
								<td class="labelTd fontStyle"><label for="password">비밀번호</label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="inputTd fontStyle" colspan="3"><input type="password" id="password" name="password"/></td>
							</tr>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							<tr>
								<td class="labelTd fontStyle"><label for="checkPassword">비밀번호 재확인</label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="inputTd fontStyle" colspan="3"><input type="password" id="checkPassword" name="checkPassword"/></td>
							</tr>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							<tr>
								<td class="labelTd fontStyle"><label for="nickname">닉네임</label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="inputTd fontStyle" colspan="3"><input type="text" id="nickname" name="nickname"/></td>
							</tr>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							<tr>
								<td class="labelTd fontStyle"><label for="gender">성별</label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="genderTd fontSytle" colspan="3">
									<select name="gender" id="gender">
										<option value="">성별</option>
										<option value="남자">남자</option>
										<option value="여자">여자</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							<tr>
								<td class="labelTd fontStyle"><label for="">생년월일</label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="birth fontStyle"><input type="text" id="birthYear" name="birthYear" placeholder="년(4자)"/></td>
								<td class="birth">
								<select name="birthMonth" id="birthMonth" required>
									<option value="">월</option>
									<option value=1>1</option>
									<option value=2>2</option>
									<option value=3>3</option>
									<option value=4>4</option>
									<option value=5>5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
								</td>
								<td class="birth"><input type="text" name="birthDate" id="birthDate" placeholder="일"></td>
							</tr>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							<tr>
								<td class="labelTd fontStyle"><label for="phone">휴대전화 <span>(선택)</span></label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="inputTd fontStyle" colspan="3"><input type="text" id="phone" name="phone" /></td>
							</tr>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							<tr>
								<td class="labelTd fontStyle"><label for="email">이메일</label></td><td></td><td></td>
							</tr>
							<tr>
								<td class="inputTd fontStyle" colspan="2"><input type="text" id="email" name="email" /></td>
								<td class="inputTd"><input type="button" value="인증번호 받기" class="fontStyle white" id="authenBtn"></td>
							</tr>
							<tr>
								<td class="errorTd fontStyle"></td><td></td><td></td>
							</tr>
							<tr>
								<td class="inputTd" colspan="3"><input type="button" value="회원가입" class="fontStyle white" id="enrollBtn"/></td>
							</tr>
						</tbody>
					</table>
				</fieldset>
			</form>
		</div>
	</section>
</body>
</html>