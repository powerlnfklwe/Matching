<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function () {
		
	    //모든 datepicker에 대한 공통 옵션 설정
        $.datepicker.setDefaults({
			dateFormat: 'yy-mm-dd' //Input Display Format 변경
			,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
			,changeYear: true //콤보박스에서 년 선택 가능
			,changeMonth: true //콤보박스에서 월 선택 가능                
			,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
			,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
			,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
			,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
			,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
			,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
			,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
			,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
			,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전) 
			,maxDate: "today" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)	//오늘까지                
        });

        //input을 datepicker로 선언
        $("#datepicker").datepicker();                    
        $("#datepicker2").datepicker();
        
        //From의 초기값을 오늘 날짜로 설정
        //$('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        //To의 초기값을 내일로 설정
        //$('#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	
		
        //value확인하기
        $("#expFilter").click(function(){
        	var valueById = $("#datepicker").val();
	       	var valueById2 = $("#datepicker2").val();
        	
	       	if(valueById > valueById2){
	       		alert("종료일은 시작일 이후 일자만 선택 가능합니다.");
	       		return false;
	       	}
	       	alert("1번 value값->"+valueById + ", 2번 value값->"+valueById2);
        });
        
        
	});
</script>
<style>
	/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
	.ui-datepicker-trigger{cursor: pointer;}
	/*datepicer input 롤오버 시 손가락 모양 표시*/
	.hasDatepicker{cursor: pointer;}
</style>

<div class="container">
	<h2 id="page-title">지출 내역</h2>
	
	<div class="expense_stats" style="width:1000px; height:30px; background:#ddd;">
		<form id="expSelectFrm" method="get" action="expense">
			From: <input type="text" id="datepicker" name="datepicker" placeholder="날짜를 선택하세요"/>
	    	To: <input type="text" id="datepicker2" name="datepicker2" placeholder="날짜를 선택하세요"/>
	    	<input type="submit" id="expFilter" value="확인하기"/>
		</form>
		<div class="expent_Result" style="background:green; width: 300px; height: 50px;">
			지출 총액 : ${ExpSum }
	
	
		</div>
	</div>
	<br/>
	
	
	
	<div id="expense_container">
		<table>
			<tr class="expense">
				<th id="">번호</th>
				<th id="amount">금액</th>
				<th id="">지출목록</th>
				<th id="">지출상세</th>
				<th id="datetime">날짜</th>
			</tr>
			<c:forEach var="m_settlement" items="${expense}" varStatus="status">
				<tr>
					<td>${(vo.nowPage-1)*(vo.onePageRecord)+ status.count}</td>
					<td><fmt:formatNumber value="${m_settlement.amount}" maxFractionDigits="3"/>원</td>
					<td>매니저 수당</td>
					<td>${m_settlement.m_name} 매니저 [지급계좌: ${m_settlement.m_account}]</td>
					<td>
						<c:if test="${m_settlement.datetime==null}">
							<span>-</span>
						</c:if>
						<fmt:formatDate pattern="yyyy-MM-dd" value="${m_settlement.datetime}" />
					</td>
				<tr>
			</c:forEach>
		</table>
		
		<!-- 페이징 -->
		<div class="pagingDiv">
		<ul>
			<!-- 이전페이지 -->
			<c:if test="${vo.nowPage>1}">
				<li><a href="expense?nowPage=${vo.nowPage-1}">이전</a></li>
			</c:if>
			<!-- 페이지번호 -->
			<c:forEach var="pageNum" begin="${vo.startPageNum}" end="${vo.startPageNum+(vo.onePageNumCount-1)}" step="1">
				<c:if test="${pageNum<=vo.totalPage}">
					<li>
					<c:if test="${vo.nowPage==pageNum }"><b></c:if>
					<a href="expense?nowPage=${pageNum}">${pageNum}</a>
					<c:if test="${vo.nowPage==pageNum }"></b></c:if>
					</li>
				</c:if>
				<c:if test="${pageNum>vo.totalPage}">
					<li style="visibility:hidden;">${pageNum}</li>
				</c:if>
			</c:forEach>
			<!-- 다음페이지 -->
			<c:if test="${vo.nowPage<vo.totalPage}">
				<li><a href="expense?nowPage=${vo.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
		</div>
	</div>
</div>
</body>
</html>