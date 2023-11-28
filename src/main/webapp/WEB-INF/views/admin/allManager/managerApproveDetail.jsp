<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container" id="container-oneManager">
	<form method="post" id="managerApproveForm">
		<div class="manager_header">
			<h2>매니저 승인 대기 목록</h2>
			<table>
				<tr>
					<th>이름</th>
					<th>아이디</th>
					<th>이메일</th>
					<th>연락처</th>
					<th>주소</th>
					<th>성별</th>
					<th>가입날짜</th>
					<th>종목</th>
				</tr>
				<tr>
					<c:set var="mDTO" value="${dto}" />
					<td>${mDTO.m_name}</td>
					<td>${mDTO.managerid}</td>
					<td>${mDTO.email}</td>
					<td>${mDTO.tel}</td>
					<td>${mDTO.address}</td>
					<td>${mDTO.gender}</td>
					<td>${mDTO.signupdate}</td>
					<td>${mDTO.sportname}</td>
				</tr>
			</table>
			<input type="hidden" value="${mDTO.managerid}" name="managerid"/>
		</div>
	</form>
	<div class="manager_info">입금계좌 : ${mDTO.m_account}</div>
	<img src="${path}/static/img/admin/sample_proof.jpg" alt="sample proof img" class="proof_img"/>
		
		<div class="manager_tail">
			첨부파일 : <a href="${path}/static/img/admin/sample_proof.jpg" download>&nbsp;인증서류</a>
		</div>
		<div class="manager_tail">
			<a href="approvelist">목록보기</a>
		</div>
		<div class="button_box">
			<input type="button" value="승인" id="approve"/>
			<input type="button" value="보류" id="postpone"/>
			<input type="button" value="거절" id="refuse"/>
		</div>
</div>

<script>
	var m_name = "${mDTO.m_name}";
	
	$(function(){
		$("#approve").click(function(){
			alert(m_name+" 님의 요청이 승인되었습니다.");
			$("#managerApproveForm").attr("action","approveOk");
			$("#managerApproveForm").submit();
		});
		
		$("#postpone").click(function(){
			alert(m_name+" 님의 요청이 보류되었습니다.");
			location.href="approvelist";
		});
		
		$("#refuse").click(function(){
			alert(m_name+" 님의 요청이 거부되었습니다.");
			$("#managerApproveForm").attr("action","refuseOk");
			$("#managerApproveForm").submit();
		});
	});
</script>

</body>
</html>
