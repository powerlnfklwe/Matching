package com.gather.we.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gather.we.dto.NParticipateDTO;
import com.gather.we.dto.NormGameDetailDTO;
import com.gather.we.dto.RParticipateDTO;
import com.gather.we.dto.RankGameDetailDTO;
import com.gather.we.dto.UserPayDTO;
import com.gather.we.dto.UserPayDoneDTO;
import com.gather.we.dto.UsersDTO;
import com.gather.we.service.NormalGameService;
import com.gather.we.service.ParticipateService;
import com.gather.we.service.RankGameService;
import com.gather.we.service.UserPayService;
import com.gather.we.service.UsersService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@RestController
public class UserPayController {
	@Autowired
	RankGameService rankGameService;
	
	@Autowired
	NormalGameService normalGameService;
	
	@Autowired
	UsersService usersService;
	
	@Autowired
	UserPayService userPayService;
	
	@Autowired
	ParticipateService participateService;
	
	// 결제페이지
	@GetMapping("/payment")
	public ModelAndView makePayment(int no, String gametype, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String userid = (String)session.getAttribute("logId");
		
		if(gametype.equals("rankgame")) {
			RankGameDetailDTO rankGameDetail = rankGameService.rankGameDetailSelect(no);
			mav.addObject("gameDetail", rankGameDetail);
		} else if(gametype.equals("normgame")) {
			NormGameDetailDTO normGameDetail = normalGameService.normGameDetailSelect(no);
			mav.addObject("gameDetail", normGameDetail);
		}
		
		UsersDTO participantInfo = usersService.participantInfoSelect(userid);
		
		mav.addObject("gametype", gametype);
		mav.addObject("participantInfo", participantInfo);
		mav.setViewName("user/payment/payment");
		
		return mav;
	}
	
	// 결제(DB)
	@PostMapping("/paymentOk")
	public String makePaymentOk(int no, String gametype, String payment_no, String payer_name, int paid_amount, 
			int paid_at, String success, HttpSession session) {
		
		String userid = (String)session.getAttribute("logId");
		
		try {
			UserPayDTO userPayDTO = new UserPayDTO();
			userPayDTO.setPayment_no(payment_no);
			userPayDTO.setPayer_name(payer_name);
			userPayDTO.setPaid_amount(paid_amount);
			userPayDTO.setPaid_at(paid_at);
			userPayDTO.setSuccess(success);
			// 사용자결제 테이블에 결제내역 저장
			int userPayResult = userPayService.userPayInsert(userPayDTO);
		    if(userPayResult<=0) {
		    	throw new Exception("사용자 결제내역 저장을 실패하였습니다.");			    	
		    }
		    
			// 경기유형이 랭크경기인 경우
			if(gametype.equals("rankgame")) {
				RParticipateDTO rParticipateDTO = new RParticipateDTO();
				rParticipateDTO.setUserid(userid);
				rParticipateDTO.setNo(no);
				rParticipateDTO.setPayment_no(payment_no);
				
				// 랭크경기참여 테이블에 데이터 저장
				int rParticipateResult = participateService.rParticipateInsert(rParticipateDTO);
				
				// 랭크경기 테이블에 현재 인원수 업데이트
				int currPeopleCountResult = rankGameService.currPeopleCount(no);
				
			    if(rParticipateResult<=0) {
			    	throw new Exception("랭크경기 참여내역 저장을 실패하였습니다.");	    	
			    } else if(currPeopleCountResult<=0) {
			    	throw new Exception("�랭크경기 현재인원수 업데이트를 실패하였습니다.");    	
			    }
			} else if(gametype.equals("normgame")) {
			// 경기유형이 일반경기인 경우
				NParticipateDTO nParticipateDTO = new NParticipateDTO();
				nParticipateDTO.setUserid(userid);
				nParticipateDTO.setNo(no);
				nParticipateDTO.setPayment_no(payment_no);
				
				// 일반경기참여 테이블에 데이터 저장
				int nParticipateResult = participateService.nParticipateInsert(nParticipateDTO);
				
				// 일반경기 테이블에 현재 인원수 업데이트
				int currPeopleCountResult = normalGameService.currPeopleCount(no);
				
			    if(nParticipateResult<=0) {
			    	throw new Exception("일반경기 참여내역 저장을 실패하였습니다.");	    	
			    } else if(currPeopleCountResult<=0) {
			    	throw new Exception("일반경기 현재인원수 업데이트를 실패하였습니다.");    	
			    }
			}
		} catch (Exception e)    {
			    System.out.println("err_msg : " + e.getMessage());
			    e.printStackTrace();
		}
		
		// 결제번호와 경기유형을 json으로 저장하여 뷰페이지에 전달 
		JsonObject jsonObj = new JsonObject();
		jsonObj.addProperty("payment_no", payment_no);
		jsonObj.addProperty("gametype", gametype);

		return new Gson().toJson(jsonObj);
	}
	
	// 결제완료 페이지
	@GetMapping("/payment/paymentDone")
	public ModelAndView completePayment(String payment_no, String gametype) {
		ModelAndView mav = new ModelAndView();
		
		// 결제완료 페이지에 보여줄 경기정보와 결제금액을 db에서 받아오기
		UserPayDoneDTO payDoneInfo = null;
		
		if(gametype.equals("rankgame")) {
			payDoneInfo = userPayService.rankPayDoneSelect(payment_no);
		} else if(gametype.equals("normgame")) {
			payDoneInfo = userPayService.normPayDoneSelect(payment_no);
		}
		
		mav.addObject("gametype", gametype);
		mav.addObject("payDoneInfo", payDoneInfo);
		mav.setViewName("user/payment/paymentDone");
		
		return mav;
	}
}