<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
	<h2 id="page-title">수입 내역</h2>
	<div id="revenue_container">
		<table>
			<tr class="revenue">
				<th id="">번호</th>
				<th id="paid_amount">금액</th>
				<th id="">수입목록</th>
				<th id="payer_name">입금자</th>
				<th id="payment_no">결제번호</th>
				<th id="paid_at">결제일</th>
			</tr>
			<c:forEach var="user_pay" items="${pay}" varStatus="status">
				<tr>
					<td>${(vo.nowPage-1)*(vo.onePageRecord)+ status.count}</td>
					<td><fmt:formatNumber value="${user_pay.paid_amount}" maxFractionDigits="3"/>원</td>
					<td>경기 참여</td>
					<td>${user_pay.payer_name}</td>
					<td>${user_pay.payment_no}</td>
					
					<!---- unix타입스탬프 -> 2023-04-12형태로 변환하기 ----->
			    	<c:set var="paidTime" value="${user_pay.paid_at}" />
					<%
					Long ptLong = (Long)pageContext.getAttribute("paidTime");
					Date ptDate = new Date(ptLong*1000);
					pageContext.setAttribute("ptDate", ptDate );

					%>
					<!-- 자바에서 받은 date타입 값을 fmt이용하여 2023-04-12형태로 변환 -->
			    	<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${ptDate}"/></td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 페이징 -->
		<div class="pagingDiv">
		<ul>
			<!-- 이전페이지 -->
			<c:if test="${vo.nowPage>1}">
				<li><a href="revenue?nowPage=${vo.nowPage-1}">이전</a></li>
			</c:if>
			<!-- 페이지번호 -->
			<c:forEach var="pageNum" begin="${vo.startPageNum}" end="${vo.startPageNum+(vo.onePageNumCount-1)}" step="1">
				<c:if test="${pageNum<=vo.totalPage}">
					<li>
					<c:if test="${vo.nowPage==pageNum }"><b></c:if>
					<a href="revenue?nowPage=${pageNum}">${pageNum}</a>
					<c:if test="${vo.nowPage==pageNum }"></b></c:if>
					</li>
				</c:if>
				<c:if test="${pageNum>vo.totalPage}">
					<li style="visibility:hidden;">${pageNum}</li>
				</c:if>
			</c:forEach>
			<!-- 다음페이지 -->
			<c:if test="${vo.nowPage<vo.totalPage}">
				<li><a href="revenue?nowPage=${vo.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
		</div>
	</div>
</div>
</body>
</html>