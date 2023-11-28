package com.gather.we.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.RegisterDAO;
import com.gather.we.dto.PagingVO;
import com.gather.we.dto.RegisterDTO;
import com.gather.we.dto.UserLogDTO;

@Service
public class RegisterServiceImpl implements RegisterService{
	
	@Autowired 
	RegisterDAO dao;

	@Override
	public int registerInsert(RegisterDTO dto) {
		return dao.registerInsert(dto);
	}

	@Override
	public RegisterDTO loginOk(String userid, String password) {
		return dao.loginOk(userid, password);
	}

	@Override
	public int idCheckCount(String userid) {
		return dao.idCheckCount(userid);
	}

	@Override
	public List<RegisterDTO> dataAllSelect(PagingVO vo) {
		// TODO Auto-generated method stub
		return dao.dataAllSelect(vo);
	}

	@Override
	public RegisterDTO registerEdit(String userid) {
		// TODO Auto-generated method stub
		return dao.registerEdit(userid);
	}

	@Override
	public int registerEditOk(RegisterDTO dto) {
		// TODO Auto-generated method stub
		return dao.registerEditOk(dto);
	}

	@Override
	public List<UserLogDTO> userLogSelect(String userid) {
		// TODO Auto-generated method stub
		return dao.userLogSelect(userid);
	}

	@Override
	public List<UserLogDTO> userLogNormSelect(String userid) {
		// TODO Auto-generated method stub
		return dao.userLogNormSelect(userid);
	}



	
	
}
