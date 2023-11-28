package com.gather.we.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.ManagerRankGameListDAO;
import com.gather.we.dto.MRankGameListCriteria;
import com.gather.we.dto.ManagerRankGameDTO;
import com.gather.we.dto.ManagerRankGameListDTO;

@Service
public class ManagerRankGameListServiceImpl implements ManagerRankGameListService{
	@Autowired
	ManagerRankGameListDAO dao;
	
	
	@Override
	public List<ManagerRankGameListDTO> rankGameListAllSelect(MRankGameListCriteria criteria, Integer logS_no) {
		return dao.getListWithPaging(criteria, logS_no);
	}

	@Override
	public int updateApply(ManagerRankGameDTO rankGameDTO) throws Exception {
		int succCnt = dao.updateApply(rankGameDTO);
		if (succCnt > 0) {
			succCnt += dao.insertApply(rankGameDTO);
		}
		return succCnt;
	}

	@Override
	public int getTotalCount(Integer logS_no) {
		return dao.getTotalCount(logS_no);
	}

	

}
