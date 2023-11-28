package com.gather.we.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.ManagerDAO;
import com.gather.we.dto.ManagerDTO;
@Service
public class ManagerServiceImpl implements ManagerService{
	@Autowired 
	ManagerDAO dao;

	@Override
	public int managerInsert(ManagerDTO dto) {
		// TODO Auto-generated method stub
		return dao.managerInsert(dto);
	}

	@Override
	public int dataDelete(String managerid) {
		return dao.dataDelete(managerid);
	}

	@Override
	public ManagerDTO loginManOk(String managerid, String password) {
		// TODO Auto-generated method stub
		return dao.loginManOk(managerid, password);
	}

	@Override
	public int idCheckCount(String managerid) {
		// TODO Auto-generated method stub
		return dao.idCheckCount(managerid);
	}


}
