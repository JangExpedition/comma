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

	<section id="diaryTotalList" class="fontStyle">
		<div id="diaryTitle">일기장</div>
		<div id="inputBtn"><input type="button" id="writeBtn" class="fontStyle" value="일기 작성하기" /></div>
		
		<article id="diaryList">
			<div id="diaryListTitle">
				<p class="title">2023년</p>
			</div>
			<div id="diaryListContent">
				<div id="diary">
					<div id="imgBox">
						<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="writeImg" />
					</div>
					<p class="writeDate">2023. 01. 15</p>
					<p class="writeContent">선거와 국민투표의 공정한 관리 및 정당에 관한 사무를 처리하기 위하여 선거관리위원회를 둔다. 국가원로자문회의의 조직·직무범위 기타 필요한 사항은 법률로 정한다. 각급 선거관리위원회는 선거인명부의 작성등 선거사무와 국민투표사무에 관하여 관계 행정기관에 필요한 지시를 할 수 있다. 국가원로자문회의의 의장은 직전대통령이 된다. 다만, 직전대통령이 없을 때에는 대통령이 지명한다.</p>
				</div>
				<div id="diary">
					<div id="imgBox">
						<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="writeImg" />
					</div>
					<p class="writeDate">2023. 01. 05</p>
					<p class="writeContent">국회는 국정을 감사하거나 특정한 국정사안에 대하여 조사할 수 있으며, 이에 필요한 서류의 제출 또는 증인의 출석과 증언이나 의견의 진술을 요구할 수 있다. 탄핵결정은 공직으로부터 파면함에 그친다. 그러나, 이에 의하여 민사상이나 형사상의 책임이 면제되지는 아니한다. 헌법개정안은 국회가 의결한 후 30일 이내에 국민투표에 붙여 국회의원선거권자 과반수의 투표와 투표자 과반수의 찬성을 얻어야 한다.</p>
				</div>
			</div>
		</article>
			
		<article id="diaryList">
			<div id="diaryListTitle">
				<p class="title">2022년</p>
			</div>
			<div id="diaryListContent">
				<div id="diary">
					<div id="imgBox">
						<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="writeImg" />
					</div>
					<p class="writeDate">2022. 06. 22</p>
					<p class="writeContent">농업생산성의 제고와 농지의 합리적인 이용을 위하거나 불가피한 사정으로 발생하는 농지의 임대차와 위탁경영은 법률이 정하는 바에 의하여 인정된다. 대통령은 헌법과 법률이 정하는 바에 의하여 공무원을 임면한다. 모든 국민은 근로의 권리를 가진다. 국가는 사회적·경제적 방법으로 근로자의 고용의 증진과 적정임금의 보장에 노력하여야 하며, 법률이 정하는 바에 의하여 최저임금제를 시행하여야 한다.</p>
				</div>
				<div id="diary">
					<div id="imgBox">
						<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="writeImg" />
					</div>
					<p class="writeDate">2022. 11. 09</p>
					<p class="writeContent">선거와 국민투표의 공정한 관리 및 정당에 관한 사무를 처리하기 위하여 선거관리위원회를 둔다. 국가원로자문회의의 조직·직무범위 기타 필요한 사항은 법률로 정한다. 각급 선거관리위원회는 선거인명부의 작성등 선거사무와 국민투표사무에 관하여 관계 행정기관에 필요한 지시를 할 수 있다. 국가원로자문회의의 의장은 직전대통령이 된다. 다만, 직전대통령이 없을 때에는 대통령이 지명한다.</p>
				</div>
				<div id="diary">
					<div id="imgBox">
						<img src="<%= request.getContextPath() %>/images/default.png" alt="" class="writeImg" />
					</div>
					<p class="writeDate">2022. 12. 05</p>
					<p class="writeContent">국회는 국정을 감사하거나 특정한 국정사안에 대하여 조사할 수 있으며, 이에 필요한 서류의 제출 또는 증인의 출석과 증언이나 의견의 진술을 요구할 수 있다. 탄핵결정은 공직으로부터 파면함에 그친다. 그러나, 이에 의하여 민사상이나 형사상의 책임이 면제되지는 아니한다. 헌법개정안은 국회가 의결한 후 30일 이내에 국민투표에 붙여 국회의원선거권자 과반수의 투표와 투표자 과반수의 찬성을 얻어야 한다.</p>
				</div>
			</div>
		</article>
	</section>
	
	<!-- 일기 작성 모달 -->
	<section id="diaryEnrollBack">
		<div id="diaryEnrollModal" class="modal fontStyle">
			<div id="diaryEnrollTitle">일기작성</div>
			<span id="diaryEnrollClose" onclick="modalClose(this);">X</span>
			<div id="diaryEnrollDiv">
				<div id="diaryEnroll">
					<form id="diaryEnrollFrm" name="diaryEnrollFrm">
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
									<td>
										<input type="button" id="designChoice" class="designChoice" value="디자인 선택" />
									</td>
								</tr>
								<tr>
									<td><label for="nowDate" class="labelDate">날짜 :&nbsp;&nbsp;</label></td>
									<td colspan="2"><input type="date" name="nowDate" id="nowDate" class="fontStyle" value=<%= formatToday %> readonly /></td>
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
									<td colspan="3"><input type="button" id="writeSubmit" class="fontStyle" onclick="writeDiary();" value="일기 등록" /></td>
								</tr>
							</tbody>
						</table>
					</form>			
				</div>
			</div>
		</div>
	</section>
	
	<!-- 디자인 선택 모달 -->
	<div id="designChoiceModal" class="fontStyle">
		<div id="designModalTitle">
			<span class="design-title">디자인 선택</span>
			<input type="button" value="X" class="fontStyle modal-close" onclick="modalClose(this);" />
			<hr />
		</div>
		<div id="designModalContent">
			<table>
				<tbody>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="디자인1이미지" class="designImage" />
						</td>
						<td>디자인1</td>
						<td>
							<input type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="디자인2이미지" class="designImage" />
						</td>
						<td>디자인2</td>
						<td>
							<input type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
					<tr>
						<td>
							<img src="<%= request.getContextPath() %>/images/default.png" alt="디자인3이미지" class="designImage" />
						</td>
						<td>디자인3</td>
						<td class="design-btn">
							<input type="button" value="선택" class="fontStyle designBtn" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<script>
		document.querySelector("#writeBtn").addEventListener('click', () => {
			const modal = document.querySelector('#diaryEnrollBack');
			console.log(modal);
			modal.style.display = 'flex';
		});
		
		designChoice.addEventListener('click', () => {
			designChoiceModal.style.display = 'inline-block';
		});
		
		diaryEnrollBack.onclick = () => {
			diaryEnrollBack.style.display = 'none';
		}
		
		const modalClose = (target) => {
			console.log(target.id);
			if (target.id != '') {
				diaryEnrollBack.style.display = 'none';
			} else {
				designChoiceModal.style.display = 'none';
			}
		};
	</script>

</body>
</html>