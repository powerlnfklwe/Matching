<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${path}/static/style/register/register.css" rel="stylesheet" type="text/css" />
<link href="${path}/static/style/style.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script>
	$(function(){
		//아이디 중복검사
		$("input[value=아이디중복검사]").click(function(){
			if($("#userid").val()!=""){
				window.open("idCheck?userid="+$("#userid").val(), "chk","width=450,height=300");
			}else{
				alert("아이디를 입력 후 중복검사하세요.");
			}
		
	
		
			/* var value = (mbti.options[mbti.selectedIndex].value);
			
			if(value==""){
				alert("mbti를 선택하세요");
				return false; */
			
			
		});
		
		
		$("#registerForm").submit(function(){
			//form태그의 action속성 설정하기
			$("#registerForm").attr("action","registerOk");
			return true;
		});
	});

</script>

<div class="register_container">
	
	<h2>회원가입</h2>
	
	<form method="post" id="registerForm">
		<ul id="register-ul">
			<br/>
			<li class="register-li-type">
				<input type="radio" name="type" id="type" value="user" checked/> 사용자
			</li>
			<li>아이디</li>
			<li class="register-li">
				<input type="text" placeholder="아이디를 입력하세요..."name="userid" id="userid" minlength="4" maxlength="15" />
				<input type="button" value="아이디중복검사" id="idCheck"/>
				<input type="hidden" id="idStatus" value="N"/>
			</li>
			<li>비밀번호</li>
			<li class="register-li">
				<input type="password" placeholder="비밀번호를 입력하세요..." name="password" id="userpwd" minlength="4" maxlength="15" />
			</li>
			<li>성별</li>
				<li class="register-li" id="register-gender">
					<input type="radio" name="gender" value="남성"/> 남성
					<input type="radio" name="gender" value="여성"/> 여성
				</li>
			<li>이름</li>	
			<li class="register-li">
				<input type="text" placeholder="이름을 입력하세요..."name="username" id="username" minlength="2" maxlength="10" />
			</li>
      		<li>나이</li>
      		<li class="register-li">
		 		 <input type="text" name="age" id="age"/>
		  	</li>
			<li>연락처</li>
			<li class="register-li">
				<select name="tel1" id="tel1">
					<option value="010">010</option>
					<option value="02">02</option>
					<option value="031">031</option>
					<option value="041">041</option>
					<option value="051">051</option>
				</select>
				- <input type="text" name="tel2" id="tel2" maxlength="4" />
				- <input type="text" name="tel3" id="tel3" maxlength="4" />
			</li>
			<li>이메일</li>
			<li class="register-li">
				<input type="text" name="email" id="email"/>
			</li>
			<li>주소</li>
			<li class="register-li">
				<input type="text" name="address" id="address"/>
			</li>
			<li>MBTI</li>
			<li class="register-li">
				<select name="mbti" id="mbti">
					<!-- <option value="">=== 선택 ===</option> -->
					<optgroup label="I">
						<option value="ISTJ">ISTJ</option>
						<option value="ISFJ">ISFJ</option>
						<option value="INTJ">INTJ</option>
						<option value="INFJ">INFJ</option>
						
						<option value="ISTP">ISTP</option>
						<option value="ISFP">ISFP</option>
						<option value="INTP">INTP</option>
						<option value="INFP">INFP</option>
					</optgroup>
					<optgroup label="E">
						<option value="ESTP">ESTP</option>
						<option value="ESFP">ESFP</option>
						<option value="ENTP">ENTP</option>
						<option value="ENFP">ENFP</option>
						
						<option value="ESTJ">ESTJ</option>
						<option value="ESFJ">ESFJ</option>
						<option value="ENTJ">ENTJ</option>
						<option value="ENFJ">ENFJ</option>
					</optgroup>	
				</select>
			</li>	
			<li class="register-submit">
				<input type="submit" value="회원가입" id="submit"/>
			</li>

		</ul>	
	</form>

	<!-- <form >
	<br/><br/> -->
	<img src="static/img/son.jpg" id="register_img"/>

	<!-- </form> -->
</div>

