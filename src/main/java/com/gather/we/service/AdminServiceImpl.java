package com.gather.we.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.AdminDAO;
import com.gather.we.dto.AdminDTO;
import com.gather.we.dto.AdminManagerSettlementDTO;
import com.gather.we.dto.ManagerSettlementDTO;
import com.gather.we.dto.PagingVO;
import com.gather.we.dto.RegisterDTO;
import com.gather.we.dto.UserPayDTO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO dao;

	@Override
	public AdminDTO loginAdminOk(String adminid, String password) {
		return dao.loginAdminOk(adminid, password);
	}

	@Override
	public List<UserPayDTO> revenue(PagingVO vo) {
		return dao.revenue(vo);
	}

	@Override
	public List<AdminManagerSettlementDTO> expense(PagingVO vo) {
		return dao.expense(vo);
	}
	
	@Override
	public List<AdminManagerSettlementDTO> managerFee(PagingVO vo) {
		return dao.managerFee(vo);
	}

	@Override
	public int waitOk(AdminManagerSettlementDTO dto) {
		return dao.waitOk(dto);
	}


	@Override
	public int totalRecord(PagingVO vo) {
		return dao.totalRecord(vo);
	}

	@Override
	public List<RegisterDTO> pageSelect(PagingVO vo) {
		return dao.pageSelect(vo);
	}

	@Override
	public int revenueTotalRecord(PagingVO vo) {
		return dao.revenueTotalRecord(vo);
	}

	@Override
	public int expenseTotalRecord(PagingVO vo) {
		return dao.expenseTotalRecord(vo);
	}

	@Override
	public int managerFeeTotalRecord(PagingVO vo) {
		return dao.managerFeeTotalRecord(vo);
	}

	
}
