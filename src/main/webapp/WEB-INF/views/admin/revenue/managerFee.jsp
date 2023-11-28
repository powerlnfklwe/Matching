<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
	$(function(){
		$("#wait").click(function() {

			const response = confirm("지급 완료 처리 하시겠습니까?");
			if(!response) {
				return false;
			}
			return true;
		});
	});
</script>
<div class="container">
	<h2 id="page-title">매니저비</h2>
	<div id="managerfee_container">
		<table>
			<tr class="managerfee">
				<th id="">번호</th>
				<th id="amount">금액</th>
				<th id="no">경기 번호</th>
				<th id="managerid">매니저 아이디</th>
				<th id="">매니저명</th>
				<th id="">지급계좌</th>
				<th id="datetime">지급일</th>
				<th id="d_status">지급여부</th>
			</tr>
			<c:forEach var="m_settlement" items="${managerFee}" varStatus="status">
				<tr>
					<td>${(vo.nowPage-1)*(vo.onePageRecord)+ status.count}</td>
					<td><fmt:formatNumber value="${m_settlement.amount}" maxFractionDigits="3"/>원</td>
					<td>${m_settlement.no}</td>
					<td>${m_settlement.managerid}</td>
					<td>${m_settlement.m_name}</td>
					<td>${m_settlement.m_account}</td>
					<td>
						<c:if test="${m_settlement.datetime==null}">
							<span>-</span>
						</c:if>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${m_settlement.datetime}" /></td>
					<td>
						<form method="post" action="waitOk" id="m_settleForm">
							<c:if test="${m_settlement.d_status==0}">
								<input type="submit" value="지급" id="wait" />
								<input type="hidden" value="${m_settlement.managerid}" name="managerid"/>
								<input type="hidden" value="${m_settlement.no}" name="no"/>
								
							</c:if>
							<c:if test="${m_settlement.d_status==1}">
								<li>지급완료</li>
							</c:if>
						</form>
					</td>
				<tr>
			</c:forEach>
		</table>
		
		<!-- 페이징 -->
		<div class="pagingDiv">
		<ul>
			<!-- 이전페이지 -->
			<c:if test="${vo.nowPage>1}">
				<li><a href="managerfee?nowPage=${vo.nowPage-1}">이전</a></li>
			</c:if>
			<!-- 페이지번호 -->
			<c:forEach var="pageNum" begin="${vo.startPageNum}" end="${vo.startPageNum+(vo.onePageNumCount-1)}" step="1">
				<c:if test="${pageNum<=vo.totalPage}">
					<li>
					<c:if test="${vo.nowPage==pageNum }"><b></c:if>
					<a href="managerfee?nowPage=${pageNum}">${pageNum}</a>
					<c:if test="${vo.nowPage==pageNum }"></b></c:if>
					</li>
				</c:if>
				<c:if test="${pageNum>vo.totalPage}">
					<li style="visibility:hidden;">${pageNum}</li>
				</c:if>
			</c:forEach>
			<!-- 다음페이지 -->
			<c:if test="${vo.nowPage<vo.totalPage}">
				<li><a href="managerfee?nowPage=${vo.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
		</div>
	</div>
</div>
</body>
</html>