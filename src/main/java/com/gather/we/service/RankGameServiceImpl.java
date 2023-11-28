package com.gather.we.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gather.we.dao.RankGameDAO;
import com.gather.we.dto.AdminRankGameDTO;
import com.gather.we.dto.PagingVO;
import com.gather.we.dto.RankGameDTO;
import com.gather.we.dto.RankGameDetailDTO;
import com.gather.we.dto.RankGameListDTO;

@Service
public class RankGameServiceImpl implements RankGameService {
	@Inject
	RankGameDAO dao;

	@Override
	public int rankGameInsert(RankGameDTO dto) {
		return dao.rankGameInsert(dto);
	}

	@Override
	public RankGameDTO rankGameOneSelect(int no) {
		return dao.rankGameOneSelect(no);
	}

	@Override
	public int rankGameUpdate(RankGameDTO dto) {
		return dao.rankGameUpdate(dto);
	}
	
	@Override
	public List<RankGameDTO> rankGameListSelect(RankGameListDTO dto) {
		return dao.rankGameListSelect(dto);
	}

	@Override
	public RankGameDetailDTO rankGameDetailSelect(int no) {
		return dao.rankGameDetailSelect(no);
	}

	@Override
	public int currPeopleCount(int no) {
		return dao.currPeopleCount(no);
	}
	
	@Override
	public List<AdminRankGameDTO> adminRankGameAllSelect() {
		return dao.adminRankGameAllSelect();
	}

	@Override
	public List<AdminRankGameDTO> pageSelect(PagingVO vo) {
		return dao.pageSelect(vo);
	}

	@Override
	public int totalRecord() {
		return dao.totalRecord();
	}
}
