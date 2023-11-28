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
		let address = "${rankGameDetail.location}";
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
	
	// 경기 요구랭크 충족 여부 확인
	function checkReqRank() {
		<c:if test="${userRank < rankGameDetail.req_rank}">
			return false
		</c:if>
		return true
	}
	
	// 랭크를 숫자에서 문자열로 변환
	function convertRankIntoStr(rank) {
		let convertedRank;
		switch (rank) {
			case 1:
			convertedRank="브론즈";
		    break;
			case 2:
			convertedRank="실버";
		    break;
			case 3:
			convertedRank="골드";
		    break;
			case 4:
			convertedRank="플래티넘";
		    break;
			case 5:
			convertedRank="다이아";
		    break;
		default:
			convertedRank="no Rank";
		}
		return convertedRank;
	}
	
	$(function(){
		$(".btn_apply_rank").click(function(){
			const isMeet = checkReqRank();
			let genderType = "${rankGameDetail.gendertype}";
			let logGender = "${logGender}";
			
			if(isMeet){// true
				if(genderType == "남녀모두") {
					location.href='/payment?gametype=rankgame&no=${rankGameDetail.no}'; // 결제페이지로 이동
				}
				
				if(genderType == "남자만") {
					if(logGender == "남성") {
						location.href='/payment?gametype=rankgame&no=${rankGameDetail.no}';
					}else {
						alert("남성만 신청할 수 있습니다.");
						return false;
					}
				}
				
				if(genderType == "여자만") {
					if(logGender == "여성") {
						location.href='/payment?gametype=rankgame&no=${rankGameDetail.no}';
					}else {
						alert("여성만 신청할 수 있습니다.");
						return false;
					}
				}
				
			} else {//false
				const logName = '<%=(String)session.getAttribute("logName")%>';
				alert("요구랭크를 충족하지 못했습니다. 해당 경기의 요구랭크는 '" + convertRankIntoStr(${rankGameDetail.req_rank})
						+ "'이고 현재 ${logName}님의 ${rankGameDetail.sportname} 랭크는 '" + convertRankIntoStr(${userRank}) + "'입니다.");
			}
		});
	});
	
</script>

<div class="game_header rank_game_header">
	<span class="game_header_title">랭크경기</span>
</div>
<div class="game_nav">종목선택 > 경기목록 > <b>경기상세정보</b></div>

<div class="game_container">
	<div class="game_detail_container">
	
		<!-- game_detail_wrap (left) -->
		<div class="game_detail_wrap left">
			<!-- 종목 이미지 -->
			<img src="${path}/uploadfile/sport/${rankGameDetail.filename}" class="sport_img"/>
			<ul>
				<!-- 경기 조건 -->
				<li class="game_condition">
					<img src="${path}/static/img/game/rank.png" class="icon" />
					<!-- 요구랭크 -->
					<span>
						<c:set var="rank" value="${rankGameDetail.req_rank}"/>
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
					<a href="/board/rankBoard" class="rank-info-wrap">
						<img src="${path}/static/img/game/info.png" class="icon-info" />
						<span class="rank-info">랭크 정보</span>
					</a>
				</li>
				
				<!-- 성별 유형 -->
				<li class="game_condition">
					<img src="${path}/static/img/game/gender.png" class="icon" />
					<span>${rankGameDetail.gendertype}</span>
				</li>
				
				<!-- 몇 대 몇 -->
				<!-- 한 팀당 인원수를 구하기 위해 min_people을 2로 나누고 정수로 변환한다. -->
				<fmt:parseNumber var="oneTeamNumber" integerOnly="true" value="${rankGameDetail.min_people/2}" />
				<li class="game_condition">
					<img src="${path}/static/img/game/vs.png" class="icon" />
					<span>${oneTeamNumber} vs ${oneTeamNumber}</span>
				</li>
				
				<!-- 몇 파전 -->
				<!-- 팀의 수를 구하기 위해 max_people을 한 팀당 인원수로 나누고 정수로 변환한다. -->
				<fmt:parseNumber var="teamCount" integerOnly="true" value="${rankGameDetail.max_people/oneTeamNumber}" />
				<li class="game_condition">
					<img src="${path}/static/img/game/running.png" class="icon" />
					<span>${teamCount}파전</span>
				</li>
			</ul>
		</div>
		<!-- game_detail_wrap (right) -->
		<div class="game_detail_wrap right">
			<!-- 경기 유형 -->
			<div class="game_type">랭크경기</div>
			
			<!-- 경기 상세 정보 -->
			<ul class="game_detail">
				<li class="game_detail_main">
					<div><fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${rankGameDetail.gametime}" /></div>
					<div>${rankGameDetail.stadium}</div>
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">이용시간 |</span>
					<span>${rankGameDetail.usetime}</span>				
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">종목 |</span>
					<span>${rankGameDetail.sportname}</span>				
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">매니저 |</span>
					<span>${rankGameDetail.m_name}</span>				
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">최소 충족인원 |</span>
					<span>${rankGameDetail.min_people}</span>명			
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">최대 인원 |</span>
					<span>${rankGameDetail.max_people}</span>명			
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">현재 신청인원 |</span>
					<span>${rankGameDetail.curr_people}</span>명
				</li>
				<li class="game_detail_sub">
					<span class="game_detail_label">참가비 |</span>
					<span><fmt:formatNumber value="${rankGameDetail.payment}" maxFractionDigits="3"/></span>원
				</li>
				
				<!-- 위치정보 -->
				<li class="game_detail_sub">
					<div class="location_info">위치정보</div>
					<span class="location">${rankGameDetail.location}</span>				
					<div id="map"></div>
				</li>
			</ul>
			
			<!-- 참가신청 -->
			<c:choose>
				<c:when test="${logStatus != 'Y'}">
					<button onclick="location.href='${path}/login'" class="btn_apply_rank_login">로그인</button>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${isPart == 1 }">
							<button class="btn_apply_rank_close">신청완료</button>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${rankGameDetail.curr_people >= rankGameDetail.max_people}">
	            					<button class="btn_apply_rank_close">인원마감</button>
								</c:when>
	         					<c:otherwise>
	            					<button class="btn_apply_rank">참가신청</button>
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
