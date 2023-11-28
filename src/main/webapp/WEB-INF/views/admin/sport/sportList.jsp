<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container" id="sportlist_container">
	<h2 id="page-title">종목 목록</h2>
		<table>
        <tr>
            <th>종목번호</th>
            <th>종목명</th>
            <th>종목 설명</th>
            <th>종목 이미지</th>
        </tr>
		<c:forEach var="sport" items="${sportList}">
			<tr>
				<td>${sport.s_no}</td>
				<td><a href="edit?s_no=${sport.s_no}">${sport.sportname}</a></td>
				<td><a href="edit?s_no=${sport.s_no}" class="sportdesc">${sport.sportdesc}</a></td>
				<td><a href="edit?s_no=${sport.s_no}">${sport.filename}</a></td>
        	</tr>
		</c:forEach>
	</table>
	<a href="new" class="btn-black new-sport">종목 등록</a>
</div>
</body>
</html>