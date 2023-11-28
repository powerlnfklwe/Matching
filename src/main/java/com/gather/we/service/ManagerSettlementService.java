package com.gather.we.service;

import java.util.List;

import com.gather.we.dto.MSettlementCriteria;
import com.gather.we.dto.ManagerSettlementDTO;

public interface ManagerSettlementService {
	public List<ManagerSettlementDTO> mSettlementAllSelect(MSettlementCriteria mscriteria, String logId);//정산내역 리스트, 페이징
	
	public int getTotalCount(MSettlementCriteria mscriteria, String logId);//정산내역 레코드 수
	
	public Integer getTotalCompletedAmount(String logId);//정산내역-완료 합계
	
	public Integer getTotalInprogressAmount(String logId);// 정산내역-처리중 합계
}
