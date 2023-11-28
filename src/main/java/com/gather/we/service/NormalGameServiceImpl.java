package com.gather.we.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gather.we.dao.NormalGameDAO;
import com.gather.we.dto.NormGameDTO;
import com.gather.we.dto.NormGameDetailDTO;
import com.gather.we.dto.NormGameListDTO;
import com.gather.we.dto.PagingVO;

@Service
public class NormalGameServiceImpl implements NormalGameService {
	@Inject
	NormalGameDAO dao;

	@Override
	public List<NormGameDTO> normGameListSelect(NormGameListDTO dto) {
		return dao.normGameListSelect(dto);
	}

	@Override
	public NormGameDetailDTO normGameDetailSelect(int no) {
		return dao.normGameDetailSelect(no);
	}

	@Override
	public List<NormGameDetailDTO> normGameDetailAllSelect() {
		return dao.normGameDetailAllSelect();
	}

	@Override
	public int normGameInsert(NormGameDTO dto) {
		return dao.normGameInsert(dto);
	}

	@Override
	public List<NormGameDetailDTO> newNormGameList(int st_no) {
		return dao.newNormGameList(st_no);
	}

	@Override
	public int normGameUpdate(NormGameDTO dto) {
		return dao.normGameUpdate(dto);
	}

	@Override
	public int normGameCountUp(int no) {
		return dao.normGameCountUp(no);
	}
	
  @Override
	public int currPeopleCount(int no) {
		return dao.currPeopleCount(no);
	}

	@Override
	public List<NormGameDetailDTO> pageSelect(PagingVO vo) {
		return dao.pageSelect(vo);
	}

	@Override
	public int totalRecord() {
		return dao.totalRecord();
	}

	@Override
	public int normGameDetailUpdate(NormGameDetailDTO dto) {
		return dao.normGameDetailUpdate(dto);
	}
  
}
