<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<style>
	#modifyForm {
			width: 1237px;
			margin: 50px auto;
			padding: 40px;
			padding-bottom:60px;
			background-color: #fff;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			border-radius: 5px;
			font-size: 18px;
			color: #333;
		}
	.text-box{margin-top:5px; margin-right:30px; margin-bottom:30px; padding:0;}
	.text-box h2{margin:0; padding:0;}
	.input_wrap input, .input_wrap textarea{margin-bottom:10px; padding:20px; border:1px #e6e6e6 solid; width:100%;}
	.input_wrap textarea{min-height: 500px;}
	.btn{float:right;margin-bottom: 10px; margin-left:10px;}
	.btn:hover {font-weight: bold; color:white;}
	#modify_btn{background-color:#00B4FC;}
	#cancel_btn{background-color:#FFBDBD;}
	#list_btn{background-color:#e6e6e6;}
</style>
</head>
<body>
	<form id="modifyForm" action="/board/noticeBoard/modify" method="post">
	<div class=text-box>
		<h2>공지사항 글수정</h2>
	</div>
	<div class="input_wrap">
		<label>번호</label>
		<input name="no" readonly="readonly" value='<c:out value="${pageInfo.no}"/>' >
	</div>
	<div class="input_wrap">
		<label>제목</label>
		<input name="title" value='<c:out value="${pageInfo.title}"/>' >
	</div>
	<div class="input_wrap">
		<label>내용</label>
		<textarea rows="3" name="content"><c:out value="${pageInfo.content}"/></textarea>
	</div>
	<div class="btn_wrap">
		<a class="btn" id="modify_btn">수정 완료</a>
		<a class="btn" id="cancel_btn">수정 취소</a>
		<a class="btn" id="list_btn">목록</a> 
	</div>
	</form>
	<form id="infoForm" action="/board/noticeBoard/modify" method="get">
		<input type="hidden" id="no" name="no" value='<c:out value="${pageInfo.no}"/>'>
	</form>
<script>
	let form = $("#infoForm");
	let mForm = $("#modifyForm");
	$("#list_btn").on("click", function(e){
		form.find("#no").remove();
		form.attr("action", "/board/noticeBoard");
		form.submit();
	});
	
	$("#modify_btn").on("click", function(e){
		mForm.submit();
	});
	
	$("#cancel_btn").on("click", function(e){
		form.attr("action", "/board/noticeBoard/get");
		form.submit();
	});
	
</script>	
</body>
</html>