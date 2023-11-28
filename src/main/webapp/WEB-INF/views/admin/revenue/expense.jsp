<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container">
	<h2 id="page-title">지출 내역</h2>
	<div id="expense_container">
		<table>
			<tr class="expense">
				<th id="">번호</th>
				<th id="amount">금액</th>
				<th id="">지출목록</th>
				<th id="">지출상세</th>
				<th id="datetime">날짜</th>
			</tr>
			<c:forEach var="m_settlement" items="${expense}" varStatus="status">
				<tr>
					<td>${(vo.nowPage-1)*(vo.onePageRecord)+ status.count}</td>
					<td><fmt:formatNumber value="${m_settlement.amount}" maxFractionDigits="3"/>원</td>
					<td>매니저 수당</td>
					<td>${m_settlement.m_name} 매니저 [지급계좌: ${m_settlement.m_account}]</td>
					<td>
						<c:if test="${m_settlement.datetime==null}">
							<span>-</span>
						</c:if>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${m_settlement.datetime}" />
					</td>
				<tr>
			</c:forEach>
		</table>
		
		<!-- 페이징 -->
		<div class="pagingDiv">
		<ul>
			<!-- 이전페이지 -->
			<c:if test="${vo.nowPage>1}">
				<li><a href="expense?nowPage=${vo.nowPage-1}">이전</a></li>
			</c:if>
			<!-- 페이지번호 -->
			<c:forEach var="pageNum" begin="${vo.startPageNum}" end="${vo.startPageNum+(vo.onePageNumCount-1)}" step="1">
				<c:if test="${pageNum<=vo.totalPage}">
					<li>
					<c:if test="${vo.nowPage==pageNum }"><b></c:if>
					<a href="expense?nowPage=${pageNum}">${pageNum}</a>
					<c:if test="${vo.nowPage==pageNum }"></b></c:if>
					</li>
				</c:if>
				<c:if test="${pageNum>vo.totalPage}">
					<li style="visibility:hidden;">${pageNum}</li>
				</c:if>
			</c:forEach>
			<!-- 다음페이지 -->
			<c:if test="${vo.nowPage<vo.totalPage}">
				<li><a href="expense?nowPage=${vo.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
		</div>
	</div>
</div>
</body>
</html>