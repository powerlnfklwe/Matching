<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  <title>참가명단확인</title>
   <meta charset="UTF-8">
	
	<link href="${path}/static/style/manager/entry.css" rel="stylesheet" type="text/css" />

	</head>
	<style>

</style>
  
<body>
<div id="entry-container">
	<h1>참가명단 확인</h1>
	<div class="entry-wrap">
	    <table>
			<thead>
		        <tr>
		          <th>아이디</th>
		          <th>이름</th>
		          <th>연락처</th>
		          <th>성별</th>
		          <th>랭크</th>
		        </tr>
			</thead>
	      	<tbody>
				<c:forEach items="${entryList}" var="item">
					<c:if test="${item.getNo() == no}">
					    <tr>
							<td><c:out value="${item.getUserid()}" /></td>
							<td><c:out value="${item.getUsername()}" /></td>
							<td><c:out value="${item.getTel()}" /></td>
							<td><c:out value="${item.getGender()}" /></td>
							
							<c:set var="rank" value="${item.getRank()}"/>
							<td>
								<c:choose>
									<c:when test="${rank==1}">
						            	브론즈
									</c:when>
						         	<c:when test="${rank==2}">
						            	실버
						         	</c:when>
						         	<c:when test="${rank==3}">
						            	골드
									</c:when>
						         	<c:when test="${rank==4}">
						            	플래티넘
						         	</c:when>
						         	<c:when test="${rank==5}">
						            	다이아
									</c:when>
						         	<c:otherwise>
						            	no Rank
						         	</c:otherwise>
						      	</c:choose>
							</td>
					    </tr>
				    </c:if>
			  </c:forEach>
			</tbody>
		</table>
    	<button class="btn" onclick="location.href='${path}/manager/manager10'">이전경기목록</button> 
  	</div>
  </div>
</body>

</html>