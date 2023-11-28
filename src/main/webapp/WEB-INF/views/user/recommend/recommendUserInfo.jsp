<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script>
	$(function(){
		var logId = '<%=(String)session.getAttribute("logId")%>';

        if(logId=="null"){ 
        	// 비로그인
        	$(".recommend_user_info.non_login").addClass("active");
        } else {
        	// 로그인
        	$(".recommend_user_info.login").addClass("active");
        }

        /* pie chart - 남성 */
    	var colorList = ['#9480B3', '#D189A8', '#F68EA1', '#FBAD8C', '#FFCB77', '#D0CB88', '#A1C181'];

    	var m_labels = [];
    	var m_data = [];
		
		// 종목리스트를 받아와서 m_labels에 넣고, m_data에 초기값 0을 준다.
    	<c:forEach items="${sportnameList}" var="sportname">
    		m_labels.push("${sportname}");
    		m_data.push(0);
		</c:forEach>
		
		// m_labels에서 해당 종목 인덱스를 찾고 m_data에 데이터를 넣는다.
		<c:forEach items="${manStatistics}" var="sport">
			var idx = m_labels.indexOf("${sport.sportname}");
			m_data[idx] = "${sport.sport_ratio}";
		</c:forEach>
		
    	let mChart= $('#mChart');
    	
    	const manPieChart = new Chart(mChart, {
   	    	type: 'pie',
   	    	data : {
   	    		labels : m_labels,
   	    		datasets:[{   
	    		backgroundColor: colorList,
	    		borderWidth: 0.5 ,
	    		borderColor: '#ddd',
	    		data: m_data   
	    		}]
			},
				options: {
					responsive: false,
					title: {
						display: true,
						text: '남성',
						position: 'top',
						fontSize: 28,
						fontColor: '#111',
						padding: 20
 	    		        },
					legend: {
	 					display: true,
	 					position: 'bottom',
						labels: {
							fontSize: 16,
							fontWeight: 800,
							boxWidth: 20,
							fontColor: '#111',
							padding: 15
						}
					},
				},
					centerText: {
						display: false,
						text: ""
					}
			});
    	
    		
    		/* pie chart - 여성 */
	    	var w_labels = [];
	    	var w_data = [];
	    	
	    	// 종목리스트를 받아와서 w_labels에 넣고, w_data에 초기값 0을 준다.
	    	<c:forEach items="${sportnameList}" var="sportname">
	    		w_labels.push("${sportname}");
	    		w_data.push(0);
			</c:forEach>
			
			// w_labels에서 해당 종목 인덱스를 찾고 w_data에 데이터를 넣는다.
			<c:forEach items="${womanStatistics}" var="sport">
				var idx = w_labels.indexOf("${sport.sportname}");
				w_data[idx] = "${sport.sport_ratio}";
			</c:forEach>
			
			let wChart= $('#wChart');
	    	
	    	const womanPieChart = new Chart(wChart, {
	   	    	type: 'pie',
	   	    	data : {
	   	    		labels : w_labels,
	   	    		datasets:[{   
		    		backgroundColor: colorList,
		    		borderWidth: 0.5 ,
		    		borderColor: '#ddd',
		    		data: w_data   
		    		}]
				},
					options: {
						responsive: false,
						title: {
							display: true,
							text: '여성',
							position: 'top',
							fontSize: 28,
							fontColor: '#111',
							padding: 20
	 	    		        },
						legend: {
		 					display: true,
		 					position: 'bottom',
							labels: {
								fontSize: 16,
								fontWeight: 800,
								boxWidth: 20,
								fontColor: '#111',
								padding: 15
							}
						},
					},
						centerText: {
							display: false,
							text: ""
						}
				});
	    	
	    	/* bar chart - 나이 */
	    	var age_labels = [];
	    	var age_data = [];
	    	var sport_labels = [];
	    	var chart_data = {};
	    	
	    	<c:forEach items="${ageGroup}" var="age">
	    		age_labels.push("${age}");
			</c:forEach>
			
			<c:forEach items="${sportnameList}" var="sportname">
				sport_labels.push("${sportname}");
				chart_data["${sportname}"] = [];
			</c:forEach>
			
			<c:forEach items="${ageStatistics}" var="statistics">
				<c:forEach items="${statistics}" var="sport" varStatus="status">
				chart_data["${sport.sportname}"].push("${sport.sport_ratio}");
				</c:forEach>
			</c:forEach>
			
			let index = 0;
			for(var sportname of sport_labels) {
				const data = {
						label: sportname,
	                    data: chart_data[sportname],
	                    backgroundColor: colorList[index],
	                    borderColor: '#ddd',
	                    borderWidth: 0.5,
						}
				age_data.push(data);
				index++;
			}
			
	    	
	    	let ageChart= $('#ageChart');
	    	
	        const myChart = new Chart(ageChart, {
	        type: 'bar',
	        data:{
	            labels: age_labels,
	            datasets: age_data
	        },
	        options:{
	                    maintainAspectRatio :false,//그래프의 비율 유지
	                    title: {
							display: true,
							text: '나이',
							position: 'top',
							fontSize: 28,
							fontColor: '#111',
							padding: 20
	 	    		        },
 						legend: {
 		 					display: true,
 		 					position: 'bottom',
 							labels: {
 								fontSize: 16,
 								fontWeight: 800,
 								boxWidth: 20,
 								fontColor: '#111',
 								padding: 15
 							}
 						},
	                }
	        });
	});
