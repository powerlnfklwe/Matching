package com.gather.we.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gather.we.dao.UserPayDAO;
import com.gather.we.dto.UserPayDTO;
import com.gather.we.dto.UserPayDoneDTO;

@Service
public class UserPayServiceImpl implements UserPayService {
	@Inject
	UserPayDAO dao;

	@Override
	public int userPayInsert(UserPayDTO dto) {
		return dao.userPayInsert(dto);
	}

	@Override
	public UserPayDoneDTO rankPayDoneSelect(String payment_no) {
		return dao.rankPayDoneSelect(payment_no);
	}

	@Override
	public UserPayDoneDTO normPayDoneSelect(String payment_no) {
		return dao.normPayDoneSelect(payment_no);
	}
}
