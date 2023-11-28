package com.gather.we.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.RankBoardDAO;
import com.gather.we.dto.RankBoardCriteria;
import com.gather.we.dto.RankBoardDTO;

@Service
public class RankBoardServiceImpl implements RankBoardService{
	
	@Autowired
	private RankBoardDAO rankBoardDAO;	
	
	@Override
	public List<RankBoardDTO> getUserRankList() {
		return rankBoardDAO.getListWithPaging();
	}

	@Override
	public int getTotalCount(RankBoardCriteria criteria) {
		return rankBoardDAO.getTotalCount(criteria);
	}

}
