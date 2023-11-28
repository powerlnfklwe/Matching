<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="game_header rank_game_header">
	<span class="game_header_title">랭크경기</span>
</div>
<div class="game_nav">종목선택 > <b>경기목록</b> > 경기상세정보</div>
<div class="game_container">
	<h4 class="game_notice">※ 랭크경기 참여 신청은 경기 일정의 이틀 전까지 가능합니다.</h4>
	<div class="game_notice_ex">예) 2023-04-25 17:00 경기의 참여 신청 마감일은 2023-04-23 17:00입니다.</div>
	<!-- 필터 -->
	<form method="get" action="rankgamelist" id="filterForm">
		<input type="hidden" name="s_no" value="${s_no}"/>
		<!-- 지역 필터링 --> 
		<!-- parameter(region)의 값과 option태그의 value가 같은 경우, selected를 추가하여
			다른 필터(성별,요구랭크)의 값이 변경되더라도 지역 필터는 값이 초기화되지 않도록 한다.  -->
		<select name="region" class="filter">
			<option value="all" <c:if test="${param.region eq 'all'}">selected</c:if>>모든지역</option>
			<option value="서울" <c:if test="${param.region eq '서울'}">selected</c:if>>서울</option>
			<option value="경기/인천" <c:if test="${param.region eq '경기/인천'}">selected</c:if>>경기/인천</option>
			<option value="강원" <c:if test="${param.region eq '강원'}">selected</c:if>>강원</option>
			<option value="대전/세종/충청" <c:if test="${param.region eq '대전/세종/충청'}">selected</c:if>>대전/세종/충청</option>
			<option value="대구/경북" <c:if test="${param.region eq '대구/경북'}">selected</c:if>>대구/경북</option>
			<option value="부산/울산/경남" <c:if test="${param.region eq '부산/울산/경남'}">selected</c:if>>부산/울산/경남</option>
			<option value="광주/전라/제주" <c:if test="${param.region eq '광주/전라/제주'}">selected</c:if>>광주/전라/제주</option>
		</select>
		<!-- 성별 필터링 -->
		<!-- parameter(gendertype)의 값과 option태그의 value가 같은 경우, selected를 추가하여
			다른 필터의 값이 변경되더라도 성별 필터는 값이 초기화되지 않도록 한다.  -->
		<select name="gendertype" class="filter">
			<option value="all" <c:if test="${param.gendertype eq 'all'}">selected</c:if>>성별무관</option>
			<option value="남녀모두" <c:if test="${param.gendertype eq '남녀모두'}">selected</c:if>>남녀모두</option>
			<option value="남자만" <c:if test="${param.gendertype eq '남자만'}">selected</c:if>>남자만</option>
			<option value="여자만" <c:if test="${param.gendertype eq '여자만'}">selected</c:if>>여자만</option>
		</select>
		<!-- 요구랭크 필터링 -->
		<!-- parameter(req_rank)의 값과 option태그의 value가 같은 경우, selected를 추가하여
			다른 필터의 값이 변경되더라도 요구랭크 필터는 값이 초기화되지 않도록 한다.  -->
		<select name="req_rank" class="filter">
			<option value="0" <c:if test="${param.req_rank eq '0'}">selected</c:if>>모든랭크</option>
			<option value="1" <c:if test="${param.req_rank eq '1'}">selected</c:if>>브론즈이상</option>
			<option value="2" <c:if test="${param.req_rank eq '2'}">selected</c:if>>실버이상</option>
			<option value="3" <c:if test="${param.req_rank eq '3'}">selected</c:if>>골드이상</option>
			<option value="4" <c:if test="${param.req_rank eq '4'}">selected</c:if>>플래티넘이상</option>
			<option value="5" <c:if test="${param.req_rank eq '5'}">selected</c:if>>다이아이상</option>
		</select>
		<input type="submit" value="필터 적용" class="btn-filter"/>
		<a href="${path}/rankgame/sportlist" class="back_to_list">종목보기</a>
	</form>
	
	<!-- 경기 목록 -->
	<ul class="game_list">
		<c:forEach var="RankGameDTO" items="${rankGameList}">
			<c:set var="gametime" value="${RankGameDTO.gametime}" />
			<%
			// 마감 또는 마감 임박 경기인지 확인하는 로직
			// 1. Calendar 객체 생성
			Calendar nowCalendar = Calendar.getInstance();
			Calendar closeCalendar = Calendar.getInstance();
			Calendar closeImminentCalendar = Calendar.getInstance();

			// 2. 현재 날짜 Date 구하기
			Date now = new Date();
			nowCalendar.setTime(now);

			// 3. 경기일정 구하기
			Date gametime = (Date) pageContext.getAttribute("gametime");

			// 4. 경기 신청 마감일 구하기: 경기일정의 2일 전 0시
			closeCalendar.setTime(gametime);
			closeCalendar.add(closeCalendar.DATE, -2); // gametime-2
			closeCalendar.set(closeCalendar.HOUR_OF_DAY, 0); // 24시간 기준 0시로 설정

			// 5. 경기 신청 마감임박 시작일 구하기: 경기신청 마감일의 2일 전 0시 (즉, 경기일정의 4일 전)
			closeImminentCalendar.setTime(gametime);
			closeImminentCalendar.add(closeImminentCalendar.DATE, -4); // gametime-4
			closeImminentCalendar.set(closeImminentCalendar.HOUR_OF_DAY, 0); // 24시간 기준 0시로 설정

			// 6. 마감 임박 경기인지 확인
			// closeImminentCalendar < nowCalendar < closeCalendar 이면 true, 아니면 false
			Boolean isImminent = nowCalendar.after(closeImminentCalendar) && nowCalendar.before(closeCalendar);
			pageContext.setAttribute("isImminent", isImminent);

			// 7. 신청마감 경기인지 확인
			// closeCalendar < nowCalendar 이면 true, 아니면 false
			Boolean isClose = nowCalendar.after(closeCalendar);
			pageContext.setAttribute("isClose", isClose);
			%>
			<li class="game_item">
				<!-- 경기 지역 -->
				<div class="game_region">${RankGameDTO.region}</div>
				<!-- 경기 정보 -->
				<div class="game_info_container rank">
					<!-- 경기 날짜/시간 -->
					<span class="game_time">
						<fmt:formatDate pattern="yyyy-MM-dd (E) HH:mm" value="${RankGameDTO.gametime}" /><br/>
						이용시간 : ${RankGameDTO.usetime}
					</span>
					<div class="game_info">
						<!-- 구장 이름 -->
						<c:choose>
							<c:when test="${isClose}">
								<span class="game_stadium">${RankGameDTO.stadium}</span>
							</c:when>
							<c:otherwise>
								<a href="detail?no=${RankGameDTO.no}" class="game_stadium">${RankGameDTO.stadium}</a>
							</c:otherwise>
						</c:choose>
						
						<!-- 경기 조건 -->
						<div class="game_conditions">
							<!-- 성별 유형 -->
							<span class="game_condition">${RankGameDTO.gendertype}</span>
							
							<!-- 몇 대 몇 -->
							<!-- 한 팀당 인원수를 구하기 위해 min_people을 2로 나누고 정수로 변환한다. -->
							<fmt:parseNumber var="oneTeamNumber" integerOnly="true" value="${RankGameDTO.min_people/2}" />
							<span class="game_condition">${oneTeamNumber}vs${oneTeamNumber}</span>
							
							<!-- 몇 파전 -->
							<!-- 팀의 수를 구하기 위해 max_people을 한 팀당 인원수로 나누고 정수로 변환한다. -->
							<fmt:parseNumber var="teamCount" integerOnly="true" value="${RankGameDTO.max_people/oneTeamNumber}" />
							<span class="game_condition">${teamCount}파전</span>
							
							<!-- 요구랭크 -->
							<span class="game_condition">
								<c:set var="rank" value="${RankGameDTO.req_rank}"/>
								<c:choose>
									<c:when test="${rank==1}">
						            	브론즈이상
									</c:when>
						         	<c:when test="${rank==2}">
						            	실버이상
						         	</c:when>
						         	<c:when test="${rank==3}">
						            	골드이상
									</c:when>
						         	<c:when test="${rank==4}">
						            	플래티넘이상
						         	</c:when>
						         	<c:when test="${rank==5}">
						            	다이아이상
									</c:when>
						         	<c:otherwise>
						            	모든랭크
						         	</c:otherwise>
						      	</c:choose>
							</span>
							
							<!-- 인원 정보 -->
							<span class="game_condition">참여인원 ${RankGameDTO.curr_people} / ${RankGameDTO.max_people}</span>
						</div>
					</div>
				</div>
				
				<!-- 경기 신청 가능 상태 -->
				<c:choose>
					<c:when test="${isClose || (RankGameDTO.curr_people >= RankGameDTO.max_people)}">
		            	<div class="game-status close"><span>신청마감</span></div>
		         	</c:when>
		         	<c:when test="${isImminent}">
		            	<div class="game-status imminent"><a href="detail?no=${RankGameDTO.no}" class="game_stadium2">마감임박</a></div>
		         	</c:when>
		         	<c:otherwise>
		            	<div class="game-status open"><a href="detail?no=${RankGameDTO.no}" class="game_stadium2">신청가능</a></div>
		         	</c:otherwise>
		      	</c:choose>
			</li>
		</c:forEach>
	</ul>
</div>
