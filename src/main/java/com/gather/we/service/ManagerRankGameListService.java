package com.gather.we.service;

import java.util.List;
import java.util.Map;

import com.gather.we.dto.MRankGameListCriteria;
import com.gather.we.dto.ManagerRankGameDTO;
import com.gather.we.dto.ManagerRankGameListDTO;

public interface ManagerRankGameListService {
	public List<ManagerRankGameListDTO> rankGameListAllSelect(MRankGameListCriteria criteria, Integer logS_no);//랭크게임 리스트, 페이징

	public int updateApply(ManagerRankGameDTO rankGameDTO) throws Exception;//랭크게임 신청
	
	public int getTotalCount(Integer logS_no);//랭크게임 레코드 수
	
}
