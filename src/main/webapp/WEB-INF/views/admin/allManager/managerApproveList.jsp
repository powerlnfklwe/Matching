<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container" id="container-allManager">
	<h2 id="page-title">매니저 승인 대기 목록</h2>
	<table>
		<tr>
			<th>이름</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>연락처</th>
            <th>입금계좌</th>
            <th>성별</th>
            <th>가입날짜</th>
            <th>종목</th>
		</tr>
		<c:forEach var="mDTO" items="${list}">
			<tr>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.m_name}</a></td>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.managerid}</a></td>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.email}</a></td>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.tel}</a></td>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.m_account}</a></td>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.gender}</a></td>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.signupdate}</a></td>
				<td><a href="/admin/manager/approvedetail?managerid=${mDTO.managerid}">${mDTO.sportname}</a></td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징 -->
	<div class="pagingDiv">
	<ul>
		<!-- 이전페이지 -->
		<c:if test="${vo.nowPage>1}">
			<li><a href="approvelist?nowPage=${vo.nowPage-1}">이전</a></li>
		</c:if>
		<!-- 페이지번호 -->
		<c:forEach var="pageNum" begin="${vo.startPageNum}" end="${vo.startPageNum+(vo.onePageNumCount-1)}" step="1">
			<c:if test="${pageNum<=vo.totalPage}">
				<li>
				<c:if test="${vo.nowPage==pageNum }"><b></c:if>
				<a href="approvelist?nowPage=${pageNum}">${pageNum}</a>
				<c:if test="${vo.nowPage==pageNum }"></b></c:if>
				</li>
			</c:if>
			<c:if test="${pageNum>vo.totalPage}">
				<li style="visibility:hidden;">${pageNum}</li>
			</c:if>
		</c:forEach>
		<!-- 다음페이지 -->
		<c:if test="${vo.nowPage<vo.totalPage}">
			<li><a href="approvelist?nowPage=${vo.nowPage+1}">다음</a></li>
		</c:if>
	</ul>
	</div>
</div>
</body>
</html>
