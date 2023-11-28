package com.gather.we.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.ManagerSettlementDAO;
import com.gather.we.dto.MSettlementCriteria;
import com.gather.we.dto.ManagerSettlementDTO;

@Service
public class ManagerSettlementServiceImpl implements ManagerSettlementService {

	@Autowired
	ManagerSettlementDAO dao;
	
	@Override
	public List<ManagerSettlementDTO> mSettlementAllSelect(MSettlementCriteria mscriteria, String logId) {
		return dao.getListWithPaging(mscriteria, logId);
	}

	@Override
	public int getTotalCount(MSettlementCriteria mscriteria, String logId) {
		return dao.getTotalCount(mscriteria, logId);
	}

	@Override
	public Integer getTotalCompletedAmount(String logId){
		Integer completedAmount = dao.selectCompletedAmount(logId);
		return completedAmount != null ? completedAmount : 0;
	}

	@Override
	public Integer getTotalInprogressAmount(String logId){
		Integer inprogressAmount = dao.selectInprogressAmount(logId);
		return inprogressAmount != null ? inprogressAmount : 0;
	}

}
