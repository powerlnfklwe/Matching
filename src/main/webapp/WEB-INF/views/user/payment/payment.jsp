<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- iamport 결제 API -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
	const no = ${gameDetail.no};
	const gametype = "${gametype}";
	
	$(document).ready(function(){ 
		if(gametype=="rankgame") {
			$('.btn-pay').addClass('rank');
			$('.total_amount').addClass('rank');
			$('.payment_section').addClass('rank');
		} else if(gametype=='normgame') {	
			$('.btn-pay').addClass('normal');
			$('.total_amount').addClass('normal');
			$('.payment_section').addClass('normal');
		}
  	});

	// 결제 구현
	var IMP = window.IMP;
	IMP.init("imp57122251"); // 예: "imp00000000a"
	
	function requestPay() {
	    IMP.request_pay({
	      pg: "html5_inicis",
	      pay_method: "card",
	      merchant_uid: "game_"+new Date().getTime(),
	      name: "WeGather_경기참여",
	      amount: ${gameDetail.payment},
	      buyer_email: "${participantInfo.email}",
	      buyer_name: "${participantInfo.username}",
	      buyer_tel: "${participantInfo.tel}",
	      buyer_addr: "${participantInfo.address}",
	    }, function (rsp) {
	      if (rsp.success) {
	    	  // 결제 성공 시
	    	  $.ajax({
	    		  type:'POST',
	    		  url:'/paymentOk',
	    		  dataType: 'json',
	    		  data: {
	    			  no: no,
	    			  gametype: gametype,
	    			  payment_no: rsp.merchant_uid,
	    			  payer_name: rsp.buyer_name,
		    		  paid_amount: rsp.paid_amount,
		    		  paid_at: rsp.paid_at,
		    		  success: rsp.success
	    		  },
	    		  success:function(data){
	    			  // 결제완료 페이지로 이동
	    			  location.href = "/payment/paymentDone?payment_no=" + data.payment_no + "&gametype=" + data.gametype;
	    		  },error:function(e){
	    		  	  console.log(e.responseText);
	    		  }
	    	  })
	      } else {
	    	  // 결제 실패 시
	    	  var msg = '결제에 실패하였습니다. ';
	          msg += '에러내용: ' + rsp.error_msg;
	          alert(msg);
	      }
	    });
	  }
</script>
<div id="payment_container">
	<h2 class="payment_title">결제하기</h2>
	<div class="payment_info_wrap">

		<!-- 경기 정보 -->
		<ul class="payment_section left">
			<li class="title">경기 정보</li>
			<li class="payment_info">
				<span class="payment_label">경기유형</span>
				<span>
					<c:choose>
						<c:when test="${gametype eq 'rankgame'}">
			            	랭크경기
						</c:when>
			         	<c:when test="${gametype eq 'normgame'}">
			            	일반경기
			         	</c:when>
			      	</c:choose>
				</span>
			</li>
			<li class="payment_info">
				<span class="payment_label">경기종목</span>
				<span>${gameDetail.sportname}</span>
			</li>
			<c:if test="${gametype eq 'rankgame'}">
				<li class="payment_info">
					<span class="payment_label">매니저</span>
					<span>${gameDetail.m_name}</span>
				</li>				
			</c:if>
			<li class="payment_info">
				<span class="payment_label">성별유형</span>
				<span>${gameDetail.gendertype}</span>
			</li>
			<c:if test="${gametype eq 'rankgame'}">
				<li class="payment_info">
					<span class="payment_label">요구랭크</span>
					<span>
						<c:set var="rank" value="${gameDetail.req_rank}"/>
						<c:choose>
							<c:when test="${rank==1}">
				            	브론즈이상
							</c:when>
				         	<c:when test="${rank==2}">
				            	실버이상
				         	</c:when>
				         	<c:when test="${rank==3}">
				            	골드이상
							</c:when>
				         	<c:when test="${rank==4}">
				            	플래티넘이상
				         	</c:when>
				         	<c:when test="${rank==5}">
				            	다이아이상
							</c:when>
				         	<c:otherwise>
				            	모든랭크
				         	</c:otherwise>
				      	</c:choose>
			      	</span>
				</li>
			</c:if>
			<li class="payment_info">
				<span class="payment_label">경기일정</span>
				<span><fmt:formatDate pattern="yyyy-MM-dd (E) HH:mm" value="${gameDetail.gametime}" /></span>
			</li>
			<li class="payment_info">
				<span class="payment_label">경기장소</span>
				<span>${gameDetail.stadium}</span><br/>
				<span class="stadium_location">(${gameDetail.location})</span>
			</li>
		</ul>
		<div>
			<!-- 참가자 정보 -->
			<ul class="payment_section right">
				<li class="title">참가자 정보</li>
				<li class="payment_info">
					<span class="payment_label">이름</span>
					<span>${participantInfo.username}</span>
				</li>
				<li class="payment_info">
					<span class="payment_label">연락처</span>
					<span>${participantInfo.tel}</span>
				</li>
				<li class="payment_info">
					<span class="payment_label">이메일</span>
					<span>${participantInfo.email}</span>
				</li>
				<li><button class="btn_modify" onclick="location.href='/mypage/info'">수정</button></li>
			</ul>
			
			<!-- 결제 상세 -->
			<ul class="payment_section right">
				<li class="title">결제 상세</li>
				<li class="payment_info">
					<span class="payment_label">경기 참가비</span>
					<span class="amount"><fmt:formatNumber value="${gameDetail.payment}" maxFractionDigits="3"/>원</span>
				</li>
				<li class="payment_info total_amount">
					<span class="payment_label">총 결제금액</span>
					<span class="amount total_amount"><fmt:formatNumber value="${gameDetail.payment}" maxFractionDigits="3"/>원</span>
				</li>
			</ul>
			
			<!-- 결제하기 버튼 -->
			<button onclick="requestPay()" class="btn-pay">결제하기</button>
		</div>
	</div>
</div>