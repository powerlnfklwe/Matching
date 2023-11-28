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
		let address = "${newNormGameList[0].location}";
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
		$(".btn_back").click(function(){
			event.preventDefault();
			
			location.href="${path}/normgame/new?s_no=${sportDTO.s_no}";
		})
	});
	
</script>

<div class="game_header norm_game_header">
	<span class="game_header_title">일반경기</span>
</div>
<div class="game_nav norm_game_nav">종목선택 > 경기목록 > <b>경기개설</b></div>

<div class="game_container">
	<div class="game_detail_container">
	
		<!-- game_detail_wrap (left) -->
		<div class="game_new_wrap left">
			<!-- 종목 이미지 -->
			<img src="${path}/uploadfile/sport/${sportDTO.filename}" class="sport_img"/>
				<ul class="norm_game_new_select">
					<li class ="select sport">
						스포츠 종목 : ${sportDTO.sportname}
					</li>
					<li class="select desc">
						[시작시간]<br/>
						<fmt:formatDate pattern="yy년 MM월 dd일 E요일 HH:mm" value="${normGameDTO.gametime}" />
					</li>
					<li class="select desc">
						[이용시간]<br/>
						${normGameDTO.usetime}
					</li>
					<li class="select desc">
						[결제금액]<br/>
						<fmt:formatNumber value="${normGameDTO.payment}" maxFractionDigits="3"/>원
					</li>
				</ul>
		</div>
		
		<!-- game_detail_wrap (right) -->
		<div class="game_detail_wrap right">
			<form method="post" action="newdetailOk">
				<input type="hidden" name="no" value="${normGameDTO.no}"/>
				<input type="hidden" name="s_no" value="${sportDTO.s_no}"/>
				<!-- 경기 유형 -->
				<div class="normgame_type">일반경기</div>
				
				<!-- 경기 상세 정보 입력 -->
				<ul class="normgame_detail">
						<li class="gamenew_write">
							<span class="gamenew_detail_main">경기충족인원</span> : 
							<span class="gamenew_detail_sub"><input type="text" name="min_people" id="min_people"/> 명</span>
						</li>
						<li class="gamenew_write">
							<span class="gamenew_detail_main">경기최대인원</span> : 
							<span class="gamenew_detail_sub"><input type="text" name="max_people" id="max_people"/> 명</span>
						</li>
						<li class="gamenew_write">
							<span class="gamenew_detail_main">성별유형</span> : 
							<span class="gamenew_detail_sub"><select name="gendertype" id="gendertype">
								<option value="남녀모두">남녀모두</option>
								<option value="남자만">남자만</option>
								<option value="여자만">여자만</option>
								</select>
							</span>
						</li>
					<!-- 위치정보 -->
					<li class="game_detail_sub">
						<div class="location_info">위치정보</div>
						<span class="location">${normGameDTO.location}</span>				
						<div id="map"></div>
					</li>
				</ul>
				
				<c:if test="${logStatus == 'Y' }">
					<input type="submit" value="경기개설" class="btn_apply_norm"/>
				</c:if>
				<!-- <button class="btn_back" >뒤로가기</button> -->
			</form>
		</div>
	</div>
</div>
