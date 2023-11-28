<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container" id="usersList_container">
	<h2 id="page-title">회원목록</h2>
	<h4>※회원 아이디 선택 시 회원 정보, 회원 이름 선택 시 회원 활동내역 페이지 이동</h4>
	<table>
		<tr>
			<th>회원 아이디</th>
            <th>이메일</th>
            <th>회원 이름</th>
            <th>연락처</th>
            <th>등록일</th>
            <th>성별</th>
            <th>나이</th>
		</tr>
		<c:forEach var="users" items="${list}">
			<tr>
				<td><a href="userEdit/${users.userid}">${users.userid}</a></td>
				<td>${users.email}</td>
				<td><a href="userLog/${users.userid}">${users.username}</a></td>
				<td>${users.tel}</td>
				<td>${users.signupdate }</td>
				<td>${users.gender}</td>
				<td>${users.age}</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징 -->
	<div class="pagingDiv">
	<ul>
		<!-- 이전페이지 -->
		<c:if test="${vo.nowPage>1}">
			<li><a href="userList?nowPage=${vo.nowPage-1}">이전</a></li>
		</c:if>
		<!-- 페이지번호 -->
		<c:forEach var="pageNum" begin="${vo.startPageNum}" end="${vo.startPageNum+(vo.onePageNumCount-1)}" step="1">
			<c:if test="${pageNum<=vo.totalPage}">
				<li>
				<c:if test="${vo.nowPage==pageNum }"><b></c:if>
				<a href="userList?nowPage=${pageNum}">${pageNum}</a>
				<c:if test="${vo.nowPage==pageNum }"></b></c:if>
				</li>
			</c:if>
			<c:if test="${pageNum>vo.totalPage}">
				<li style="visibility:hidden;">${pageNum}</li>
			</c:if>
		</c:forEach>
		<!-- 다음페이지 -->
		<c:if test="${vo.nowPage<vo.totalPage}">
			<li><a href="userList?nowPage=${vo.nowPage+1}">다음</a></li>
		</c:if>
	</ul>
	</div>
</div>
</body>
</html>