package com.gather.we.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gather.we.dto.MSettlementCriteria;
import com.gather.we.dto.ManagerSettlementDTO;

public interface ManagerSettlementDAO {
	
	public List<ManagerSettlementDTO> mSettlementAllSelect();//정산내역 목록
	
	public List<ManagerSettlementDTO> getListWithPaging(@Param("mscriteria")MSettlementCriteria mscriteria, @Param("logId")String logId); //정산내역 페이징
	
	public int getTotalCount(@Param("mscriteria") MSettlementCriteria mscriteria, @Param("logId") String logId);//전체 정산내역 개수
	
	public Integer selectCompletedAmount(String logId);//정산내역-완료 합계
	
	public Integer selectInprogressAmount(String logId);//정산내역-처리중 합계
}
