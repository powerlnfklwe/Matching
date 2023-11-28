<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	$(function(){
		//유효성검사
		$("#infoEditForm").submit(function(){
			//비밀번호검사
			if($("#userpwd").val()==""){
				alert("비밀번호를 입력하셔야 회원정보수정이 가능합니다.");
				return false;
			}
		})
	})	
		
</script>
	<!-- 오른쪽 내용칸 -->
	<div id="infoContent"> 
		<h3 class="infoh3">내정보수정</h3>
		<hr/>
		<!--회원정보수정 폼-->
		<form method="post" id="infoEditForm" action="infoEdit"> 
			<ul id="infoUl">
				<li>아이디</li>
				<li>
					<input type="text" name="userid" id="userid" minlength="4" maxlength="15" value="${dto.userid}" readonly/>
				</li>
				<li>비밀번호</li>
				<li>
					<input type="password" placeholder="비밀번호를 입력하세요..." name="password" id="userpwd" minlength="4" maxlength="15" value="" />
				</li>
				<li>성별</li>
				<li id="infoGender">
					<input type="radio" name="gender" value="남성"<c:if test="${dto.gender=='남성'}">checked</c:if> readonly/> 남성
					<input type="radio" name="gender" value="여성"<c:if test="${dto.gender=='여성'}">checked</c:if> readonly/> 여성
				</li>
				<li>이름</li>
				<li>
					<input type="text" name="username" id="username" readonly value="${dto.username}"/>
				</li>
				<li>나이</li>
				<li>
					<input type="text" name="age" id="age" value="${dto.age }" readonly/>
				</li>
				<li>연락처</li>
				<li id="infoTel">
					<select name="tel1" id="tel1" >
						<option value="010" <c:if test="${dto.tel1=='010'}">selected</c:if>>010</option>
							<option value="02" <c:if test="${dto.tel1=='02'}">selected</c:if>>02</option>
							<option value="031" <c:if test="${dto.tel1=='031'}">selected</c:if>>031</option>
							<option value="041" <c:if test="${dto.tel1=='041'}">selected</c:if>>041</option>
							<option value="051" <c:if test="${dto.tel1=='051'}">selected</c:if>>051</option>
					</select>
					&ensp;- <input type="text" name="tel2" id="tel2" maxlength="4" value="${dto.tel2}"/>
					- <input type="text" name="tel3" id="tel3" maxlength="4" value="${dto.tel3}"/>
				</li>
				<li>이메일</li>
				<li>
					<input type="text" name="email" id="email" value="${dto.email}" />
				</li>
				<li >주소</li>
				<li>
					<input type="text" name="address" id="address" value="${dto.address}"/>
				</li>
				<li>MBTI</li>
				<li>
					<select name="mbti" id="mbti" >
						<!-- <option value="">=== 선택 ===</option> -->
						<optgroup label="I">
							<option value="ISTJ" <c:if test="${dto.mbti=='ISTJ'}">selected</c:if>>ISTJ</option>
							<option value="ISFJ" <c:if test="${dto.mbti=='ISFJ'}">selected</c:if>>ISFJ</option>
							<option value="INTJ" <c:if test="${dto.mbti=='INTJ'}">selected</c:if>>INTJ</option>
							<option value="INFJ" <c:if test="${dto.mbti=='INFJ'}">selected</c:if>>INFJ</option>
							<option value="ISTP" <c:if test="${dto.mbti=='ISTP'}">selected</c:if>>ISTP</option>
							<option value="ISFP" <c:if test="${dto.mbti=='ISFP'}">selected</c:if>>ISFP</option>
							<option value="INTP" <c:if test="${dto.mbti=='INTP'}">selected</c:if>>INTP</option>
							<option value="INFP" <c:if test="${dto.mbti=='INFP'}">selected</c:if>>INFP</option>
						</optgroup>
						<optgroup label="E">
							<option value="ESTP" <c:if test="${dto.mbti=='ESTP'}">selected</c:if>>ESTP</option>
							<option value="ESFP" <c:if test="${dto.mbti=='ESFP'}">selected</c:if>>ESFP</option>
							<option value="ENTP" <c:if test="${dto.mbti=='ENTP'}">selected</c:if>>ENTP</option>
							<option value="ENFP" <c:if test="${dto.mbti=='ENFP'}">selected</c:if>>ENFP</option>
							<option value="ESTJ" <c:if test="${dto.mbti=='ESTJ'}">selected</c:if>>ESTJ</option>
							<option value="ESFJ" <c:if test="${dto.mbti=='ESFJ'}">selected</c:if>>ESFJ</option>
							<option value="ENTJ" <c:if test="${dto.mbti=='ENTJ'}">selected</c:if>>ENFJ</option>
							<option value="ENFJ" <c:if test="${dto.mbti=='ENFJ'}">selected</c:if>>ENFJ</option>
						</optgroup>	
					</select>
				</li>
			</ul>
			<div class="infoBtn"><button type="submit" id="infoBtn">수정하기</button></div>
		</form> <!-- 회원정보수정 폼 end -->
	</div><!-- 오른쪽 내용칸 end ------------>
</div>	
