package com.gather.we.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gather.we.dao.UsersDAO;
import com.gather.we.dto.UsersDTO;

@Service
public class UsersServiceImpl implements UsersService {
	@Inject
	UsersDAO dao;

	@Override
	public UsersDTO participantInfoSelect(String userid) {
		return dao.participantInfoSelect(userid);
	}

	@Override
	public UsersDTO userInfoInfoSelect(String userid) {
		return dao.userInfoInfoSelect(userid);
	}
}