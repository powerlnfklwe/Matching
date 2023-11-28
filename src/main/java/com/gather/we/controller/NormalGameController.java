package com.gather.we.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gather.we.dto.NormGameDTO;
import com.gather.we.dto.NormGameDetailDTO;
import com.gather.we.dto.NormGameListDTO;
import com.gather.we.dto.SportDTO;
import com.gather.we.dto.StadiumInfoDTO;
import com.gather.we.dto.StadiumInfoDTO2;
import com.gather.we.service.NormalGameService;
import com.gather.we.service.ParticipateService;
import com.gather.we.service.SportService;
import com.gather.we.service.StadiumInfoService;

@RestController
@RequestMapping("/normgame")
public class NormalGameController {
	@Autowired
	SportService sportService;
	@Autowired
	NormalGameService normGameService;
	@Autowired
	StadiumInfoService stadiumService;
	@Autowired
	ParticipateService participateService;
	
	// 종목보기
	@GetMapping("/sportlist")
	public ModelAndView sportList() {
		ModelAndView mav = new ModelAndView();
		
		List<SportDTO> sportList = sportService.sportAllSelect();
		
		mav.addObject("sportList", sportList);
		mav.setViewName("user/normGame/sportList");
		
		return mav;
	}
	
	// 일반경기 목록
	@GetMapping("/normgamelist")
	public ModelAndView normGameList(NormGameListDTO dto) { 
		ModelAndView mav = new ModelAndView();
		
		String region = dto.getRegion();
		if(region!=null) {
			List<String> regionList = Arrays.asList(region.split("/"));
			dto.setRegionList(regionList);
		}
		
		List<NormGameDTO> normGameList = normGameService.normGameListSelect(dto);

		mav.addObject("s_no", dto.getS_no());
		mav.addObject("normGameList", normGameList);
		mav.setViewName("user/normGame/normGameList");
		
		return mav;
	}
	
	// 일반경기 상세페이지
	@GetMapping("/detail")
	public ModelAndView normGameDetail(HttpSession session, int no) {
		ModelAndView mav = new ModelAndView();
		String logId = (String) session.getAttribute("logId");
		
		int isPart;
		
		// 해당 경기에 로그인 사용자가 참가하였는지 여부 (1이면 Yes, 0이면 No)
		if(logId == null || logId.equals("")) {
			isPart = 0;
		}else {
			isPart = participateService.isNormParticipate(logId, no);
		}
		
		// 일반경기 상세 정보 (DB)
		NormGameDetailDTO normGameDetail = normGameService.normGameDetailSelect(no);

		mav.addObject("normGameDetail", normGameDetail);
		mav.addObject("isPart", isPart);
		mav.setViewName("user/normGame/normGameDetail");
		
		return mav;
	}
	
	// 일반경기 개설 페이지
	@GetMapping("/new")
	public ModelAndView normGameNew(int s_no, StadiumInfoDTO2 dto) {
		ModelAndView mav = new ModelAndView();
		
		int st_no = dto.getSt_no();
		
		if(dto.getRegion() == null || dto.getRegion().equals("")) {
			dto.setRegion("서울");
		} // 초기값 서울로 지정
		
		if(st_no != 0) {
			
			// DB에서 미개설된 일반경기 정보 받아오기
			List<NormGameDetailDTO> newNormGameList = normGameService.newNormGameList(st_no);
			
			mav.addObject("newNormGameList", newNormGameList);
		}
		
		// 존재하는 구장 정보 받아오기
		List<StadiumInfoDTO2> stadiumList = stadiumService.stadiumInfoAllSelect2();
		
		// 스포츠 종목 정보 받아오기
		SportDTO sportDTO =  sportService.sportOneSelect(s_no);
		
		mav.addObject("stadiumList", stadiumList);
		mav.addObject("sportDTO", sportDTO);
		mav.addObject("stadiumDTO", dto);
		mav.setViewName("user/normGame/normGameNew");
		
		return mav;
	}
	
	// 일반경기 개설 - 사용자 입력 페이지
	@GetMapping("/newdetail")
	public ModelAndView normGameNewDetail(int no, int s_no) {
		ModelAndView mav = new ModelAndView();
		
		NormGameDetailDTO normGameDTO = normGameService.normGameDetailSelect(no);
		SportDTO sportDTO = sportService.sportOneSelect(s_no);
		
		mav.addObject("normGameDTO", normGameDTO);
		mav.addObject("sportDTO", sportDTO);
		mav.setViewName("user/normGame/normGameNewDetail");
		return mav;
	}
	
	// 일반경기 개설 (DB등록)
	@PostMapping("/newdetailOk")
	public ResponseEntity<String> normGameNewDetailOk(NormGameDTO dto, HttpServletRequest request){
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		HttpSession session = request.getSession();
		
		String logStatus = (String) session.getAttribute("logStatus");
		String logId = null;
		if(logStatus == "Y") {
			 logId = (String) session.getAttribute("logId");
		}
		
		headers.add("Content-Type", "text/html; charset=utf-8");
		try {
			if(logStatus == "Y") {
				dto.setWriter(logId);
			}else {
				throw new Exception();
			}
			
			// 사용자가 작성한 정보를 DB에 저장
			normGameService.normGameUpdate(dto);
			
			// 일반경기 목록으로 이동
			String body = "<script> alert('일반경기를 개설하였습니다. 목록에서 확인 후 참가신청하세요.'); location.href='/normgame/normgamelist?s_no="+dto.getS_no()+"';</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.OK);
		}catch(Exception e) {
			// 일반경기 등록 실패
			e.printStackTrace();
			String body = "<script>";
			body += "alert('일반경기 개설을 실패하였습니다.');";
			body += "history.go(-1);";
			body += "</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
