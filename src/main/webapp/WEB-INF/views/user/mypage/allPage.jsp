<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-mypage-all" >
	<!-- 왼쪽 메뉴바 -->
	<ul id="leftMenu">
		<li class=h>마이페이지</li>
		
		<!-- 여자, 남자에 따라 다른 사진 들어가게 -->
		<c:if test="${logGender=='여성' }">
			<li class=img>
				<img src="${path}/static/img/mypage/female.png"/><br/> 
				${logName}<span>님</span>
			</li>	
		</c:if>
		<c:if test="${logGender!='여성' }">
			<li class=img>
				<img src="${path}/static/img/mypage/male.png"/><br/>
				${logName}<span>님</span>
			</li> 
		</c:if>
		
		<!-- 탭 목록 -->		
		<div id="menuList" >
			<li><img src="${path}/static/img/mypage/calendar.png"/></li>
 			<li><a href="applyList" style="color:#484848">My 경기</a></li>
				<li><img src="${path}/static/img/mypage/prize.png"/></li>
			<li><a href="rank" style="color:#484848">My 랭크</a></li>
			<li><img src="${path}/static/img/mypage/align.png"/></li>
			<li><a href="paymentList" style="color:#484848">결제내역</a></li>
			<li><img src="${path}/static/img/mypage/info.png"/></li>
			<li><a href="info" style="color:#484848">내정보수정</a></li> <!-- mypage/${userid}/info  POST로 보내야해-->
		</div>
	</ul>