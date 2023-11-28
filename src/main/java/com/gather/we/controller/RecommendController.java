package com.gather.we.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gather.we.dto.RecommendDTO;
import com.gather.we.dto.UsersDTO;
import com.gather.we.service.RecommendService;
import com.gather.we.service.SportService;
import com.gather.we.service.UsersService;

@RestController
public class RecommendController {
	
	@Autowired
	RecommendService recommendService;
	
	@Autowired
	SportService sportService;
	
	@Autowired
	UsersService usersService;
	
	@GetMapping("/recommend/mbti")
	public ModelAndView recommendByMbti(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid;
		
		try {
			userid = (String)session.getAttribute("logId");
			
			if(userid.equals("admin1")) {
				userid = "admindummy";
			}
		}catch(Exception e) {
			userid = null;
		}
		
		if(userid != null) {
			UsersDTO dto = usersService.userInfoInfoSelect(userid);		
			String userMbti = dto.getMbti();
			mav.addObject("userMbti", userMbti);
		}
		
		// MBTI 목록
		String[] mbtiList = {"ISTP", "ISTJ", "ISFP", "ISFJ", "INTP", "INTJ", "INFP", "INFJ", 
				"ESTP", "ESTJ", "ESFP", "ESFJ", "ENTP", "ENTJ", "ENFP", "ENFJ"};

		// 각 MBTI별 스포츠 통계를 담을 Map 선언
		HashMap<String, List<RecommendDTO>> mbtiStatistics = new HashMap<>();
		
		for(String mbtiType: mbtiList) {
			List<RecommendDTO> statisticsResult = recommendService.mbtiStatisticsSelect(mbtiType);
			mbtiStatistics.put(mbtiType, statisticsResult);
		}
			
		mav.addObject("mbtiList", mbtiList);
		mav.addObject("mbtiStatistics", mbtiStatistics);
		mav.setViewName("user/recommend/recommendMbti");
		
		return mav;
	}
	
	@GetMapping("/recommend/userinfo")
	public ModelAndView recommendByGender(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		String userid = (String)session.getAttribute("logId");
		
		if(userid!=null) {
			UsersDTO dto = usersService.userInfoInfoSelect(userid);
			String userGender = dto.getGender();
			int userAge = dto.getAge();
			String userAgeGroup;
			
			// 사용자의 age를 age group으로 변환
			switch(userAge/10) {
			case 1:
				userAgeGroup = "10대";
				break;
			case 2:
				userAgeGroup = "20대";
				break;
			case 3:
				userAgeGroup = "30대";
				break;
			case 4:
				userAgeGroup = "40대";
				break;
			case 5:
				userAgeGroup = "50대";
				break;
			default:
				userAgeGroup = "60대 이상";
			}
			
			mav.addObject("userAgeGroup", userAgeGroup);
			mav.addObject("userGender", userGender);
		}
		
		// 스포츠 종목 목록 - 이름순
		List<String> sportnameList = sportService.sortedSportnameSelect();
				
		// 스포츠 통계 - 나이
		String[] ageGroup = {"10대", "20대", "30대", "40대", "50대", "60대 이상"};
		List<List<RecommendDTO>> ageStatistics = new ArrayList<>();
		
		for(String age: ageGroup) {
			List<RecommendDTO> statisticsResult = recommendService.ageStatisticsSelect(age);
			ageStatistics.add(statisticsResult);
		}
		
		// 스포츠 통계 - 나이 그룹 별로 비율이 가장 높은 스포츠
		List<RecommendDTO> ageTopStatistics = new ArrayList<>();
		for(String age: ageGroup) {
			RecommendDTO statisticsResult = recommendService.ageTopStatisticsSelect(age);
			ageTopStatistics.add(statisticsResult);
		}
		
		// 스포츠 통계 - 남성
		List<RecommendDTO> manStatistics = recommendService.genderStatisticsSelect("남성");
		
		// 스포츠 통계 - 여성
		List<RecommendDTO> womanStatistics = recommendService.genderStatisticsSelect("여성");
		
		mav.addObject("sportnameList", sportnameList);
		mav.addObject("ageGroup", ageGroup);
		mav.addObject("ageStatistics", ageStatistics);
		mav.addObject("ageTopStatistics", ageTopStatistics);
		mav.addObject("manStatistics", manStatistics);
		mav.addObject("womanStatistics", womanStatistics);
		mav.setViewName("user/recommend/recommendUserInfo");
		
		return mav;
	}
}
