<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${path}/static/style/register/register.css" rel="stylesheet" type="text/css" />
<link href="${path}/static/style/style.css" rel="stylesheet" type="text/css" />
<link href="${path}/static/style/manager/registermanager.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script>
	$(function(){
		//아이디 중복검사
		$("input[value=아이디중복검사]").click(function(){
			if($("#managerid").val()!=""){
				window.open("manidCheck?managerid="+$("#managerid").val(), "chk","width=450,height=300");
			}else{
				alert("아이디를 입력 후 중복검사하세요.");
			}
		});
		
		$("#managerForm").submit(function(){
			//form태그의 action속성 설정하기
			//$("#managerForm").attr("action","managerOk");
			return true;
		});
	});

</script>
<div class="manager_container">
	<br/>
	<h1>&nbsp;&nbsp;매니저 회원가입</h1>
	<br/>
	<form method="post" id="registerManForm" enctype="multipart/form-data" action="managerOk">
		<ul id="registerMan-ul">
			<li>
				<input type="radio" name="type" value="manager" checked/> 매니저
			</li>
			<li>아이디</li>
			<li class="registerMan-li">
				<input type="text" placeholder="아이디를 입력하세요..."name="managerid" id="managerid" minlength="4" maxlength="15" />
				<input type="button" value="아이디중복검사" id="idCheck"/>
				<input type="hidden" id="idStatus" value="N"/>
			</li>
			<li>비밀번호</li>
			<li class="registerMan-li">
				<input type="password" placeholder="비밀번호를 입력하세요..." name="password" id="managerpwd" minlength="4" maxlength="15"/>
			</li>
			<li>성별</li>
			<li class="registerMan-li" id="registerMan-gender">
				<input type="radio" name="gender" value="남성"/> 남성
				<input type="radio" name="gender" value="여성"/> 여성
			</li>
			<li>이름</li>
			<li class="registerMan-li"><input type="text" placeholder="이름을 입력하세요..."name="m_name" id="m_name" minlength="2" maxlength="10"/></li>
			<li>연락처</li>
			<li class="registerMan-li">
				<select name="tel1" id="tel1">
					<option value="010">010</option>
					<option value="02">02</option>
					<option value="031">031</option>
					<option value="041">041</option>
					<option value="051">051</option>
				</select>
				- <input type="text" name="tel2" id="tel2" maxlength="4"/>
				- <input type="text" name="tel3" id="tel3" maxlength="4"/>
			</li>
			<li>이메일</li>
			<li class="registerMan-li"><input type="text" name="email" id="email"/></li>
			<li>주소</li>
			<li class="registerMan-li"><input type="text" name="address" id="address"/></li>
			<li>종목 선택</li>
			<li class="registerMan-li">
				<select name="s_no" id="s_no"> 
					<c:forEach var="SportDTO" items="${sportList}">
						<option value="${SportDTO.s_no}">${SportDTO.sportname}</option>
					</c:forEach>
				</select>
			</li>
			<li>계좌번호</li>
			<li class="registerMan-li"><input type="text" name="m_account" id="m_account"></li>
		
			
			<li>인증서류첨부</li>
			<li><input type="file" name="prooffile" id="prooffile"></li>
			<br/>
			<li class="registerMan-submit">
				<input type="submit" value="회원가입" id="submit"/>
			</li>
		</ul>	
	</form>
	
	<form >
		<img src="static/img/manager/refree3.jpg" id="manager_img" >
	</form>
	 
</div>

