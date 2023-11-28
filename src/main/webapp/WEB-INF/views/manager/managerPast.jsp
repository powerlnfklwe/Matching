<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>활동내역</title>
	<link href="${path}/static/style/manager/managerPast.css" rel="stylesheet" type="text/css" />
<!--  	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">-->
	</head>


<body>
<div id="past-container">
    <h1>이전 경기내역</h1>
	<div class="past-caption">참여 경기 수: ${vo.totalRecord } 경기</div>
  
	<ul class="game-list">
	    <c:forEach items="${managerList}" var="manager" varStatus="status">
			<li class="game">
		        <div>
			        <div class="stadium">${manager.stadium}</div>
			        <div>
			        	<fmt:parseDate var="gametime" value="${manager.gametime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						<fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${gametime}"/>
					</div>
			        <div class="location">${manager.location}</div>
		        </div>
		       	<div>
					<button id="rank-btn" class="" onclick="location.href='${path}/manager/managerInput?no=${manager.no}'">참가자 랭크 입력</button>
		       	</div>
			</li>
	     </c:forEach>
     </ul>
    
    <div class="pagination-container">
		<!-- 페이징 -->	
		<div class="pagingDiv">
			<ul>
				<c:if test="${vo.nowPage==1}">
					<li class="active">prev</li>
				</c:if>
				<c:if test="${vo.nowPage>1}">
					<li><a href="${path }/manager/managerPast?nowPage=${vo.nowPage-1 }">prev</a></li>
				</c:if>
				<c:forEach var="p" begin="${vo.startPageNum}" end="${vo.startPageNum+vo.onePageNumCount-1 }">
					<c:if test="${ p<=vo.totalPage}"> <!-- 표시항 페이지 번호 총페이지 수보다 작거나 같을 때 페이지 번호를 출력한다.  -->
						<!-- 현재 페이지 표시하기 -->
						<c:if test="${p==vo.nowPage }">
	   						 <li class="active" style="background:#ddd;">${p}</li>
						</c:if>
						   <c:if test="${p!=vo.nowPage }">
							   <li>	<a href="${path }/manager/managerPast?nowPage=${p }">${p }</a></li>
					       </c:if>
						
					</c:if>
				</c:forEach>
				
				<!--다음 페이지-->
				<c:if test="${vo.nowPage<vo.totalPage }"><!-- 다음페이지가 있을 때 -->
					<li><a href="${path }/manager/managerPast?nowPage=${vo.nowPage + 1 }">next</a></li>
				</c:if>
				<c:if test="${vo.nowPage==vo.totalPage }">
					<li class="active">next</li>
				</c:if>
			</ul>
			
		</div>
	</div>       
</div>
   
   

</body>

<script>
//저장된 텍스트가 있으면 불러오기
//const rankBtn = document.getElementById('rank-btn');

  // 저장된 텍스트가 있으면 불러오기
//  const storedText = localStorage.getItem('rankBtnText');
//  if (storedText) {
 //   rankBtn.textContent = storedText;
 // }

  // 버튼 클릭시 텍스트 변경하고 저장
 // rankBtn.addEventListener('click', () => {
//    const newText = '수정하기';
 //   rankBtn.textContent = newText;
//    localStorage.setItem('rankBtnText', newText);
//  });
  </script>
  

</html>

