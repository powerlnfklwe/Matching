<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	// 유효성검사
	$(function(){
		$("#normgameForm").submit(function(){
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
	<form method="post" action="editOk" id="normgameForm">
		<input type="hidden" name="no" value="${normgameInfo.no}" />
		<ul>
			<li class="item">
				<label>경기유형</label>
				<input type="text" value="일반경기" id="gametype" readonly disabled/>
			</li>
			
			<li class="item">
				<label for="s_no">종목</label>
				<select name="s_no" id="s_no">
					<c:forEach var="sportDTO" items="${sportList}">
						<option value="${sportDTO.s_no}" <c:if test="${normgameInfo.s_no eq sportDTO.s_no}">selected</c:if>>${sportDTO.sportname}</option>
					</c:forEach>
				</select>
			</li>
			<li class="item">
				<label for="gametime">날짜/시간</label>
				<input type="datetime-local" name="gametime" id="gametime" value="${gametimeStr}" />
			</li>
			<li class="item">
				<label for="usetime">이용시간</label>
				<input type="text" name="usetime" id="usetime" value="${normgameInfo.usetime}"/>
			</li>
			<li class="item">
				<label for="st_no">구장</label>
				<select name="st_no" id="stadium">
					<c:forEach var="StadiumInfoDTO" items="${stadiumInfoList}">
						<option value="${StadiumInfoDTO.st_no}" <c:if test="${normgameInfo.st_no eq StadiumInfoDTO.st_no}">selected</c:if>>
							${StadiumInfoDTO.stadium}, ${StadiumInfoDTO.location} / ${StadiumInfoDTO.idletime}
						</option>
					</c:forEach>
				</select>
			</li>
			<li class="item">
				<label for="min_people">경기충족인원</label>
				<input type="text" name="min_people" id="min_people" value="${normgameInfo.min_people}"/>명
			</li>
			<li class="item">
				<label for="max_people">경기최대인원</label>
				<input type="text" name="max_people" id="max_people" value="${normgameInfo.max_people}"/>명
			</li>
			<li class="item">
				<label for="gendertype">성별유형</label>
				<select name="gendertype" id="gendertype">
					<option value="남녀모두" <c:if test="${normgameInfo.gendertype eq '남녀모두'}">selected</c:if>>남녀모두</option>
					<option value="남자만" <c:if test="${normgameInfo.gendertype eq '남자만'}">selected</c:if>>남자만</option>
					<option value="여자만" <c:if test="${normgameInfo.gendertype eq '여자만'}">selected</c:if>>여자만</option>
				</select>
			</li>
			<li class="item">
				<label for="payment">1인당 결제금액</label>
				<input type="text" name="payment" id="payment" maxlength="8" value="${normgameInfo.payment}" />원
			</li>
			<li class="item">
				<label for="g_status">경기상태</label>
				<select name="gendertype" id="gendertype">
					<option value="0" <c:if test="${normgameInfo.g_status == 0}">selected</c:if>>미개설</option>
					<option value="1" <c:if test="${normgameInfo.g_status == 1}">selected</c:if>>대기</option>
					<option value="2" <c:if test="${normgameInfo.g_status == 2}">selected</c:if>>확정</option>
					<option value="3" <c:if test="${normgameInfo.g_status == 3}">selected</c:if>>취소</option>
				</select>
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