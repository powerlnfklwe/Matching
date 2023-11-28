<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/static/style/style.css" rel="stylesheet" type="text/css" />
 <link href="${path}/static/style/manager/managerSettlement.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
<!--페이지네이션-->
	$(function(){
		$(".paginate-button a").on("click", function(e){
			e.preventDefault();//페이지이동 무시 시킨다.
			$("#pageNum").val($(this).attr("href"));
			$("#actionForm").submit();
		});
	
		//웹에서 날짜 선택시 자동 제출	
		$("#search-date").on("change",function(){
			$("#search-form").submit();
		});
		
		//입금상태 체크시, 자동 제출
		$("#check-status").on("change",function(){
			$("#search-form").submit();	
		}); 
	});
</script>
</head>
<body>
	<div id="settlement-container">
		<h1>정산 내역</h1>
		<div class="search_wrap">
			<div class="search_area">
				<form id="search-form" action="/manager/settlement" method="get">
					<input id="search-word" type="text" name="keyword" placeholder="  검색어를 입력해주세요">
					<button id="submit-btn"type="submit">검색</button>
					<input id="search-date" type="date" name="datetime">
					<label id="sort-by"><span> 정렬기준 : 입금 완료</span><input id="check-status"type="checkbox" name="dStatusOrder"></label>
				</form>
			</div>
		</div>
		<div>
			<table class=settlement-sum>
				<tr>
					<th>정산완료금액</th>
					<td><fmt:formatNumber value="${completedamount }" maxFractionDigits="3"/> 원</td>
					<th>정산예정금액</th>
					<td><fmt:formatNumber value="${inprogressamount }" maxFractionDigits="3"/> 원</td>
				</tr>
			</table>
		</div>                  
		<div>
			<table class=settlement-table>
		    <thead>
				    <tr>
				    	<th>순번</th>
				      	<th>참여경기</th>
				     	 <th>경기날짜</th>
				     	 <th>입금상태</th>
				     	 <th>금액</th>
					</tr>
				</thead>
				<c:forEach var="settlement" items="${settlement }" varStatus="status">
					<tbody>
						    <tr>
						      <td id="td-num">${(pageMaker.mscriteria.pageNum-1) * pageMaker.mscriteria.amount + status.count }</td>
						      <td>${settlement.stadium }</td>
						      <td id="td-time"><fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${settlement.gametime }"/></td>
						      <td id="td-dstatus">
						      	<c:choose>
						      		<c:when test="${settlement.d_status == 0 }">처리중</c:when>
						      		<c:when test="${settlement.d_status == 1 }">입금완료</c:when>
						      	</c:choose>
						      </td>
						      <td id="td-amount"><fmt:formatNumber value="${settlement.amount }" maxFractionDigits="3"/> 원</td>
						    </tr>
				     </tbody>
			     </c:forEach>
		     </table>
		    </div>
			<!-- 페이지네이션 -->
			<div class="pagination-container">
				<ul class="pagination">
					<c:if test="${pageMaker.prev }">
						<!-- 이전 페이지 : 시작페이지가 1~10이 아닌 경우 보임 -->
						<li class="paginate-button previous"><a
							href="${pageMaker.startPage-1 }">Previous</a></li>
					</c:if>
		
					<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }" var="num">
						<li class="paginate-button ${pageMaker.mscriteria.pageNum == num ? 'active':''}"><a
							href="${num }">${num }</a></li>
					</c:forEach>
		
					<c:if test="${pageMaker.next }">
						<!-- 다음 페이지 : 끝페이지가 마지막 페이지가 아닌 경우 보임. 끝페이지의 다음페이지로 이동 -->
						<li class="paginate-button next"><a
							href="${pageMaker.endPage+1 }">Next</a></li>
					</c:if>
				</ul>
			</div>
		<!--end 페이지네이션 -->
	</div>
	 <!-- 페이지네이션 클릭시 페이지이동-->
	<form id="actionForm" action="/manager/settlement" method='get'>
		<!-- 클릭한 href에 들어있는 이동 페이지 번호로 바꿔준다 -->
		<input id="pageNum" type="hidden" name="pageNum" value="${pageMaker.mscriteria.pageNum }"> 
		<input type="hidden" name="amount" value="${pageMaker.mscriteria.amount }">
		<input type="hidden" name="keyword" value="${pageMaker.mscriteria.keyword }">
		<input type="hidden" name="datetime" value="${pageMaker.mscriteria.datetime }">
		<input type="hidden" name="dStatusOrder" value="${pageMaker.mscriteria.DStatusOrder}">
	</form> 
</body>
</html>