<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		.detail-container {
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
		.input-group {
			display: flex;
		  	flex-direction: row;
			margin-bottom:10px;
			border:1px #e6e6e6 solid;
		}
		.input-group input, .input-group textarea{padding:20px; border:1px #e6e6e6 solid; width:100%;}
		.input-group textarea{min-height: 500px;}
		.text-box{margin-top:5px; margin-right:30px; margin-bottom:30px; padding:0;}
		.text-box h2{margin:0; padding:0;}
		.btn {float:right;  background-color:#00B4FC; }
		.btn:hover {background-color:#00B4FC; font-weight: bold; color:white;}
</style>
</head>
<body>
	<div class="detail-container">
		<div class=text-box>
			<h2>공지사항 글쓰기</h2>
		</div>
	<form action="/board/noticeBoard/enroll" method="post">
		<div class="input-group">
			<input name="title" placeholder=" 제목을 입력해주세요.">
		</div>
		<div class="input-group">	
			<textarea rows="3" name="content" placeholder=" 내용을 입력해주세요."></textarea>
		</div>
		<input type="hidden" name="adminid" values="<%=session.getAttribute("logId") %>">
		<button class="btn">등록</button>
	</form>
	</div>
</body>
</html>