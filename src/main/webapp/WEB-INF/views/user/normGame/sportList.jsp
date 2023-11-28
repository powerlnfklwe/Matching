<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="game_header norm_game_header">
	<span class="game_header_title">일반경기</span>
</div>
<div class="norm_game_nav"><b>종목선택</b> > 경기목록 > 경기상세정보</div>
<div class="game_container">
	<div class="game_type_container norm">
		<span class="normgame_type_desc">
			<img src="/static/img/imgMain/quoteLeft.png"/> &emsp;
			일반경기는 매니저 없이 사용자가 자유롭게 개설할 수 있습니다. &emsp;
			<img src="/static/img/imgMain/quoteRight.png"/>
		</span>
	</div>
	<ul class="sport_list">
		<c:forEach var="sportDTO" items="${sportList}">
			<li class="sport_item">
				<span class="sport_tag norm_game_tag">${sportDTO.sportname}</span>
				<img src="${pageContext.request.contextPath}/uploadfile/sport/${sportDTO.filename}" alt="스포츠종목" />
				<div class="sport_desc_container">
					<a href="normgamelist?s_no=${sportDTO.s_no}">
						<span class="sport_name">${sportDTO.sportname}</span>
						<span>${sportDTO.sportdesc}</span>
					</a>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