</script>

<div id="recommend_header">
	<span class="title">스포츠 추천</span>
</div>
<div id="recommend_nav">
	<!-- 로그인 시-->
	<div class="recommend_user_info login">
		<div>당신의 나이/성별과 같은 사용자들이 가장 좋아하는 스포츠 입니다</div>
		<div class="user_info_result">
		
			<!-- 사용자의 나이에 따른 통계 -->
			<ul class="user_age">
				<li class="category">${userAgeGroup}</li>
				<c:forEach items="${ageGroup}" var="age" varStatus="status">
		    		<c:if test="${age==userAgeGroup}">
		    			<c:set var="ageIndex" value="${status.index}" />
		    		</c:if>
				</c:forEach>
		    	<c:set var="ageResult" value="${ageTopStatistics[ageIndex]}" />
				<li><span class="sportname">${ageResult.sportname}</span>${ageResult.sport_ratio}%</li>
			</ul>
			
			<!-- 사용자의 성별에 따른 통계 -->
			<ul class="user_gender">
				<c:choose>
					<c:when test="${userGender eq '남성'}">
						<li class="category">남성</li>
						<c:set var="genderResult" value="${manStatistics[0]}" />
					</c:when> 
					<c:when test="${userGender eq '여성'}">
						<li class="category">여성</li>
						<c:set var="genderResult" value="${womanStatistics[0]}" />
					</c:when>
				</c:choose>
				<li><span class="sportname">${genderResult.sportname}</span>${genderResult.sport_ratio}%</li>
			</ul>
		</div>
	</div>
	
	<!-- 비로그인 시-->
	<div class="recommend_user_info non_login"><a href="/login">로그인</a>하시면 본인의 성별과 나이에 따른 추천 결과를 확인할 수 있습니다</div>
</div>

<!-- 로그인, 비로그인 공통 -->
<div id="recommend_container">
	<div class="title-filter-wrap">
		<h3>맞춤형 스포츠 추천</h3>
		<button onclick="location.href='/recommend/mbti'" class="filter">MBTI</button>
		<button onclick="location.href='/recommend/userinfo'" class="filter active">나이/성별</button>
	</div>
	<div class="recommend_content_user_info">
		<div class="gender_result">
			<!-- pie chart (남성) -->
			<canvas id="mChart" width="450px" height="450px"></canvas>
			<!-- pie chart (여성) -->
			<canvas id="wChart" width="450px" height="450px"></canvas>
		</div>
		<!-- bar chart (나이) -->
		<div class="age_result"><canvas id="ageChart"></canvas></div>
	</div>
</div>