<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<section>
	    <form action="" id="writeLetterFrm">
	        <fieldset>
	            <table>
	            <thead>
	                <tr>
	                    <th id="writerLetterTitle" class="fontStyle white" colspan="3">편지쓰기</th>
	                </tr>
	            </thead>
	            <tbody>
	                <tr>
	                    <td id="labelTd" class="fontStyle white">받는 사람</td>
	                    <td id="fontStyle"><input type="checkbox" name="" id="">임의의 누군가에게 보내기</td>
	                    <td>
	                    	<input type="text" list="friendList"/>
	                        <datalist id="friendList">
	                            <option value="홍길동">홍길동</option>
	                        </datalist>
	                    </td>
	                </tr>
	            </tbody>
	            </table>
	        </fieldset>
	    </form>
	</section>
</body>
</html>