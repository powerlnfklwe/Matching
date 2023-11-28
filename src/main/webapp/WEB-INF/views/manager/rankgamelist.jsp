<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>We Gather, Just do it</title>
    <link href="${path}/static/style/style.css" rel="stylesheet" type="text/css" />
    <link href="${path}/static/style/manager/managerRankgamelist.css" rel="stylesheet" type="text/css" />
    <script defer type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <!-- Google api -->
    <link href="https://code.google.com/apis/maps/documentation/javascript/examples/default.css" rel="stylesheet" type="text/css" /> 
    <!-- 18행 src안의 key= 뒤에 구글맵 key값 입력하시면 됩니다! -->
	<script defer type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb6MCfWC6EB6u8KU4V0hGt3xhuebQFKlE"></script>
    <!-- //Google api -->
</head>
<body>
    <!-- 랭크 경기 목록 -->
    <div id="rank-container">
        <h1>랭크 경기 목록</h1>
        <div class="filter-wrap">
	        <div class="rank-caption">현재 참여 가능한 경기 수 : ${pageMaker.total } 경기</div>
	        <div class="filter-container">
	        	<select id="region-filter">
	        		<option value="">모든 지역</option>
	        		<option value="서울">서울</option>
	        		<option value="경기">경기</option>
	        		<option value="인천">인천</option>
	        		<option value="강원">강원</option>
	        		<option value="대전">대전</option>
	        		<option value="세종">세종</option>
	        		<option value="충청">충청</option>
	        		<option value="대구">대구</option>
	        		<option value="부산">부산</option>
	        		<option value="울산">울산</option>
	        		<option value="경남">경남</option>
	        		<option value="광주">광주</option>
	        		<option value="전라">전라</option>
	        		<option value="제주">제주</option>
	        	</select>
	        </div>
        </div>
        <div class="rank-wrap">
            <!-- 비주얼 이미지 -->
            <div class="rank-visual" style="background-image: url('${path}/static/img/manager/${sessionScope.logS_no}.jpg');">
                <%-- <img src="${path}/static/img/manager/${sessionScope.logS_no}.jpg" alt="메인 비주얼"> --%>
            </div>
            <!-- 랭크 리스트 -->
            <div class="rank-list">
                <ul>
                	<c:forEach var="rankgame" items="${gamelist }">
                    <li class="rank-item" data-region="${rankgame.region }">
                        <strong>${rankgame.sportname} (${rankgame.region })</strong>
                        <p><fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${rankgame.gametime }"/><br/>${rankgame.stadium}</p>
                        <span>매니저 수당 : <fmt:formatNumber value="${rankgame.managerfee}" maxFractionDigits="3"/> 원</span>
                        <div class="rank-item-btn">
                            <button type="button" class="btn-location" data-location="${rankgame.location}">위치보기</button>
                            <button type="button" class="btn-apply" data-sportname=
                            	"${rankgame.sportname}" data-region="${rankgame.region}" data-gametime="<fmt:formatDate pattern='yyyy년 MM월 dd일 E요일 HH:mm' value='${rankgame.gametime }'/>" 
                            	data-stadium="${rankgame.stadium}" data-managerfee="${rankgame.managerfee}" data-no="${rankgame.no}"
                            >신청하기</button>
                        </div>
                    </li>
                    </c:forEach>
                </ul>
                  <!-- 페이지네이션 -->
                  	<div class="pagination-container">
                    	<ul class="pagination">
                    		<c:if test="${pageMaker.prev }">
                    			<!-- 이전 페이지 : 시작페이지가 1~10이 아닌 경우 보임 -->
                    			<li class="paginate-button previous"><a href="${pageMaker.startPage-1 }">Previous</a></li>
                    		</c:if>
	
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
                    			<li class="paginate-button ${pageMaker.criteria.pageNum == num ? 'active':''}"><a href="${num }">${num }</a></li>
							</c:forEach>
                    		
                    		<c:if test="${pageMaker.next }">
                    			<!-- 다음 페이지 : 끝페이지가 마지막 페이지가 아닌 경우 보임. 끝페이지의 다음페이지로 이동 -->
                    			<li class="paginate-button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
                    		</c:if>
                    	</ul>
                    </div>
                    <!--end 페이지네이션 -->
            </div>
        </div>
    </div>
    <!-- 페이지네이션 클릭시 페이지이동 -->
	<form id="actionForm" action="/manager/rankgamelist" method='get'>
		<!-- 클릭한 href에 들어있는 이동 페이지 번호로 바꿔준다 -->
		<input id="pageNum" type="hidden" name="pageNum" value="${pageMaker.criteria.pageNum }"> 
		<input type="hidden" name="amount" value="${pageMaker.criteria.amount }"> 
	</form> 	
	
    <!-- 신청하기 모달 -->
    <div id="rank-dim" style="display:none;">
        <div class="rank-apply-popup">
            <button class="btn-popup-close">닫기</button>
            <div class="apply-info">
                <strong class="sportname"></strong>
                <p class="gametime"></p>
                <div class="stadium"></div>
                <span class="managerfee"></span>
            </div>
            <em>위 경기에 참여 신청하시겠습니까?</em>
            <div class="apply-btn">
                <button class="btn-apply-cancel">취소</button>
                <button id="btn-apply" class="btn-apply-go">신청</button>
            </div>
        </div>
    </div>
    
    <!-- Google 지도 모달 -->
    <div id="rank-map-dim" style="display:none;">
    	<div id="map-canvas" class="rank-map-popup"></div>
    </div>
    
