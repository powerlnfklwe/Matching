<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="static/style/style.css" rel="stylesheet" type="text/css" />
<link href="${path}/static/style/manager/manager.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<div class="loginMan_container">
	<a href="${path}/userHome"><img src="static/img/logo/logo 4.png" id="logoManager"></a>
	<h1>매니저 로그인</h1>
	<form method="post" action="loginManOk" id="logManFrm">
		<ul>
			<li class="logManFrm">아이디</li>
			<li class="logManFrm" ><input type="text" name="managerid" id="logMan_id"/></li>
			<li class="logManFrm">비밀번호</li>
			<li class="logManFrm"><input type="password" name="password" id="logMan_password"/></li>
			<li id="logMan_LOGIN"><input type="submit" value="LOGIN" /></li>
			<li id="logMan_register"><a href="manager">회원가입</a></li>
		</ul>
	</form>
	
	<div>
		<img src="static/img/manager/refree2.jpg" id="logMan_img">
	</div>
</div>