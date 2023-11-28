package com.gather.we.dao;

import java.util.List;

import com.gather.we.dto.RankBoardCriteria;
import com.gather.we.dto.RankBoardDTO;

public interface RankBoardDAO {
	public List<RankBoardDTO> getUserRankList();
	
	public List<RankBoardDTO> getListWithPaging();
	
	public int getTotalCount(RankBoardCriteria criteria);
}
