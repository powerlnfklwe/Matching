<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="login_container">
	<h1>로그인</h1>
	<form method="post" action="loginOk" id="logFrm">
		<ul>
			<li class="logFrm">아이디</li>
			<li class="logFrm"><input type="text" name="id" id="log_id"/></li>
			<li class="logFrm">비밀번호</li>
			<li class="logFrm"><input type="password" name="password" id="log_password"/></li>
			<li id="log_LOGIN" ><input type="submit" value="LOGIN" /></li>
			<li id="log_register"><a href="register" >회원가입</a></li>
		</ul>
	</form>
	<br/>
	<!--   
	<div>
		<img src="static/img/futsal.jpeg" id="log_img" >

	</div>
	-->
</div>