</body>
<script>
	<!--페이지네이션-->
	$(function(){
		
		$(".paginate-button a").on("click", function(e){
			e.preventDefault();//페이지이동 무시 시킨다.
			$("#pageNum").val($(this).attr("href"));
			$("#actionForm").submit();
		});
	});
	
	<!--신청하기 모달-->
	document.querySelectorAll('.btn-apply').forEach(button => {
		  button.addEventListener('click', () => {
		    // 해당 버튼의 데이터 속성값들을 가져옴
		   	const no = button.dataset.no;
		    const sportname = button.dataset.sportname;
		    const region = button.dataset.region;
		    const gametime = button.dataset.gametime;
		    const stadium = button.dataset.stadium;
		    const managerfee = button.dataset.managerfee;
	
		    // 모달창의 각 요소에 데이터를 삽입
		    const modal = document.querySelector('#rank-dim');
		    modal.querySelector('.sportname').textContent = sportname;
		    modal.querySelector('.gametime').textContent = gametime;
		    modal.querySelector('.stadium').textContent = stadium;
		    modal.querySelector('.managerfee').textContent = "매니저 수당 : " + Number(managerfee).toLocaleString()+"원";
		    modal.querySelector('button#btn-apply').dataset.no = no;
		    modal.querySelector('button#btn-apply').dataset.managerfee = managerfee;
	       
		   
		    // 모달창을 보이도록 설정
		    modal.style.display = 'block';
		  });
		});
	
	var map
		, marker;
		
	// jquery load
	$(document).ready(function() {
		mainCtrl.init();
	});
	
	var mainCtrl = {
		// js init
		init : () => {
			mainCtrl.evtHandler();
		},
		// 이벤트 핸들러
		evtHandler : () => {
			// 신청하기 팝업 event Handler
			$(document).on('click', '#btn-apply', function(e) { mainCtrl.apply(e); });
			// 위치보기 모달 show event Handler
			$(document).on('click', 'button.btn-location', function() { mainCtrl.codeAddress(this.dataset.location); });
			// 위치보기 모달 hide event Handler
			$(document).on('click', 'div#rank-map-dim', function() { $(this).hide(); });
			//신청하기 모달 취소버튼 클릭시, 팝업닫기
			$('.btn-popup-close, .btn-apply-cancel').click(function(){ $('#rank-dim').hide(); }); 
		},
		// 신청하기 ajax
		apply : (e) => {
			const params = {
				'managerid' : '<%=session.getAttribute("logid")%>'
				, 'no' : e.target.dataset.no
				, 'managerfee' : e.target.dataset.managerfee
			}
			
			$.ajax({
				type : "POST",
				url : "/manager/apply", //요청 할 URL
				data : params, //넘길 파라미터
				dataType : "json",
				success : function(data) {
					//신청이 되었을때 실행 할 내용
					if(data) {
						alert('신청되었습니다.');
						$('#rank-dim').hide();
						console.log(data);
						window.location.reload();//신청 후 페이지 새로고침
					}
				},
				error : function(data) {
					console.log(data);
					alert("신청되었습니다."); //500뜨는데 해결하기전에 그냥 꼼수
					$('#rank-dim').hide();//모달숨기기
					window.location.reload();//새로고침
				}
			});
		},
		// 구글 지오코드 호출 후 맵에 좌표 데이터 바인딩
		codeAddress : (address) => {
			var geocoder = new google.maps.Geocoder();
			geocoder.geocode( {'address':address}, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					var latlng = results[0].geometry.location;
					var mapOptions = {
					  zoom: 16,			// 확대 : 0~19
					  center: latlng	// 좌표
					};
					map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
			    	var marker = new google.maps.Marker({ map: map, position: results[0].geometry.location });		// 지도 마킹
				} else {
					alert('오류가 난 이유는 다음과 같습니다: ' + status);
			 	}
			});
			$('#rank-map-dim').show();	// 모달 호출
		}
	}
	//지역 필터링
	$(document).ready(function() {
		  $("#region-filter").on("change", function() {
		    var selectedRegion = $(this).val();
		    if (selectedRegion === "") {
		      $(".rank-item").show();
		    } else {
		      $(".rank-item").hide();
		      $(".rank-item[data-region='" + selectedRegion + "']").show();
		    }
		  });
		});
	
</script>
</html>