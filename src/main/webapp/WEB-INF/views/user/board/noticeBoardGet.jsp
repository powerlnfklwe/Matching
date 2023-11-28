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
		.detail-container {
			width: 1237px;
			margin: 50px auto;
			padding: 30px;
			background-color: #fff;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			border-radius: 5px;
			font-size: 18px;
			color: #333;
		}
		.board-detail {
			width: 100%;
			border-collapse: collapse;
			margin-bottom: 20px;
		}
		
		.board-detail th {
			background-color: #f2f2f2;
			padding: 10px;
			text-align: center;
			font-weight: normal;
			border: 1px solid #e6e6e6;
		}
		
		.board-detail td {
			border: 1px solid #e6e6e6;
			padding-left:35px;
		}
		.content-th{
			height:400px;
		}
		.content-td{
			padding-top:35px;
			padding-right:35px;
			padding-bottom:35px;
			height:400px;
		}
		.board-detail td:first-child,
		.board-detail th:first-child {
			width: 100px;
			font-weight: bold;
		}
		
		.board-detail td:last-child {word-break:break-all;}
		.text-box{margin-top:5px; margin-right:30px; margin-bottom:30px; padding:0;}
		.text-box h2{margin:0; padding:0;}
		.btn {margin:10px; padding:10px 20px; color:#fff; border-radius:5px; border:none; cursor:pointer; font-size:16px; line-height:1; float:right;}
		.btn-box{overflow:hidden;}
		.btn:hover{font-weight: bold; color:black;}
		#modify_btn{background-color:#00B4FC;}
		#delete_btn{background-color:#FFBDBD;}
		#list_btn{background-color:#e6e6e6;}
</style>
</head>
<body>
	<div class="detail-container">
		<div class=text-box>
			<h2>공지사항 글수정</h2>
		</div>
	    	<table class="board-detail">
	    		<colgroup>
					<col style="width: 8%"/>
					<col style="width: 20%"/>
					<col style="width: 8%"/>
					<col style="width: 20%"/>
				</colgroup>
 				<tbody>
					<tr>
						<th>글번호</th>
						<td colspan="3">${pageInfo.no}</td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3">${pageInfo.title }</td>
					</tr>
					<tr>
						<th>관리자</th>
						<td colspan="1">${pageInfo.adminid}</td>
						<th>작성일</th>
						<td colspan="1"><fmt:formatDate pattern = "yyyy-MM-dd HH:mm:ss" value ="${pageInfo.writedate }"/></td>
					</tr>
					<tr>
						<th class="content-th">내용</th>
						<td class="content-td" colspan="3">${pageInfo.content }</td>
					</tr>
				</tbody>
			</table>
			<div class="btn-box">
				<a class="btn" id="list_btn">목록</a>
				<c:if test="${canEdit }"> 
					<a class="btn" id="delete_btn">삭제</a>
					<a class="btn" id="modify_btn">수정</a>
				</c:if>
			</div>
	</div>
	<form id="infoForm" action="/board/noticeBoard/modify" method="get">
		<input type="hidden" id="no" name="no" value='<c:out value="${pageInfo.no}"/>'>
	</form>
<script>
	let form = $("#infoForm");
	
	$("#list_btn").on("click", function(e){
		form.find("#no").remove();
		form.attr("action", "/board/noticeBoard");
		form.submit();
	});
	
	$("#modify_btn").on("click", function(e){
		form.attr("action", "/board/noticeBoard/modify");
		form.submit();
	});	
	
	$("#delete_btn").on("click", function(e){
		form.attr("action", "/board/noticeBoard/delete");
		form.attr("method","post");
		form.submit();
	})
</script>	
</body>
</html>