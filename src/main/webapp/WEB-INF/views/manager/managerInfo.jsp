<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>매니저페이지</title>
<link href="${path}/static/style/manager/managerInfo.css" rel="stylesheet" type="text/css" />

</head>
<body>
<div id="apply-container">
    <h1>신청한 경기 내역</h1>
	<div class="apply-caption">신청한 경기 수 : ${vo.totalRecord } 경기</div>
	<div class="apply-wrap">
		<img src="${path}/static/img/manager/balls.jpeg" />
		<div class="game-list">
		    <ul>
				<c:forEach items="${managerList}" var="manager" varStatus="status">       
		 			<input type='hidden' id='no' name='no' value='${manager.getNo()}'/>
		            <input type='hidden' id='managerid' name='managerid' value='${manager.getManagerid()}'/>   
	                <li class="game">
	                    <div>
		                    <div class="stadium"><b>${manager.stadium}</b></div>
		                    <div>
								<fmt:parseDate var="gametime" value="${manager.gametime}" pattern="yyyy-MM-dd HH:mm:ss" />
						    	<fmt:formatDate pattern="yyyy년 MM월 dd일 E요일 HH:mm" value="${gametime}" />
				  			</div>
		                    <div class="location">${manager.location}</div>
	                    </div>
	                    <div class="btns">
	                        <c:if test="${manager.g_status == 0}">
	                        	<button class="btn status">대기</button>
					    		<button class="btn red" type="submit">취소신청</button>
	                        </c:if>
	                        <c:if test="${manager.g_status == 1}">
	                            <button class="btn status black">확정</button>
	                            <button class="btn blue" onclick="location.href='${path}/manager/entry?no=${manager.no}'">명단확인</button>
	                        </c:if>
	                        <c:if test="${manager.g_status == 2}">
	                            <button class="btn status">취소</button>
	                            <button class="btn blue" onclick="location.href='${path}/manager/entry?no=${manager.no}'">명단확인</button>
	                        </c:if>
	                    </div>
	                </li>
				</c:forEach>
			</ul>
		            
	        <!-- 페이징 -->	
			<div class="pagingDiv">
				<ul>
					<c:if test="${vo.nowPage==1}">
						<li class="active">prev</li>
					</c:if>
					<c:if test="${vo.nowPage>1}">
						<li><a href="${path }/manager/managerInfo/${managerid}?nowPage=${vo.nowPage-1 }">prev</a></li>
					</c:if>
					<c:forEach var="p" begin="${vo.startPageNum}" end="${vo.startPageNum+vo.onePageNumCount-1 }">
						<c:if test="${ p<=vo.totalPage}"> <!-- 표시항 페이지 번호 총페이지 수보다 작거나 같을 때 페이지 번호를 출력한다.  -->
							<!-- 현재 페이지 표시하기 -->
							<c:if test="${p==vo.nowPage }">
		   						 <li class="active" style="background:#ddd;">${p}</li>
							</c:if>
							   <c:if test="${p!=vo.nowPage }">
								   <li>	<a href="${path }/manager/managerInfo?nowPage=${p }">${p }</a></li>
							   </c:if>
						</c:if>
					</c:forEach>
					
					
					<!--다음 페이지-->
					<c:if test="${vo.nowPage<vo.totalPage }"><!-- 다음페이지가 있을 때 -->
						<li><a href="${path }/manager/managerInfo?nowPage=${vo.nowPage + 1 }">next</a></li>
					</c:if>
					<c:if test="${vo.nowPage==vo.totalPage }">
						<li class="active">next</li>
					</c:if>
				</ul>		
			</div>
		</div>
	</div>
</div>


       	
     


      
    
	
</body>


<script>


           $(document).ready(function() {
           $(document).on('click', '.red', function() {
            	var managerList = [];
            		$('.game').each(function() {
            	var manager = {};
            		manager['managerid'] = $('#managerid').val();
            		manager['no'] = $('#no').val();
            		managerList.push(manager);
            		
            	});
           // 	var index = $(this).closest('.box')
            		$.ajax({
            			url: "${path}/manager/managerInfo",
            			type: "POST",
            			contentType: "application/json; charset=utf-8",
            			data: JSON.stringify(managerList),
            			dataType: "json",
            			success: function(response) {
            			alert("취소하시겠습니까.?");
            				console.log(response);
            	// window.location.href = "${path}/manager/managerInfo";
            	},
            		error: function(jqXHR, textStatus, errorThrown) {
            			alert("취소 완료되었습니다.");
            	}
            	});
            			//$(this).closest('.box').remove();
            	});
            	});




</script>
 
  

  
 
</html>


