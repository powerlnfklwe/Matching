<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script>
	$(function(){
		$("#searchForm").submit(function(){
			return true;
		});
	});
</script>
<div class="container">
	<h2 id="page-title">회원님의 활동 내역</h2>
	<div id="userLog_container">
		
		<form method="get" id="searchForm" action="/admin/userLog/${userid}">
			<select name="searchKey" id="search">
				<option value="all">모든 게임</option>
				<option value="rank_game">랭크 게임</option>
				<option value="norm_game">일반게임</option>
			</select>
			<input type="submit" value="Search" class="btn-submit"/>
			
		</form>
	
		<br/>
		<ul class="userLog">
				<c:forEach var="UserLogDTO" items="${list}">
					
					<ul class="list-group">
					<li class="list-group-item list-group-item-light">
						<!-- 구장 이름 -->
						<div class="userlog1" >${UserLogDTO.stadium }</div>
						<!-- 경기 시간 -->
						<div class="userlog2" >
							<fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${UserLogDTO.gametime }"/>
						</div>
						<!-- 경기장 위치 -->
						<div class="userlog3">${UserLogDTO.location}</div>
						<br/>
						
					</li>
					</ul>
				</c:forEach>
				<c:forEach var="UserLogDTO" items="${listNorm}">
					<ul class="list-group">
					<li class="list-group-item list-group-item-info">
						<!-- 구장 이름 -->
						<div class="userlog1">${UserLogDTO.stadium }</div>
						<!-- 경기 시간 -->
						<div class="userlog2" >${UserLogDTO.gametime }</div>
						<!-- 경기장 위치 -->
						<div class="userlog3">${UserLogDTO.location}</div>
						<br/>
					</li>
					</ul>
				</c:forEach>
		</ul>
		
		<div class="userLog_List_btn">
		<a href="/admin/userList" class="btn-gray">회원 목록</a>
		</div>
	</div>
</div>
</body>
</html>	