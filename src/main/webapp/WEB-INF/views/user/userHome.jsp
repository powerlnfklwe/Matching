<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
	// 스포츠 추천 팝업창
	
    // 쿠키 설정하기    
    function setCookie(name, value, expiredays) {
    	var today = new Date();
    	today.setDate(today.getDate() + expiredays);
    	document.cookie = name + '=' + value + ';path=/;expires=' + today.toGMTString() + ';'
    }

    // 팝업창 닫기
    function closePopup() {
        // '오늘 하루 보지 않기' 버튼이 클릭되어 있으면 쿠키 설정
    	if($(".close-today").hasClass("checked") === true){
            setCookie("popupClose","Y",1);
        }
        
        // 팝업창 숨기기
        $(".popup-recommend").hide();
    }
    
    function moveToRecommend() {
    	closePopup();
    	location.href='/recommend/mbti';
    }
  
    $(function(){    	
    	// '오늘 하루 보지 않기' 버튼 클릭시 checked 클래스 추가
    	$('.close-today').click(function(){
    		  $(this).toggleClass('checked');
    	});
    	
     	// 저장된 쿠키 가져오기
        var cookie = document.cookie;

        if (cookie.indexOf('popupClose=Y') < 0) { // 쿠키가 없으면
        	$(".popup-recommend").addClass("active");// 팝업창 띄우기
        } else {
        	$(".popup-recommend").removeClass("active");// 팝업창 숨기기
        }
        // 닫기 버튼 클릭하면 팝업창 닫기함수 호출
        $(".close").click(function(){
        	closePopup();
        });
    });
</script>

<div id="container" class="main-container">

	<%
		String logStatus = (String)session.getAttribute("logStatus");
		//System.out.println(logStatus);		
		pageContext.setAttribute("logStatus", logStatus);
	%>
	
	<!-- 로그인한 경우 -->
	<c:if test="${logStatus == 'Y'}">
		<img class="img" src="static/img/imgMain/football.jpg" alt="stadium"/>
		<div class="item" id="cloudy"> <!-- A -->
			<div class="login"> <!-- B -->
				<img src="/static/img/imgMain/quoteLeft.png" class="login-quote"/>
				<h3 class="userHomeH3"> ${logName }님 </h3>
				<p class="userHomeP">
				환영합니다!<br/>
				<!-- 경기를 시작해볼까요? -->
				</p>
				<img src="/static/img/imgMain/quoteRight.png" class="login-quote"/>
			</div>
		</div>
	</c:if> 	
	
	<!-- 로그인 하지 않은 경우 -->
	<c:if test="${logStatus != 'Y' }">
		<img class="img" src="static/img/imgMain/stadium.jpg" alt="football"/> 
		<div class="item" id="cloudy"> <!-- A -->
			<div class="login"> <!-- B -->
				<span>We Gather &emsp;</span><br/>
				<span>&emsp; Together </span><br/>
				<span id="featSpan">feat. sport</span><br/>
				<br/>
				<button class="button button--ujarak button--border-medium button--round-s button--text-upper" onclick="location.href='login'">회원</button>
	         	<button class="button button--ujarak button--border-medium button--round-s button--text-upper" onclick="location.href='loginMan'">매니저</button>
			</div>
		</div>
	</c:if>

	<div class="item" id="info">
		<div class="infoTxt">
			<span class="title">신청, 경기시작</span><br/>
			<span class="subTitle">We gather, Just do it!</span> 
			<div class="jb-division-line"></div>
			<div class="contents">
				인원모집 및 예약 서비스 <br/>
				랭크 시스템<br/>
				매니저 지원 서비스<br/>
				맞춤형 스포츠 추천
			</div>
			<div class="goToHome">
				<a href="/">WE GATHER 소개보기</a>
			</div>
		</div>
	</div>
	
	<div class="popup-recommend">
		<div class="title">나에게 맞는<br/><b>스포츠 추천</b> 결과가<br/>궁금하다면?</div>
		<ul class="hashtags">
			<li class="hashtag">#MBTI</li>
			<li class="hashtag">#성별</li>
			<li class="hashtag">#나이</li>
		</ul>
		<img src="${path}/static/img/imgMain/character.png" class="img-character" />
		<button class="move" onclick="moveToRecommend()">지금 확인하기</button>
		<div class="btns">
			<div class="close-today"><img src="${path}/static/img/imgMain/check.png" class="img-check" />오늘 하루 보지 않기</div>
			<div class="close">닫기</div>
		</div>
	</div>
	
</div>