package com.gather.we.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gather.we.dto.RParticipateDTO;
import com.gather.we.dto.RankGameDTO;
import com.gather.we.dto.RankGameDetailDTO;
import com.gather.we.dto.RankGameListDTO;
import com.gather.we.dto.SportDTO;
import com.gather.we.service.ParticipateService;
import com.gather.we.service.RankGameService;
import com.gather.we.service.SportService;

@RestController
@RequestMapping("/rankgame")
public class RankGameController {
	@Autowired
	SportService sportService;
	@Autowired
	RankGameService rankGameService;
	@Autowired
	ParticipateService participateService;

	// 종목 목록
	@GetMapping("/sportlist")
	public ModelAndView sportList() {
		ModelAndView mav = new ModelAndView();
		
		List<SportDTO> sportList = sportService.sportAllSelect();
		
		mav.addObject("sportList", sportList);
		mav.setViewName("user/rankGame/sportList");
		
		return mav;
	}
	
	// 랭크경기 목록
	@GetMapping("/rankgamelist")
	public ModelAndView rankGameList(RankGameListDTO dto) { 
		ModelAndView mav = new ModelAndView();

		// 지역 필터링 시 DB에서 해당 지역의 경기만 선택하여 가져오기 위해 지역 카테고리를 세부 지역으로 나누어 리스트에 담는다.
		String region = dto.getRegion();// '대전/세종/충청'

		if(region!=null) {
			List<String> regionList = Arrays.asList(region.split("/"));// ['���쟾', '�꽭醫�', '異⑹껌']
			dto.setRegionList(regionList);
		}
		
		// DB에서 랭크경기 목록 가져오기
		List<RankGameDTO> rankGameList = rankGameService.rankGameListSelect(dto);

		mav.addObject("s_no", dto.getS_no());
		mav.addObject("rankGameList", rankGameList);
		mav.setViewName("user/rankGame/rankGameList");
		
		return mav;
	}
	
	// 랭크경기 상세페이지
	@GetMapping("/detail")
	public ModelAndView rankGameDetail(@RequestParam("no") int no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String logId = (String) session.getAttribute("logId");
		int isPart;
		
		// 해당 경기에 로그인 사용자가 참가하였는지 여부 (1이면 Yes, 0이면 No)
		if(logId == null || logId.equals("")) {
			isPart = 0;
		} else {
			isPart = participateService.isRankParticipate(logId, no);
		}
		
		String userid = logId;
		
		// DB에서 랭크경기 상세 정보 가져오기
		RankGameDetailDTO rankGameDetail = rankGameService.rankGameDetailSelect(no);
		
		Integer userRank = null;
		if(userid!=null) {
			// 해당 종목의 사용자 랭크 가져오기
			userRank = participateService.userRankOfSport(userid, rankGameDetail.getS_no());
			if(userRank==null) {
				userRank = 0;
			}
		}
		
		mav.addObject("rankGameDetail", rankGameDetail);
		mav.addObject("userRank", userRank);
		mav.addObject("isPart", isPart);
		mav.setViewName("user/rankGame/rankGameDetail");
		
		return mav;
	}
}
