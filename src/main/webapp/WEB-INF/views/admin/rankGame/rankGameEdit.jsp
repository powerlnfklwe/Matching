<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	// 유효성검사
	$(function(){
		$("#rankgameForm").submit(function(){
			if($("#gametime").val()==""){
				alert("날짜/시간을 입력하세요.");
				return false;
			}
			if($("#min_people").val()==""){
				alert("경기충족인원을 입력하세요.");
				return false;
			}
			if($("#max_people").val()==""){
				alert("경기최대인원을 입력하세요.");
				return false;
			}
			if($("#payment").val()==""){
				alert("1인당 결제금액을 입력하세요.");
				return false;
			}
			if($("#managerfee").val()==""){
				alert("매니저비를 입력하세요.");
				return false;
			}
			return true;
		});
		
		// 취소 버튼 누르면 이전 페이지로 돌아가기
		$(".prev").click(function(){
			history.back();
		});
	});
</script>
<div class="container" id="rank_new_container">
	<h2 id="page-title">경기 수정</h2>
	<form method="post" action="editOk" id="rankgameForm">
		<input type="hidden" name="no" value="${rankgameInfo.no}" />
		<ul>
			<li class="item">
				<label>경기유형</label>
				<input type="text" value="랭크경기" id="gametype" readonly disabled/>
			</li>
			
			<li class="item">
				<label for="s_no">종목</label>
				<select name="s_no" id="s_no">
					<c:forEach var="sportDTO" items="${sportList}">
						<option value="${sportDTO.s_no}" <c:if test="${rankgameInfo.s_no eq sportDTO.s_no}">selected</c:if>>${sportDTO.sportname}</option>
					</c:forEach>
				</select>
			</li>
			<li class="item">
				<label for="gametime">날짜/시간</label>
				<input type="datetime-local" name="gametime" id="gametime" value="${gametimeStr}" />
			</li>
			<li class="item">
				<label for="st_no">구장</label>
				<select name="st_no" id="stadium">
					<c:forEach var="StadiumInfoDTO" items="${stadiumInfoList}">
						<option value="${StadiumInfoDTO.st_no}" <c:if test="${rankgameInfo.st_no eq StadiumInfoDTO.st_no}">selected</c:if>>
							${StadiumInfoDTO.stadium}, ${StadiumInfoDTO.location}
						</option>
					</c:forEach>
				</select>
			</li>
			<li class="item">
				<label for="min_people">경기충족인원</label>
				<input type="text" name="min_people" id="min_people" value="${rankgameInfo.min_people}"/>명
			</li>
			<li class="item">
				<label for="max_people">경기최대인원</label>
				<input type="text" name="max_people" id="max_people" value="${rankgameInfo.max_people}"/>명
			</li>
			<li class="item">
				<label for="gendertype">성별유형</label>
				<select name="gendertype" id="gendertype">
					<option value="남녀모두" <c:if test="${rankgameInfo.gendertype eq '남녀모두'}">selected</c:if>>남녀모두</option>
					<option value="남자만" <c:if test="${rankgameInfo.gendertype eq '남자만'}">selected</c:if>>남자만</option>
					<option value="여자만" <c:if test="${rankgameInfo.gendertype eq '여자만'}">selected</c:if>>여자만</option>
				</select>
			</li>
			<li class="item">
				<label for="req_rank">요구랭크</label>
				<select name="req_rank" id="req_rank">
					<option value="0">모든랭크</option>
					<option value="1" <c:if test="${rankgameInfo.req_rank==1}">selected</c:if>>BRONZE</option>
					<option value="2" <c:if test="${rankgameInfo.req_rank==2}">selected</c:if>>SILVER</option>
					<option value="3" <c:if test="${rankgameInfo.req_rank==3}">selected</c:if>>GOLD</option>
					<option value="4" <c:if test="${rankgameInfo.req_rank==4}">selected</c:if>>PLATINUM</option>
					<option value="5" <c:if test="${rankgameInfo.req_rank==5}">selected</c:if>>DIAMOND</option>
				</select>
			</li>
			<li class="item">
				<label for="payment">1인당 결제금액</label>
				<input type="text" name="payment" id="payment" maxlength="8" value="${rankgameInfo.payment}" />원
			</li>
			<li class="item">
				<label for="managerfee">매니저비</label>
				<input type="text" name="managerfee" id="managerfee" maxlength="8" value="${rankgameInfo.managerfee}" />원
			</li>
		</ul>
		<div class="btns">
			<a class="btn-gray btn-cancel prev">취소</a>
			<input type="submit" value="수정" class="btn-black" />
		</div>
	</form>
</div>
</body>
</html>