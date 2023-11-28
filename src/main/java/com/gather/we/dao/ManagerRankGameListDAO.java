package com.gather.we.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gather.we.dto.MRankGameListCriteria;
import com.gather.we.dto.ManagerRankGameDTO;
import com.gather.we.dto.ManagerRankGameListDTO;

public interface ManagerRankGameListDAO {
	public List<ManagerRankGameListDTO> rankGameListAllSelect(); //랭크게임 리스트

	public int updateApply(ManagerRankGameDTO rankGameDTO) throws Exception; //랭크게임 신청
	
	public List<ManagerRankGameListDTO> getListWithPaging(@Param("criteria") MRankGameListCriteria criteria, @Param("logS_no") Integer logS_no); //랭크게임 페이징
	
	public int getTotalCount(Integer logS_no);//전체 랭크게임 개수

	public int insertApply(ManagerRankGameDTO rankGameDTO) throws Exception; // m_settlement데이터 insert
}
