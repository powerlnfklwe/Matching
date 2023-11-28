<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container" id="ranklist_container">
	<h2 id="page-title">랭크경기 목록</h2>
	<table>
        <tr>
            <th>경기번호</th>
            <th>종목</th>
            <th>구장이름</th>
            <th>경기일정</th>
            <th>이용시간</th>
            <th>매니저</th>
            <th>경기상태</th>
        </tr>
		<c:forEach var="rankGame" items="${rankGameList}">
			<tr>
				<td>${rankGame.no}</td>
				<td>${rankGame.sportname}</td>
				<td><a href="edit?no=${rankGame.no}" class="stadium">${rankGame.stadium}</a></td>
				<td><fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${rankGame.gametime}" /></td>
				<td>${rankGame.usetime}</td>
				<td>${rankGame.managerid}</td>
				<td>
					<c:set var="status" value="${rankGame.g_status}"/>
					<c:choose>
						<c:when test="${status==0}">
			            	대기
						</c:when>
			         	<c:when test="${status==1}">
			            	확정
			         	</c:when>
			         	<c:when test="${status==2}">
			            	취소
			         	</c:when>
			      	</c:choose>
				</td>
        	</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징 -->
	<div class="pagingDiv">
	<ul>
		<!-- 이전페이지 -->
		<c:if test="${vo.nowPage>1}">
			<li><a href="rankgamelist?nowPage=${vo.nowPage-1}">이전</a></li>
		</c:if>
		<!-- 페이지번호 -->
		<c:forEach var="pageNum" begin="${vo.startPageNum}" end="${vo.startPageNum+(vo.onePageNumCount-1)}" step="1">
			<c:if test="${pageNum<=vo.totalPage}">
				<li>
				<c:if test="${vo.nowPage==pageNum }"><b></c:if>
				<a href="rankgamelist?nowPage=${pageNum}">${pageNum}</a>
				<c:if test="${vo.nowPage==pageNum }"></b></c:if>
				</li>
			</c:if>
			<c:if test="${pageNum>vo.totalPage}">
				<li style="visibility:hidden;">${pageNum}</li>
			</c:if>
		</c:forEach>
		<!-- 다음페이지 -->
		<c:if test="${vo.nowPage<vo.totalPage}">
			<li><a href="rankgamelist?nowPage=${vo.nowPage+1}">다음</a></li>
		</c:if>
	</ul>
	</div>
	<a href="${path}/admin/game/new" class="btn-black new-game">경기 등록</a>
</div>
</body>
</html>