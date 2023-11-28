<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="game_header norm_game_header">
	<span class="game_header_title">일반경기</span>
</div>
<div class="game_nav norm_game_nav">종목선택 > <b>경기목록</b> > 경기상세정보</div>
<div class="game_container">
	<h4 class="game_notice">※ 일반경기 참여 신청은 경기 시작 하루 전까지 가능합니다.</h4>
	<div class="game_notice_ex">예) 2023-04-25 17:00 경기의 신청 마감시간은 2023-04-24 17:00입니다.</div>
	
	<!-- 필터 -->
	<form method="get" action="normgamelist" id="filterForm">
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
		<input type="submit" value="필터 적용" class="btn-filter"/>
		<c:if test="${logStatus == 'Y' }"><a href="${path}/normgame/new?s_no=${s_no}" class="new_game">경기개설</a></c:if>
		<a href="${path}/normgame/sportlist" class="back_to_list">종목보기</a>
	</form>
	
	<!-- 경기 목록 -->
	<ul class="game_list">
		<c:forEach var="NormGameDTO" items="${normGameList}">
			<c:set var="gametime" value="${NormGameDTO.gametime}" />
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

			// 4. 경기 신청 마감시간 구하기: 경기일정 당일 경기시간의 하루 전
			closeCalendar.setTime(gametime);
			closeCalendar.add(closeCalendar.DATE, -1); // gametime - 1

			// 5. 경기 신청 마감임박 시작일 구하기: 경기신청 마감일의 2일 전
			closeImminentCalendar.setTime(gametime);
			closeImminentCalendar.add(closeImminentCalendar.DATE, -2); // gametime - 2

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
				<div class="game_region">${NormGameDTO.region}</div>
				<!-- 경기 정보 -->
				<div class="game_info_container norm">
					<!-- 경기 날짜/시간 -->
					<span class="game_time">
						<fmt:formatDate pattern="yyyy-MM-dd (E) HH:mm" value="${NormGameDTO.gametime}" /><br/>
						이용시간 : ${NormGameDTO.usetime}
					</span>
					<div class="game_info">
						<!-- 구장 이름 -->
						<c:choose>
							<c:when test="${isClose}">
								<span class="game_stadium">${NormGameDTO.stadium}
									<c:if test="${NormGameDTO.writer != null}"><c:if test="${NormGameDTO.writer == logId}"> (개설)</c:if></c:if>
								</span>
							</c:when>
							<c:otherwise>
								<a href="detail?no=${NormGameDTO.no}" class="game_stadium">${NormGameDTO.stadium}
									<c:if test="${NormGameDTO.writer != null }"><c:if test="${NormGameDTO.writer == logId}"> (개설)</c:if></c:if>
								</a>
							</c:otherwise>
						</c:choose>
						
						<!-- 경기 조건 -->
						<div class="game_conditions">
							<!-- 성별 유형 -->
							<span class="game_condition">${NormGameDTO.gendertype}</span>
							
							<!-- 몇 대 몇 -->
							<!-- 한 팀당 인원수를 구하기 위해 min_people을 2로 나누고 정수로 변환한다. -->
							<fmt:parseNumber var="oneTeamNumber" integerOnly="true" value="${NormGameDTO.min_people/2}" />
							<span class="game_condition">${oneTeamNumber}vs${oneTeamNumber}</span>
							
							<!-- 인원 정보 -->
							<span class="game_condition">참여인원 ${NormGameDTO.curr_people} / ${NormGameDTO.max_people}</span>
							
							<!-- 최소 인원 -->
							<span class="game_condition">최소인원 ${NormGameDTO.min_people} 명</span>
						</div>
					</div>
				</div>
				
				<!-- 경기 신청 가능 상태 -->
				<c:choose>
					<c:when test="${isClose || (NormGameDTO.curr_people >= NormGameDTO.max_people)}">
		            	<div class="game-status close"><span>신청마감</span></div>
		         	</c:when>
		         	<c:when test="${isImminent}">
		            	<div class="game-status imminent"><a href="detail?no=${NormGameDTO.no}" class="game_stadium2">마감임박</a></div>
		         	</c:when>
		         	<c:otherwise>
		            	<div class="game-status open"><a href="detail?no=${NormGameDTO.no}" class="game_stadium2">신청가능</a></div>
		         	</c:otherwise>
		      	</c:choose>
			</li>
		</c:forEach>
	</ul>
</div>