package com.gather.we.scheduler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gather.we.dto.GameSchedulerDTO;
import com.gather.we.service.GameSchedulerService;

@Component
public class GameScheduler {
	@Autowired
	GameSchedulerService service;
	
	// 매일 0시에 자동으로 실행되는 스케줄러
	// 경기 참여신청 마감 구현
	@Scheduled(cron = "0 0 0 1/1 * ?")
	public void autoGameStatusUpdate() throws Exception {
		// 경기일정의 이틀 전 0시에 해당 경기의 참여신청을 마감한다.
		// 오늘이 4월 22일 이라면 경기일정이 4월 24일인 경기목록을 가져와서 경기상태를 업데이트 한다.
		// 경기상태: 0(대기), 1(확정), 2(취소)

		List<GameSchedulerDTO> list = service.statusUpdateListSelect();
		
		for(GameSchedulerDTO dto: list) {
			if(dto.getG_status() == 0) {
				if(dto.getCurr_people() >= dto.getMin_people()) { // 경기 확정
					dto.setG_status(1);
				} else { // 인원 미충족으로 인한 경기 취소
					dto.setG_status(2);
				}
				// DB에 경기상태 업데이트
				int result = service.statusUpdate(dto);
				System.out.println(result);
			}
		}
	}
	
	@Scheduled(cron = "0 0 0 1/1 * ?")
	public void autoNormGameStatusUpdate() throws Exception {
		// 경기일정의 하루 전 0시에 해당 경기의 참여신청을 마감한다.
		// 오늘이 4월 22일 이라면 경기일정이 4월 23일인 경기목록을 가져와서 경기상태를 업데이트 한다.
		// 경기상태: 0(미개설), 1(대기), 2(확정), 3(취소)

		List<GameSchedulerDTO> list = service.normStatusUpdateListSelect();
		
		for(GameSchedulerDTO dto: list) {
			if(dto.getG_status() == 1) {
				if(dto.getCurr_people() >= dto.getMin_people()) { // 경기 확정
					dto.setG_status(2);
				} else { // 인원 미충족으로 인한 경기 취소
					dto.setG_status(3);
				}
				// DB에 경기상태 업데이트
				int result = service.normStatusUpdate(dto);
				System.out.println(result);
			}else if(dto.getG_status() == 0) {
				dto.setG_status(3); // 경기날짜의 하루 전까지 경기 개설이 이루어지지 않아 자동 취소
			}
		}
	}
}
