package com.gather.we.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.gather.we.dao.SportDAO;
import com.gather.we.dto.SportDTO;

@Service
public class SportServiceImpl implements SportService {

	@Inject
	SportDAO dao;

	@Override
	public List<SportDTO> dataSelect() {
		return dao.dataSelect();
	}
	
	@Override
	public int sportInsert(SportDTO dto) {
		return dao.sportInsert(dto);
	}

	@Override
	public int sportDelete(int no) {
		return dao.sportDelete(no);
	}

	@Override
	public List<SportDTO> sportAllSelect() {
		return dao.sportAllSelect();
	}
	
	@Override
	public SportDTO sportOneSelect(int s_no) {
		return dao.sportOneSelect(s_no);
	}

	@Override
	public int sportUpdate(SportDTO dto) {
		return dao.sportUpdate(dto);
	}

	@Override
	public List<String> sortedSportnameSelect() {
		return dao.sortedSportnameSelect();
	}

}
