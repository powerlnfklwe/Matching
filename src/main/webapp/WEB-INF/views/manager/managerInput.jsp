<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>

<head>
<meta charset="UTF-8">
	<title>활동 내역</title>
	<link href="${path}/static/style/manager/managerInput.css" rel="stylesheet" type="text/css" />
</head>
<style>
  
</style>

<body>
  <div id="rank-input-container">
  <h1>참가자 랭크입력</h1>
	<div class="content-wrap">
	  	<div class="rank-valuation">
			<div class="title">랭크 평가 기준</div>
			<div class="rank-wrap">
				<span class="rank-name">다이아</span>
				<span>세미 프로 수준의 경기력을 갖추었거나 선수 경력이 있는 사용자. 경기 전체의 흐름을 읽고 능숙한 플레이를 할 수 있습니다. 체력, 피지컬, 기술 모두 수준급입니다. </span>
			</div>
			<div class="rank-wrap">
				<span class="rank-name">플래티넘</span>
				<span>대부분의 상황에서 안정적인 플레이를 수행해 냅니다. 높은 수준의 체력과, 피지컬, 경기 운용 능력을 갖추었습니다.</span>
			</div>
			<div class="rank-wrap">
				<span class="rank-name">골드</span>
				<span>기본기를 제대로 갖춘 단계입니다. 자세가 안정적이고 전반적인 플레이에서 노련함이 드러납니다. 그러나 급박한 상황에서는 여전히 미숙하고 실전 경험이 더 필요한 단계라고 할 수 있습니다.</span>
			</div>
			<div class="rank-wrap">
				<span class="rank-name">실버</span>
				<span>기본기를 어느 정도 인지하고 사용하는 사용자. 그렇지만, 안정적으로 플레이하기 위해서는 수많은 노력이 필요한 단계입니다.</span>
			</div>
			<div class="rank-wrap">
				<span class="rank-name">브론즈</span>
				<span>입문 수준의 사용자. 해당 종목을 막 시작한 사람에게 부여됩니다.</span>
			</div>
			<div class="rank-wrap">
				<span class="rank-name">노랭크</span>
				<span>아직 한 번도 랭크 경기를 치르지 않은 사용자. 첫 번째 경기를 치르기 전까지 노랭크 상태를 유지합니다.</span>
			</div>
			
			
			
			
			
		</div>
		<div class="rank-input-wrap">
		    <table>
		      <thead>
		        <tr>
		          <th>아이디</th>
		          <th>이름</th>
		          <th>랭크</th>
		        </tr>
		      </thead>
		      <tbody>
		        <c:forEach items="${managerInputList}" var="managerInput">
		          <tr>
		            <td><c:out value="${managerInput.getUserid()}" /></td>
		            <td><c:out value="${managerInput.getUsername()}" /></td>
		             <input type="hidden" name="no" value="${managerInput.getNo()}" />
		            <td>
		              <select class="rank-filter" name="rank">
		              
		                <option value="0">노랭크</option>
		                <option value="1" ${managerInput.getRank() == 1 ? 'selected' : ''}>브론즈</option>
		                <option value="2" ${managerInput.getRank() == 2 ? 'selected' : ''}>실버</option>
		                <option value="3" ${managerInput.getRank() == 3 ? 'selected' : ''}>골드</option>
		                <option value="4" ${managerInput.getRank() == 4 ? 'selected' : ''}>플래티넘</option>
		                <option value="5" ${managerInput.getRank() == 5 ? 'selected' : ''}>다이아</option>
		              </select>
		             
		            </td>
		          </tr>
		        </c:forEach>
		      </tbody>
		    </table>
	    
		    <div class="btns">
		     	<a href="${path }/manager/managerPast">
		    	<button class="btn cancel" onclick="location.href='${path}/manager/managerPast'">취소</button>    
		    	<button class="btn btn-submit" onclick="alert('랭크를 입력했습니다.')" >입력</button>   </a> 
		    </div>
		</div>
	</div>
</div>
</body>
<script>
    
  
    $(document).ready(function() {
        $('.btn-submit').click(function() {
            var managerInputList = [];
            $('tbody tr').each(function() {
                var managerInput = {};
                managerInput['userid'] = $(this).find('td:eq(0)').text();
                managerInput['rank'] = $(this).find('select.rank-filter').val();
                managerInput['no'] = $(this).find('input[name=no]').val();
                managerInputList.push(managerInput);
                
            });

            $.ajax({
                url: "${path}/manager/managerInput",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(managerInputList),
                dataType : "json",
                success: function(response) {
                    alert("랭크를 입력했습니다.");

               //     window.location.href = "${path}/manager/managerPast";
                },
                error: function(jqXHR, textStatus, errorThrown) {
                	console.log(jqXHR);
                    console.log(textStatus);
                    console.log(errorThrown);
                   // alert("랭크를 입력했습니다.");
                }
            });
        });
    });
   
    
    </script>
    
   
 
</html>