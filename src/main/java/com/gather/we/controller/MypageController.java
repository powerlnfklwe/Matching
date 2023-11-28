package com.gather.we.controller;

import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gather.we.dto.MypageApplyListDTO;
import com.gather.we.dto.MypagePaymentDTO;
import com.gather.we.dto.MypageRankDTO;
import com.gather.we.dto.MypageUserDTO;
import com.gather.we.dto.PagingVO;
import com.gather.we.service.MypageService;


@RestController
public class MypageController {
	
	@Autowired
	MypageService service;

	@GetMapping("/mypage/applyList") 
	public ModelAndView applyList(HttpSession session, PagingVO vo) {
		
		//System.out.println(vo.toString());
		ModelAndView mav = new ModelAndView();
		
		//userid가 logId랑 같은지 확인
		String logId = (String)session.getAttribute("logId");
		vo.setUserid(logId);
		vo.setOnePageRecord(8); // 한 페이지에 출력될 레코드 수
		vo.setOnePageNumCount(5); // 표시할 페이지 수
		vo.setTotalRecord(service.allTotalRecord(logId));
		
		List<MypageApplyListDTO> list = service.allgameList(vo);
		//System.out.println("list->"+list);
		Date now = new Date();
		
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("vo", vo);
		mav.setViewName("user/mypage/applyList");		
			
		return mav;
	}
	
	//경기취소 클릭하면 경기목록에서 삭제 + 결제내역에서 삭제
	@GetMapping("/mypage/cancel")
	public ModelAndView gameCancel(HttpSession session, MypageApplyListDTO dto) {
		
		ModelAndView mav = new ModelAndView();
		
		dto.setUserid((String)session.getAttribute("logId"));
		System.out.println(dto.toString());

		int result = service.gameCancel(dto);
		System.out.println("result->"+result);
		
		if(result>0) {//삭제성공 -> 리스트 이동
			mav.setViewName("redirect:applyList");
		}else {//삭제실패 -> 리스트로 이동
			mav.addObject("no",dto.getNo());
			mav.setViewName("redirect:applyList");
		}
		return mav;
	}
	
	@GetMapping("/mypage/rankList")
	public ModelAndView rankList(HttpSession session, PagingVO vo) {
		ModelAndView mav = new ModelAndView();
		
		String logId = (String)session.getAttribute("logId");
		vo.setUserid(logId);
		vo.setOnePageRecord(8); // 한 페이지에 출력될 레코드 수
		vo.setOnePageNumCount(5); // 표시할 페이지 수
		vo.setTotalRecord(service.allTotalRecord(logId));

		List<MypageApplyListDTO> list = service.rankgameList(vo);
		Date now = new Date();

		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("vo", vo);
		mav.setViewName("user/mypage/rankList");
		return mav;
	}
	
	@GetMapping("/mypage/rankCancel")
	public ModelAndView rankCancel(HttpSession session, MypageApplyListDTO dto) {
		
		ModelAndView mav = new ModelAndView();
		
		dto.setUserid((String)session.getAttribute("logId"));
		System.out.println(dto.toString());

		int result = service.gameCancel(dto);
		System.out.println("result->"+result);
		
		if(result>0) {//삭제성공 -> 리스트 이동
			mav.setViewName("redirect:rankList");
		}else {//삭제실패 -> 리스트로 이동
			mav.addObject("no",dto.getNo());
			mav.setViewName("redirect:rankList");
		}
		return mav;
	}
	
	
	@GetMapping("/mypage/normList")
	public ModelAndView normList(HttpSession session, PagingVO vo) {
		ModelAndView mav = new ModelAndView();
		
		String logId = (String)session.getAttribute("logId");
		vo.setUserid(logId);
		vo.setOnePageRecord(8); // 한 페이지에 출력될 레코드 수
		vo.setOnePageNumCount(5); // 표시할 페이지 수
		vo.setTotalRecord(service.normTotalRecord(logId));
		
		List<MypageApplyListDTO> list = service.normgameList(vo);
		Date now = new Date();

		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("vo", vo);
		mav.setViewName("user/mypage/normList");
		return mav;
	}
	
