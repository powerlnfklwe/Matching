<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container" id="container-oneManager3">
	<h2>매니저 ${dto.m_name} 님의 활동내역</h2>
	<div class="content_box">
		<c:if test="${recent==null}"><h3>활동내역이 없습니다.</h3></c:if>
		<c:if test="${recent!=null}">
			<c:forEach var="rDTO" items="${recent}" varStatus="status">
				<div class="item">
					<h3>${stadium[status.index].stadium}</h3>
					<div class="sub_item">
						<div class="little_item">
							<fmt:formatDate pattern="yyyy년 MM월 dd일 HH:mm" value="${rDTO.gametime}" /><br/>
							${stadium[status.index].location}
						</div>
						<div class="little_item">
							<span>매니저비 : <fmt:formatNumber value="${rDTO.managerfee}" maxFractionDigits="3"/> 원</span>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
	<div class="manager_footer">
		<a href="managerdetail?managerid=${dto.managerid}" id="back_to_detail">이전 페이지로 이동</a>
	</div>
</div>
</body>
</html>
