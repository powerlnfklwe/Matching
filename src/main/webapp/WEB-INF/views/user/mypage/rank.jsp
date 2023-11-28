<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<!-- 오른쪽 내용칸 -->
	<div id="rankContent"> 
		<h3 class="rh3">나의 랭크</h3>
		<hr/>
		
		<!-- 랭크 보여주기 : 종합/종목별(selectbox) -->
		<div class="rView">
			<div class="allRank">
				<c:choose>
					<c:when test="${dto.getAvg_all()==0 }">
						종합 랭크 <div id="avg_all"> no Rank </div>
					</c:when>
					<c:when test="${dto.getAvg_all()==1 }">
						종합 랭크 <div id="avg_all"> 브론즈 </div>
					</c:when>
					<c:when test="${dto.getAvg_all()==2 }">
						종합 랭크 <div id="avg_all"> 실버 </div>
					</c:when>
					<c:when test="${dto.getAvg_all()==3 }">
						종합 랭크 <div id="avg_all"> 골드 </div> 
					</c:when>
					<c:when test="${dto.getAvg_all()==4 }">
						종합 랭크 <div id="avg_all"> 플래티넘 </div> 
					</c:when>
					<c:when test="${dto.getAvg_all()==5 }">
						종합 랭크 <div id="avg_all"> 다이아 </div>
					</c:when>
				</c:choose>
			</div>
			<div class="snRank">
				종목별 랭크
				<div id="avg_sn"></div><br/>
				<!-- 종목select : DB에 등록된 스포츠종목 받아오기 -->
				<select id="sportname" name="sportname" required>
					<option value="" >--선택--</option>
					<c:forEach var="sportList" items="${list}">
						<option value="${sportList.sportname}">${sportList.sportname}</option>
					</c:forEach>
				</select><br/>
				
			</div>
		</div>
		<!-- BarChart넣기 -->
		<div id="chart" class="chart" style="width:100%">
			<canvas id="line_chart"></canvas>
		</div>
		
	</div> <!-- 오른쪽 내용칸 div end -->
</div>	<!-- 왼쪽메뉴바와 오른쪽 본문 합친 div -->
<!-- 차트 그리기 script -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<script>
	$(function(){
		//차트 그리기에서 필요한 데이터 ---------------
		var title; //차트내용의 제목
		
		var gametime = new Array();//라벨(x축)
		var newgt = new Array(); //유닉스 타임스탬프를 자바형식으로 변경
		var isoDates = new Array(); // 2023-01-01 형태로 변경

		var rank = new Array(); //데이터(y축)
		var rankName = new Array(); //랭크변환 : 12345 > "브실골프다" 로 바꾸기
		
		var backgroundColor = 'rgba(255, 99, 132, 0.2)';
		var borderColor = 'rgb(255, 99, 132)';
		
		//----------------------------------------
		//차트 그리기
		function chart(){
			//차트data
			var data = {
				labels: isoDates, //x축
				datasets: [{
					label: title, //차트제목
				    data: rank, //y축
				    fill: false,
				    borderColor: borderColor,
				    tension: 0.1
				    
		 		 }]
			};
			//차트생성
			var chart = new Chart(document.getElementById("line_chart"), {
			    type: 'line',
			    data: data,
			    options: { 
			    	 scales: { 
			    		/* xAxes: [{ ticks: { display: false } }], */ //x축 없애기 -> 오른쪽 끝이 잘린다??*/
			    		yAxes: [{	//y축설정/*  */
			                ticks: {
			                    max: 5,
			                    min: 0,
			                    stepSize: 1,
			                    callback: function(value, index, values) {
			                        // y축 눈금 값을 브실골플다 로 변경
			                        var labels = ['', '브론즈', '실버', '골드', '플래티넘', '다이아'];
			                        return labels[value];
			                      }
			                }
			            }]
			    	},
			    	tooltips: { //툴팁 사이즈 키우기(기본 12)
		                titleFontSize: 15,
		                bodyFontSize: 15,
		                callbacks: {
		                    label: function(tooltipItem, data) {
		                      			//오버하면 툴팁엔 날짜(x축)만 나오게
		                      			var label = data.labels[tooltipItem.dataIndex];
      								    return label;
		                  	}
		          		} 
			    	}
			    }
			});
		}
		//차트 지우기
		
		//select에 변화있으면 ajax 실행
		$("#sportname").change(function(){ 
			event.preventDefault();
			
			var value = (sportname.options[sportname.selectedIndex].value); //옵션의 value값 구하기
			var data = {sportname: value }
			//console.log(data);
			
			if(value==""){
				alert("종목을 선택하세요");
				return false;	
			}
			
			$.ajax({
				data : data,
				type : 'POST',
				url : "rankMain",
				success : function(result){
					console.log(result);
					//$("#result").html(result);
					
					var jsonData = JSON.parse(result);
					console.log(jsonData);
					
					//종목랭크, 종합랭크 뷰로 보내기
					//종목명 보내기
					console.log(jsonData[0].avg_sn);
					if(jsonData[0]!=null){
						//종목랭크
						if(jsonData[0].avg_sn==1){
							$("#avg_sn").html("브론즈");
						}else if(jsonData[0].avg_sn==2){
							$("#avg_sn").html("실버");	
						}else if(jsonData[0].avg_sn==3){
							$("#avg_sn").html("골드");	
						}else if(jsonData[0].avg_sn==4){
							$("#avg_sn").html("플래티넘");	
						}else if(jsonData[0].avg_sn==5){
							$("#avg_sn").html("다이아");	
						}
					}else{
						$("#avg_sn").html("no rank");
					}
					
					//차트제목
					title = jsonData[0].sportname;
					
					// 차트에 넣을 x,y값을 배열로 준비
					jsonData.map(function(obj, i){
						gametime[i]=obj.gametime; //라벨(x축) : 기준날짜
						console.log("gametime["+i+"]:: "+gametime[i]);
						
						newgt[i] = new Date(gametime[i]);
						console.log("newgt["+i+"]:: "+newgt); 
						//	newgt[]에 gametime[]를 담으니까 gametime[]에 들어가있는 애들이 다 나오는구나

						rank[i]=obj.rank; //데이터(y축)
						console.log("rank["+i+"]:: "+rank[i]);
					}) 
					isoDates = newgt.map(date=>date.toISOString().split('T')[0]);
					//console.log(isoDates);
					
					//기존 차트 지우기
					//chart.destroy();
					//removeChart();
					
					//차트 그리기
					chart();
				 
				}, error : function(e){
					console.log(e.responseText);
				}
			});
		});
		
	});	
</script>
