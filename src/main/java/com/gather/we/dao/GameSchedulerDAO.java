package com.gather.we.dao;

import java.util.List;

import com.gather.we.dto.GameSchedulerDTO;

public interface GameSchedulerDAO {
	// 랭크경기상태 업데이트가 필요한 경기 목록 선택
	public List<GameSchedulerDTO> statusUpdateListSelect();
	// 랭크경기상태 업데이트
	public int statusUpdate(GameSchedulerDTO dto);
	// 일반경기상태 업데이트가 필요한 경기 목록 선택
	public List<GameSchedulerDTO> normStatusUpdateListSelect();
	// 일반경기상태 업데이트
	public int normStatusUpdate(GameSchedulerDTO dto);
}
