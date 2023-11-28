<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="${path}/static/style/register/register.css" rel="stylesheet" type="text/css" />
<link href="${path}/static/style/admin/admin.css" rel="stylesheet" type="text/css" />
<link href="${path}/static/style/style.css" rel="stylesheet" type="text/css" />


<div class="container1">
	<h1 style="color:#660066">로그인</h1>
	<form method="post" action="loginAdminOk" id="logAdminFrm">
		
		<ul>
			<li>아이디</li>
			<li><input type="text" name="adminid" id="adminid" style="width:600px; height:40px;"/></li>
			<li>비밀번호</li>
			<li><input type="password" name="password" id="password" style="width:600px; height:40px"/></li>
			<li><input type="submit" value="LOGIN" style="width:600px; height:40px;"/></li>
			
		</ul>
	</form>
	<br/>
	<div>
		<img src="static/img/futsal.jpeg" width= "600px" height= "400px">
	</div>
</div>