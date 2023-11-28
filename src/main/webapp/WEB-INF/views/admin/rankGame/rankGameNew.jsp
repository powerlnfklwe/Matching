<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	$(function(){
		// 경기 유형 변할 때 항목 변화
		$("#gametype").change(function(){
			if($(this).val() == "normal") {
				$("#rankgameForm").removeAttr("action");
				$("#rankgameForm").attr("action", "/admin/normgame/normnewOk"); // 일반경기 DB 등록
				$(".item.min_people").remove();
				$(".item.max_people").remove();
				$(".item.gendertype").remove();
				$(".item.req_rank").remove();
				$(".item.managerfee").remove();
			}
			
			if($(this).val() == "rank") {
				$("#rankgameForm").removeAttr("action");
				$("#rankgameForm").attr("action", "/admin/rankgame/ranknewOk"); // 랭크경기 DB 등록
				$(".item.gametime").after('<li class="item min_people"><label for="min_people">경기충족인원</label><input type="text" name="min_people" id="min_people"/>명</li>');
				$(".item.min_people").after('<li class="item max_people"><label for="max_people">경기최대인원</label><input type="text" name="max_people" id="max_people"/>명</li>');
				$(".item.max_people").after('<li class="item gendertype"><label for="gendertype">성별유형</label><select name="gendertype" id="gendertype"><option value="남녀모두">남녀모두</option><option value="남자만">남자만</option><option value="여자만">여자만</option></select></li>');
				$(".item.gendertype").after('<li class="item req_rank"><label for="req_rank">요구랭크</label><select name="req_rank" id="req_rank"><option value="0">모든랭크</option><option value="1">BRONZE</option><option value="2">SILVER</option><option value="3">GOLD</option><option value="4">PLATINUM</option><option value="5">DIAMOND</option></select></li>');
				$(".item.payment").after('<li class="item managerfee"><label for="managerfee">매니저비</label><input type="text" name="managerfee" id="managerfee" maxlength="8" />원</li>');
			}
		});
		
		// 유효성검사
		$("#rankgameForm").submit(function() {
			if($("#gametime").val() == "") {
				alert("날짜/시간을 입력하세요.");
				return false;
			}
			if($("#usetime").val() == "") {
				alert("이용시간을 입력하세요.");
				return false;
			}
			if($(".item.min_people").length) { // 항목이 존재할 때
				if($("#min_people").val() == "") {
					alert("경기충족인원을 입력하세요.");
					return false;
				}
			}
			if($(".item.max_people").length) {
				if($("#max_people").val() == "") {
					alert("경기최대인원을 입력하세요.");
					return false;
				}
			}
			if($("#payment").val() == "") {
				alert("결제금액을 입력하세요.");
				return false;
			}
			if($(".item.managerfee").length) {
				if ($("#managerfee").val() == "") {
					alert("매니저비를 입력하세요.");
					return false;
				}
			}
			return true;
		});

		// 취소 버튼 누르면 이전 페이지로 돌아가기
		$(".prev").click(function() {
			history.back();
		});
	});
</script>
<div class="container" id="rank_new_container">
	<h2 id="page-title">경기 등록</h2>
	<form method="post" id="rankgameForm" action="/admin/rankgame/ranknewOk">
		<ul class="items">
			<li class="item gametype">
				<label>경기유형</label>
				<select name="gametype" id="gametype">
					<option value="rank" id="opt_rank" selected>랭크경기</option>
					<option value="normal" id="opt_normal">일반경기</option>
				</select>
			</li>
			
			<li class="item s_no">
				<label for="s_no">종목</label>
				<select name="s_no" id="s_no">
					<c:forEach var="sportDTO" items="${sportList}">
						<option value="${sportDTO.s_no}">${sportDTO.sportname}</option>
					</c:forEach>
				</select>
			</li>
			<li class="item st_no">
				<label for="st_no">구장</label>
				<select name="st_no" id="stadium">
					<c:forEach var="StadiumInfoDTO" items="${stadiumInfoList}">
						<option value="${StadiumInfoDTO.st_no}">${StadiumInfoDTO.stadium}, ${StadiumInfoDTO.location} / ${StadiumInfoDTO.idletime}</option>
					</c:forEach>
				</select>
			</li>
			<li class="item usetime">
				<label for="usetime">이용시간</label>
				<input type="text" name="usetime" id="usetime" placeholder=" 예) 1시간 30분"/>
			</li>
			<li class="item gametime">
				<label for="gametime">날짜/시간</label>
				<input type="datetime-local" name="gametime" id="gametime"/>
			</li>
			<li class="item min_people">
				<label for="min_people">경기충족인원</label>
				<input type="text" name="min_people" id="min_people"/>명
			</li>
			<li class="item max_people">
				<label for="max_people">경기최대인원</label>
				<input type="text" name="max_people" id="max_people"/>명
			</li>
			<li class="item gendertype">
				<label for="gendertype">성별유형</label>
				<select name="gendertype" id="gendertype">
					<option value="남녀모두">남녀모두</option>
					<option value="남자만">남자만</option>
					<option value="여자만">여자만</option>
				</select>
			</li>
			<li class="item req_rank">
				<label for="req_rank">요구랭크</label>
				<select name="req_rank" id="req_rank">
					<option value="0">모든랭크</option>
					<option value="1">BRONZE</option>
					<option value="2">SILVER</option>
					<option value="3">GOLD</option>
					<option value="4">PLATINUM</option>
					<option value="5">DIAMOND</option>
				</select>
			</li>
			<li class="item payment">
				<label for="payment">1인당 결제금액</label>
				<input type="text" name="payment" id="payment" maxlength="8" />원
			</li>
			<li class="item managerfee">
				<label for="managerfee">매니저비</label>
				<input type="text" name="managerfee" id="managerfee" maxlength="8" />원
			</li>
		</ul>
		<div class="btns">
			<a class="btn-gray btn-cancel prev">취소</a>
			<input type="submit" value="등록" class="btn-black" />
		</div>
	</form>
</div>
</body>
</html>