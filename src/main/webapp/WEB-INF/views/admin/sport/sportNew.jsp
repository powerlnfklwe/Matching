<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	//유효성검사
	$(function(){
		$("#sportForm").submit(function(){
			if($("#sportname").val()==""){
				alert("종목명을 입력하세요.");
				return false;
			}
			if($("#sportdesc").val()==""){
				alert("종목 설명을 입력하세요.");
				return false;
			}
			if($("#sportimage").val()==""){
				alert("종목 이미지 파일을 첨부하세요.");
				return false;
			}
			return true;
		});
		
		// 취소 버튼 누르면 이전 페이지로 돌아가기
		$(".prev").click(function(){
			history.back();
		});
	});
</script>
<div class="container">
	<h2 id="page-title">종목 등록</h2>
	<form method="post" action="newOk" id="sportForm" enctype="multipart/form-data">
		<ul>
			<li class="item">
				<label for="sportname">종목명</label>
				<input type="text" name="sportname" id="sportname" maxlength="10" />
			</li>
			<li class="item">
				<label for="sportdesc">종목 설명</label>
				<textarea name="sportdesc" id="sportdesc" maxlength="100"></textarea>
			</li>
			<li class="item">
				<label for="filename">종목 이미지</label>
				<input type="file" name="filename" id="sportimage" />
			</li>
		</ul>
		<div class="btns">
			<a class="btn-gray btn-cancel prev">취소</a>
			<input type="submit" value="등록" class="btn-black"/>
		</div>
	</form>
</div>
</body>
</html>