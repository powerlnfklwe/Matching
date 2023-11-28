<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 구글맵api : =이하에 api키 넣으면 됨 -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb6MCfWC6EB6u8KU4V0hGt3xhuebQFKlE&callback=initMap"></script>



<script>
	let map;
	let geoCoder;
	
	// Google Maps API를 이용하여 구장위치를 지도에 표시하여 보여준다.
	function initMap() {					
		map = new google.maps.Map(document.getElementById('map'), {
			center: {lat:37.5729503 , lng: 126.9793578}, 
			zoom: 15,
		});
		
		geoCoder = new google.maps.Geocoder();
		codeAddress();
	}
	
	function codeAddress() {
		let address = "${normGameDetail.location}";
		geoCoder.geocode({'address': address}, function(results, status) {
			if(status == 'OK'){
				map.setCenter(results[0].geometry.location); // 구장위치로 map의 center를 변경
				
				// map에 마커 표시
				const marker = new google.maps.Marker({
					position: results[0].geometry.location,
					map
				});
			}
		})
	}
	
	$(function(){
		$(".btn_apply_norm").click(function(){
			let genderType = "${normGameDetail.gendertype}";
			let logGender = "${logGender}";
			
			if(genderType == "남녀모두") {
				location.href='/payment?gametype=normgame&no=${normGameDetail.no}';
			}
			
			if(genderType == "남자만") {
				if(logGender == "남성") {
					location.href='/payment?gametype=normgame&no=${normGameDetail.no}';
				}else {
					alert("남성만 신청할 수 있습니다.");
					return false;
				}
			}
			
			if(genderType == "여자만") {
				if(logGender == "여성") {
					location.href='/payment?gametype=normgame&no=${normGameDetail.no}';
				}else {
					alert("여성만 신청할 수 있습니다.");
					return false;
				}
			}
		});
	});
</script>

<div class="game_header norm_game_header">
	<span class="game_header_title">일반경기</span>
</div>
<div class="game_nav norm_game_nav">종목선택 > 경기목록 > <b>경기상세정보</b></div>

<div class="game_container">
	<div class="game_detail_container">
	
		<!-- game_detail_wrap (left) -->
		<div class="game_detail_wrap left">
			<!-- 종목 이미지 -->
			<img src="${path}/uploadfile/sport/${normGameDetail.filename}" class="sport_img"/>
			<ul>
				<!-- 성별 유형 -->
				<li class="game_condition">
					<img src="${path}/static/img/game/gender.png" />
					<span>${normGameDetail.gendertype}</span>
				</li>
				
				<!-- 몇 대 몇 -->
				<!-- 한 팀당 인원수를 구하기 위해 min_people을 2로 나누고 정수로 변환한다. -->
				<fmt:parseNumber var="oneTeamNumber" integerOnly="true" value="${normGameDetail.min_people/2}" />
				<li class="game_condition">
					<img src="${path}/static/img/game/vs.png" />
					<span>${oneTeamNumber} vs ${oneTeamNumber}</span>
				</li>
				
				<!-- 몇 파전 -->
				<!-- 팀의 수를 구하기 위해 max_people을 한 팀당 인원수로 나누고 정수로 변환한다. -->
				<fmt:parseNumber var="teamCount" integerOnly="true" value="${normGameDetail.max_people/oneTeamNumber}" />
				<li class="game_condition">
					<img src="${path}/static/img/game/running.png" />
					<span>${teamCount}파전</span>
				</li>
			</ul>
		</div>
		<!-- game_detail_wrap (right) -->
		<div class="game_detail_wrap right">
			<!-- 경기 유형 -->
			<div class="normgame_type">일반경기</div>
			
			<!-- 경기 상세 정보 -->
			<ul class="normgame_detail">
				<li class="game_detail_main">
					<div><fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${normGameDetail.gametime}" /></div>
					<div>${normGameDetail.stadium}</div>
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">이용시간 |</span>
					<span>${normGameDetail.usetime}</span>				
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">종목 |</span>
					<span>${normGameDetail.sportname}</span>				
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">최소 충족인원 |</span>
					<span>${normGameDetail.min_people}</span>명			
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">최대 인원 |</span>
					<span>${normGameDetail.max_people}</span>명			
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">현재 신청인원 |</span>
					<span>${normGameDetail.curr_people}</span>명
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">참가비 |</span>
					<span><fmt:formatNumber value="${normGameDetail.payment}" maxFractionDigits="3"/></span>원	
				</li>
				
				<!-- 위치정보 -->
				<li class="game_detail_sub">
					<div class="location_info">위치정보</div>
					<span class="location">${normGameDetail.location}</span>				
					<div id="map"></div>
				</li>
			</ul>
			
			<!-- 참가신청 -->
			<c:choose>
				<c:when test="${logStatus != 'Y'}">
					<button onclick="location.href='${path}/login'" class="btn_apply_norm_login">로그인</button>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${isPart == 1 }">
							<button class="btn_apply_norm_close">신청완료</button>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${normGameDetail.curr_people >= normGameDetail.max_people}">
	            					<button class="btn_apply_norm_close">인원마감</button>
								</c:when>
	         					<c:otherwise>
	            					<button class="btn_apply_norm">참가신청</button>
	            				</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
	         	</c:otherwise>
	      	</c:choose>
	      	<!-- <button onclick="history.back()" class="btn_back" >뒤로가기</button> -->
		</div>
	</div>
</div>
