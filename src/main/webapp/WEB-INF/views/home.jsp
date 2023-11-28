<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>We Gather, Just do it</title>
<link rel="stylesheet" href="${path}/static/style/style.css" type="text/css"/>
<link rel="stylesheet" href="${path}/static/style/user/main.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function(){
		//top으로 이동 
		$("#top").click(function(){
		    var htmloffset = $('html').offset();
		    $('html, body').animate( { scrollTop : 0 }, 400 );
		    return false;
		}); 
	});
	
</script>
</head>
<body>
<section id="container" class="section-main"> 
	<!-- <div class="rank-visual" > -->
	
	<img class="img" src="static/img/imgMain/stadium.jpg" alt="stadium"/> 
	
	<div class="item" id="cloudy"> <!-- A -->
		<div class="login"> <!-- B -->
			<span class="WG">We Gather &emsp;</span><br/>
			<span class="T">&emsp; Together </span><br/>
			<span id="featSpan">feat. sport</span><br/> 
			<br/>
			<button class="button button--ujarak button--border-medium button--round-s button--text-upper" onclick="location.href='/userHome'">시작하기</button>
		</div>
	</div>
</section>

<!-- 사이트 소개 -->
<section id="section-info">
	<div class="section-content">
		<div class="info-img"></div>
		<div class="info">
			<div>
				<div class="section-title">
					<img src="/static/img/imgMain/quoteLeft.png" style="width:50px; height:50px;"/>
					&emsp;&emsp; WE GATHER, JUST DO IT &emsp;&emsp;
					<img src="/static/img/imgMain/quoteRight.png" style="width:50px; height:50px;"/>
				</div>
				<div class="info-title-wrap">
					<span class="title">경기신청 버튼하나로 끝</span>
					<span class="desc">오직 경기신청만! 나머지는 wegather가 준비합니다.</span>
				</div>
			</div>
			
			<div class="info-items">
				<div class="item-wrap left">
					<div class="info-item">
						<span class="title">인원모집 및 장소예약</span>
						<span class="desc">원하는 시간, 장소만 선택하세요.<br/>
											wegather에서 플레이어를 모으고<br/>
											경기장을 준비합니다. 
											 </span>
					</div>
					<div class="info-item">
						<span class="title">매니저 지원 서비스</span>
						<span class="desc">체계적인 시스템으로 경기를 매끄럽게 진행합니다.<br/>
											KFA, KBSA 등 협회에 등록된<br/>
											검증된 매니저가 함께 합니다.<br/>
											 </span>
					</div>
				</div>
				<div class="item-wrap right">
					<div class="info-item">
						<span class="title">랭크 시스템에 따른 팀 배정</span>
						<span class="desc">매니저가 실력에 맞게 팀을 나눠<br/>
											팽팽한 경기가 진행됩니다.<br/>
											긴장감 넘치는 경기를 즐겨보세요.</span>
					</div>
					<div class="info-item">
						<span class="title">맞춤형 스포츠 추천</span>
						<span class="desc">아직 즐기는 스포츠가 없는 당신을 위해!<br/>
											나에게 맞는 스포츠를 추천받아보세요.</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 경기 소개 -->
<section id="section-game">
	<img src="static/img/imgMain/trophy.jpg" class="game-img" />
	<div class="game-wrap">
		<div class="game rank">
			<span class="title">
				<!-- <img src="/static/img/imgMain/arrowLeft.png" style="width:50px; height:50px;"/> -->
				랭크경기
			</span>
			<span class="desc">
			나는 아마추어 중에서 실력이 어느 정도일까?<br/>
			랭크 경기는 매니저 주관 하에 사용자 퍼포먼스에 맞춰<br/>
			랭크가 매겨지는 경기입니다.<br/>
			게임 후 나의 랭킹과 순위를 확인해보세요!
			</span>
			<p class="manager_desc">
			※ 매니저란?<br/>
			참가자들이 즐겁게 운동할 수 있도록 경기 운영을 담당합니다.<br/>
			경기 후에는 경기 내용을 바탕으로 참가자들에게 랭크를 부여합니다.
			</p>
			<a class="home_alink rank" href="${path}/rankgame/sportlist">랭크경기 둘러보기</a>
		</div>
		<div class="game norm">
			<span class="title">
				일반경기
				<!-- <img src="/static/img/imgMain/arrowRight.png" style="width:50px; height:50px;"/> -->
			</span>
			<span class="desc">
			랭크 경기 말고 자유롭게 스포츠를 즐기고 싶다면?<br/>
			일반 경기는 매니저 없이 사용자가 <br/>
			자유롭게 진행, 참여하는 경기입니다.<br/>
			원하는 시간, 장소에 원하는 사람들과 경기를 즐기세요!
			</span>
			<a class="home_alink norm" href="${path}/normgame/sportlist">일반경기 둘러보기</a>
		</div>
	</div>
	<img src="static/img/imgMain/norm.jpg" class="game-img" />
</section>

<!-- 스포츠추천, 랭크보드 -->
<section id="section-others">
	<div class="item-wrap">
		<img src="static/img/imgMain/ranking.jpg" class="item-img" />
		<div class="item">
			<span class="title">랭크보드</span>
			<span class="desc">
			나의 실력은 어느 정도일까?<br/>
			랭크보드는 랭크 경기를 참여한 사용자들의 평점과 랭크에 맞춰 순위를 나타냅니다.<br/>
			평점과 랭크는 누적된 평균 랭크 점수에 따라 부여됩니다.<br/>
			나의 순위와 랭크를 확인하고 다른 사용자들과 비교해보세요!<br/>
			</span>
			<a class="home_alink" href="${path}/user/rankBoard/rankBoard">랭크보드 둘러보기</a>
		</div>
	</div>
	<div class="item-wrap">
		<div class="item">
			<span class="title">스포츠추천</span>
			<span class="desc">
			나의 MBTI, 나이, 성별에 맞는 스포츠는 뭐가 있을까?<br/>
			MBTI, 나이, 성별 별로 사용자들이 참여하는 스포츠를 통계로 나타냅니다.<br/>
			나와 비슷한 사용자들이 좋아하는 스포츠를 확인하고 새로운 스포츠를 즐겨보세요!
			</span>
			<a class="home_alink" href="${path}/recommend/mbti">스포츠추천 둘러보기</a>
		</div>
		<img src="static/img/imgMain/stretch.jpg" class="item-img" />
	</div>
</section>
<a id="top" class="home-top" title="top">TOP</a>	
</body>
</html>	