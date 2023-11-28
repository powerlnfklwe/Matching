<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="game_header rank_game_header">
	<span class="game_header_title">랭크경기</span>
</div>
<div class="game_nav"><b>종목선택</b> > 경기목록 > 경기상세정보</div>
<div class="game_container">
	<div class="game_type_container rank">
		<span class="game_type_desc">
			<img src="/static/img/imgMain/quoteLeft.png"/> &emsp;
			랭크경기는 매니저 주관 하에 참여자의 실력이 평가되는 아마추어 경기입니다. &emsp;
			<img src="/static/img/imgMain/quoteRight.png"/>
		</span>
	</div>
	<ul class="sport_list">
		<c:forEach var="sportDTO" items="${sportList}">
			<li class="sport_item">
				<span class="sport_tag">${sportDTO.sportname}</span>
				<img src="${pageContext.request.contextPath}/uploadfile/sport/${sportDTO.filename}" alt="스포츠종목" />
				<div class="sport_desc_container">
					<a href="rankgamelist?s_no=${sportDTO.s_no}">
						<span class="sport_name">${sportDTO.sportname}</span>
						<span>${sportDTO.sportdesc}</span>
					</a>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
