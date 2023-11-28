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
		
		if($('.gamenew_info').length > 0) {
			  $('.gamenew_guide').remove();
			}
		
		$("#region").change(function(){
			if($(this).val() == "서울"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'서울\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}
			
			if($(this).val() == "경기"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'경기\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}
			
			if($(this).val() == "대구"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'대구\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "경북"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'경북\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "광주"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'광주\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "전라"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'전라\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "제주"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'제주\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "부산"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'부산\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "울산"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'울산\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "경남"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'경남\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}
			
			if($(this).val() == "대전"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'대전\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}
			
			if($(this).val() == "세종"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'세종\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "충청"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'충청\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}

			if($(this).val() == "강원"){
				$(".select.stadium").remove();
				$(".select.region").after('<li class="select stadium">구장선택 : <select name="st_no" id="stadium"><c:forEach var="newDTO" items="${stadiumList}">'+
						'<c:if test="${newDTO.s_no == sportDTO.s_no }">'+
						'<c:if test="${newDTO.region == \'강원\'}"><option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>'+
						'</c:if></c:if></c:forEach></select></li>');
			}
		});
		
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
			
			<!-- 지역과 구장 선택 -->
			<form method="get" action="new">
				<input type="hidden" name="s_no" value="${sportDTO.s_no}"/>
				<ul class="norm_game_new_select">
					<li class = "select sport">
						스포츠 종목 : ${sportDTO.sportname}
					</li>
					<li class ="select region">
						지역선택 : <select name="region" id="region">
										<option value="서울" <c:if test="${stadiumDTO.region eq '서울'}">selected</c:if>>서울</option>
										<option value="경기" <c:if test="${stadiumDTO.region eq '경기'}">selected</c:if>>경기</option>
										<option value="대구" <c:if test="${stadiumDTO.region eq '대구'}">selected</c:if>>대구</option>
										<option value="경북" <c:if test="${stadiumDTO.region eq '경북'}">selected</c:if>>경북</option>
										<option value="광주" <c:if test="${stadiumDTO.region eq '광주'}">selected</c:if>>광주</option>
										<option value="전라" <c:if test="${stadiumDTO.region eq '전라'}">selected</c:if>>전라</option>
										<option value="제주" <c:if test="${stadiumDTO.region eq '제주'}">selected</c:if>>제주</option>
										<option value="부산" <c:if test="${stadiumDTO.region eq '부산'}">selected</c:if>>부산</option>
										<option value="울산" <c:if test="${stadiumDTO.region eq '울산'}">selected</c:if>>울산</option>
										<option value="경남" <c:if test="${stadiumDTO.region eq '경남'}">selected</c:if>>경남</option>
										<option value="대전" <c:if test="${stadiumDTO.region eq '대전'}">selected</c:if>>대전</option>
										<option value="세종" <c:if test="${stadiumDTO.region eq '세종'}">selected</c:if>>세종</option>
										<option value="충청" <c:if test="${stadiumDTO.region eq '충청'}">selected</c:if>>충청</option>
										<option value="강원" <c:if test="${stadiumDTO.region eq '강원'}">selected</c:if>>강원</option>
									</select>
					</li>
					<li class="select stadium">
						구장선택 : <select name="st_no" id="stadium">
										<c:forEach var="newDTO" items="${stadiumList}">
											<c:if test="${newDTO.s_no == sportDTO.s_no }">
												<c:if test="${newDTO.region eq stadiumDTO.region}">
													<option value="${newDTO.st_no}" <c:if test="${newDTO.st_no == stadiumDTO.st_no}">selected</c:if>>${newDTO.stadium}</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
					</li>
					<li class="select caution">
						※ 스포츠 종목과 구장이 일치하여야<br/>예약 가능합니다.
					</li>
					<li class="select">
						<input type="submit" value="적용" id="btn-filter"/>
					</li>
				</ul>
			</form>
		</div>
		<!-- game_detail_wrap (right) -->
		<div class="game_detail_wrap right">
			<!-- 경기 유형 -->
			<div class="normgame_type">일반경기</div>
			
			<!-- 경기 상세 정보 -->
			<ul class="normgame_detail">
				<li class="gamenew_guide">
					지역과 경기장을 선택하여 주세요.
				</li>
				<c:forEach var="gameDTO" items="${newNormGameList}" varStatus="status">
					<c:if test="${gameDTO.s_no == sportDTO.s_no }">
						<li class="gamenew_info">
							<a href="newdetail?no=${gameDTO.no}&s_no=${sportDTO.s_no}"><span class="gamenew_detail_main">${status.count}. 시작시간 (<fmt:formatDate pattern="yy년 MM월 dd일 E요일 HH:mm" value="${gameDTO.gametime}" />)</span></a><br/>
							<span class="gamenew_detail_sub">이용시간 (${gameDTO.usetime}) | 결제금액 (<fmt:formatNumber value="${gameDTO.payment}" maxFractionDigits="3"/>원)</span>
						</li>
						
					</c:if>
				</c:forEach>
				
				<!-- 위치정보 -->
				<li class="game_detail_sub">
					<div class="location_info">위치정보</div>
					<c:if test="${newNormGameList[0].location != null && newNormGameList[0].location ne ''}">
						<c:if test="${newNormGameList[0].s_no == sportDTO.s_no }">
							<span class="location">${newNormGameList[0].location}</span>				
							<div id="map"></div>
						</c:if>
					</c:if>
				</li>
			</ul>
		</div>
	</div>
</div>
