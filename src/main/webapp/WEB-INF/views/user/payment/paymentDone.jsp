<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div id="payment_Done_container">
	<h2 class="payment_title">결제가 완료되었습니다.</h2>
	<h3 class="payment_notice">결제내역은 <span>마이페이지 > <a id="payment_notice_link" href="${path}/mypage/paymentList">결제내역</a></span>에서<br/> 확인하실 수 있습니다.</h3>
	<table>
        <tr>
            <th>경기유형</th>
            <th>경기종목</th>
            <th>경기일정</th>
            <th>경기장소</th>
            <th>결제금액</th>
        </tr>
        <tr>
            <td>
            	<c:choose>
					<c:when test="${gametype eq 'rankgame'}">
		            	랭크경기
					</c:when>
		         	<c:when test="${gametype eq 'normgame'}">
		            	일반경기
		         	</c:when>
		      	</c:choose>
            </td>
            <td>${payDoneInfo.sportname}</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd (E) HH:mm" value="${payDoneInfo.gametime}" /></td>
            <td>${payDoneInfo.stadium}</td>
            <td>${payDoneInfo.payment}</td>
        </tr>
	</table>
</div>