	@GetMapping("/mypage/normkCancel")
	public ModelAndView normCancel(HttpSession session, MypageApplyListDTO dto) {
		
		ModelAndView mav = new ModelAndView();
		
		dto.setUserid((String)session.getAttribute("logId"));
		System.out.println(dto.toString());

		int result = service.gameCancel(dto);
		System.out.println("result->"+result);
		
		if(result>0) {//삭제성공 -> 리스트 이동
			mav.setViewName("redirect:normList");
		}else {//삭제실패 -> 리스트로 이동
			mav.addObject("no",dto.getNo());
			mav.setViewName("redirect:normList");
		}
		return mav;
	}
	
	@GetMapping("/mypage/rank")
	public ModelAndView rank(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String logId = (String)session.getAttribute("logId");
		
		MypageRankDTO dto = new MypageRankDTO();
		
		List<MypageRankDTO> list = service.rankResult(logId);
		//System.out.println("list->"+list);

		//no Rank인 경우, list에 담긴 값이 없어 list.get(0)하면 에러발생
		//	-> try-catch문 쓰자
		try { //rank가 있는 경우
		
			dto.setAvg_all(list.get(0).getAvg_all());
			
			//System.out.println("list--->: "+ list);
			//System.out.println("alll: "+dto.getAvg_all());
			
			mav.addObject("list", list);
			mav.addObject("dto", dto);
			mav.setViewName("user/mypage/rank");
			
		}catch(Exception e){ //rank가 없는 경우
			
			mav.addObject("list",list);
			mav.addObject("dto", dto);
			mav.setViewName("user/mypage/rank");
		}
		
		return mav;
	}
	
	
	
	@PostMapping(value="/mypage/rankMain", produces="application/text;charset=UTF-8") 
	public String rankMain(HttpSession session, String sportname) {
		
		//System.out.println(sportname);
		String logId = (String)session.getAttribute("logId");

		List<MypageRankDTO> list = service.rank(logId, sportname);
		//System.out.println("list111-> "+list );
		
		Collections.reverse(list);
		
		int n = list.size();
		//System.out.println("n->"+n);
		
		//json형태로 뷰로 내보내기
		ObjectMapper mapper = new ObjectMapper(); 
		String json ="";
		
		try { 
			json = mapper.writeValueAsString(list); 
		}catch(Exception e) {
			e.printStackTrace(); } 
		
		return json;
	}
	
	@GetMapping("/mypage/paymentList")
	public ModelAndView paymentList(HttpSession session, PagingVO vo) {
		ModelAndView mav = new ModelAndView();
		String logName = (String)session.getAttribute("logName");
		vo.setUsername(logName);
		vo.setOnePageRecord(8); // 한 페이지에 출력될 레코드 수
		vo.setOnePageNumCount(5); // 표시할 페이지 수
		vo.setTotalRecord(service.paymentTotalRecord(logName));
		
		List<MypagePaymentDTO> list = service.paymentList(vo);
		//System.out.println("list: "+ list);
		
		mav.addObject("list", list);
		mav.addObject("vo", vo);
		mav.setViewName("user/mypage/paymentList");
		return mav;
	}
	
	@GetMapping("/mypage/info")
	public ModelAndView info(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String logId = (String)session.getAttribute("logId");
		MypageUserDTO dto = service.getUserinfo(logId);
		
		mav.addObject("dto", dto);
		mav.setViewName("user/mypage/info");
		return mav;
	}
	
	@PostMapping("mypage/infoEdit")
	public ResponseEntity<String> infoEdit(MypageUserDTO dto, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		dto.setUserid((String)session.getAttribute("logId"));
		//System.out.println("여기다 "+dto.getUserid());

		try {
			int cnt = service.infoEdit(dto);
			//정보수정 성공
			String body = "<script>";
			body += "alert('회원정보 수정이 완료되었습니다.');";
			body += "location.href='info';";
			body += "</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.OK);
		}catch(Exception e) {
			//정보수정 실패
			e.printStackTrace();
			String body = "<script>";
			body += "alert('회원정보 수정이 실패하였습니다.');";
			body += "history.back();";
			body += "</script>";
			entity =  new ResponseEntity<String>(body, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}	