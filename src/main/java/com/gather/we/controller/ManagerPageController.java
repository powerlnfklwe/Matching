package com.gather.we.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gather.we.dto.MRankGameListCriteria;
import com.gather.we.dto.MSettlementCriteria;
import com.gather.we.dto.MSettlementPageDTO;
import com.gather.we.dto.ManagerInfoDTO;
import com.gather.we.dto.ManagerPagingVO;
import com.gather.we.dto.ManagerRankGameDTO;
import com.gather.we.dto.PageDTO;
import com.gather.we.service.ManagerInfoService;
import com.gather.we.service.ManagerRankGameListService;
import com.gather.we.service.ManagerSettlementService;


@Controller
@RequestMapping("/manager/*")
public class ManagerPageController{
	@Autowired
	ManagerRankGameListService rankGameListService;
	
	@Autowired
	ManagerSettlementService mSettlementService;
	
	//매니저 랭크 경기 목록
	@GetMapping("/rankgamelist")
	public String list(HttpServletResponse res, HttpSession session, MRankGameListCriteria criteria, Model model) throws IOException {
		if (session == null || session.getAttribute("logS_no") == null) return "redirect:/loginMan";
		//DB에서 가져오기 - criteria 데이터만 필요
		model.addAttribute("gamelist", rankGameListService.rankGameListAllSelect(criteria,(Integer) session.getAttribute("logS_no") ));
		//화면에 필요한 정보 가져오기, 계산하기(생성자에서 처리)
		int total = rankGameListService.getTotalCount((Integer) session.getAttribute("logS_no"));
		model.addAttribute("pageMaker", new PageDTO(criteria, total));
		return "manager/rankgamelist";
	}
	
	
	//매니저 랭크 경기 신청 모달
	@PostMapping("/apply")
	public ResponseEntity<?> apply(ManagerRankGameDTO rankGameDTO, HttpSession session) {
		try {
			
			String userId = (String)session.getAttribute("logId");
			rankGameDTO.setManagerid(userId);
			
			if (rankGameListService.updateApply(rankGameDTO) > 2) {		// update, insert 시 리턴 값이 2보다 클 경우 2개모두 성공하여야함
				// 성공
				return ResponseEntity.ok().body(rankGameDTO);
			} else {
				// 실패
				// 둘중 하나가 실패할경우 Rollback이 필요할 수도
				return new ResponseEntity<>("99", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		} catch (Exception e) {
			// 예외처리
			e.printStackTrace();
			return new ResponseEntity<>("99", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	//매니저 정산 내역
	@GetMapping("/settlement")
	public void settlement(HttpSession session, Model model, MSettlementCriteria mscriteria){
		
			String logId = (String)session.getAttribute("logId");
			model.addAttribute("settlement", mSettlementService.mSettlementAllSelect(mscriteria,logId));
			int total = mSettlementService.getTotalCount(mscriteria,logId);
			model.addAttribute("pageMaker", new MSettlementPageDTO(mscriteria, total));
			model.addAttribute("completedamount", mSettlementService.getTotalCompletedAmount(logId));
			model.addAttribute("inprogressamount", mSettlementService.getTotalInprogressAmount(logId));
		
	}
	
	//매니저 로그아웃
	@GetMapping("/logout")
	public String logout(Model model, HttpSession session) {
		session.setAttribute("logId", null);
		session.setAttribute("logName", null);
		session.setAttribute("logStatus", "N");
		session.setAttribute("logS_no", null);
		return "redirect:/loginMan";
	}
	
	
	
	@Autowired
	ManagerInfoService service;
	
	@GetMapping("/managerInfo")
	public ModelAndView getManagerInfo(ManagerPagingVO vo, HttpSession session) {
		   
			ModelAndView mav = new ModelAndView();
			
			String managerid = String.valueOf(session.getAttribute("logId"));
			vo.setOnePageRecord(4);
		    vo.setTotalRecord(service.getTotalRecordByManagerid(managerid));
		  	vo.setManagerid(managerid);
		    mav.addObject("managerList", service.pageSelect(vo));
		    mav.addObject("vo", vo);
		    mav.setViewName("/manager/managerInfo");
		    
		    return mav;
		}

	
	@PostMapping("/managerInfo")
	@ResponseBody
	public ResponseEntity<String> updateRankGame(@RequestBody List<ManagerInfoDTO> managerList) {		    
	    try {
	        for (ManagerInfoDTO manager : managerList) {
	            Integer no = Integer.valueOf(manager.getNo());
	            String managerid = manager.getManagerid();
	            if (managerid != null && no != null) {
	                // rank_game 테이블에서 managerid를 null로 업데이트
	            	service.deleteMSettlement(managerid, no);
	            	service.updateRankGame(managerid, no);
	                // m_settlement 테이블에서 해당 정보 삭제
	            }
	        }
	        return new ResponseEntity<String>("ok", HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("manager delete fail");
	        return new ResponseEntity<String>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
		

	 
	 @GetMapping("/managerPast")
	 public ModelAndView getAllManagerPast(ManagerPagingVO vo,	HttpSession session) {
	
		 ModelAndView mav = new ModelAndView();
		 
	     String managerid = String.valueOf(session.getAttribute("logId"));
	     vo.setOnePageRecord(6);
	     vo.setTotalRecord(service.getTotalRecordByManageridInfo(managerid));
	     vo.setManagerid(managerid);
	 //    vo.getAllManagerPast(vo, managerid, no);
	  //   vo.pageSelect(vo);
			
		    mav.addObject("managerList", service.getAllManagerPast(vo));
		    mav.addObject("vo", vo);
		    mav.setViewName("/manager/managerPast");
       
	    return mav;
	    
        }  
	
		 @GetMapping("/managerInput")
		 public ModelAndView getAllManagerInput(@RequestParam(name = "no", defaultValue = "0") Integer no) {
		     ModelAndView mav = new ModelAndView();
		     
		     // 1. 해당 경기에 참여한 회원 정보를 가져옴.
		     List<ManagerInfoDTO> managerInputList = service.getAllManagerInput(no);
		 
		     if (managerInputList.isEmpty()) { // 데이터베이스 조회 결과가 비어있을 경우
		         mav.addObject("error", "데이터가 없습니다.");
		     } else { // 조회된 데이터가 있는 경우
		         mav.addObject("managerInputList", managerInputList);
		     }
		     
		    mav.addObject("managerInputList", managerInputList);
		     mav.addObject("no", no);
		     mav.setViewName("/manager/managerInput");

		     return mav;
		 }
		
		
		 @PostMapping("/managerInput")
		 @ResponseBody
		 public ResponseEntity<String> updateRank(@RequestBody List<ManagerInfoDTO> ManagerInputList) {	
			 
		     try {
		         for (ManagerInfoDTO ManagerInput : ManagerInputList) {
		        	 
		        	 Integer no = Integer.valueOf(ManagerInput.getNo());
		        	 if (no != null) {
		        		   // null이 아닌 경우에만 처리
		        		   no = Integer.valueOf(no); // Integer 객체로 변환
		             service.updateRank(ManagerInput.getUserid(), ManagerInput.getRank(), ManagerInput.getNo());
		             
		        	 }
		         }
		         return new ResponseEntity<String>("ok", HttpStatus.OK);
		     }  catch (Exception e) {
		    	 e.printStackTrace();
		    	 System.out.println("manager rank input fail");
		     }
		     return new ResponseEntity<String>("ok", HttpStatus.OK);
		 }
		
		 
		 @GetMapping("/entry")
		 public ModelAndView getAllEntry(@RequestParam(name = "no", defaultValue = "0") Integer no) {
		     ModelAndView mav = new ModelAndView();
		     
		     // 1. 해당 경기에 참여한 회원 정보를 가져옵니다.
		     List<ManagerInfoDTO> entryList = service.getAllEntry(no);
		     
		     if (entryList.isEmpty()) { // 데이터베이스 조회 결과가 비어있을 경우
		         mav.addObject("error", "데이터가 없습니다.");
		     } else { // 조회된 데이터가 있는 경우
		         mav.addObject("entryList", entryList);
		     }
		     
		     // 반복문, session 에 있는 s_no 정보를 entryList 의 s_no 에 저장
		     
		     
		     mav.addObject("entryList", entryList);
		     mav.addObject("no", no);
		     mav.setViewName("/manager/entry");

		     return mav;
		 }
		 }
