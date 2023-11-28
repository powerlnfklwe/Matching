package com.gather.we.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gather.we.dao.MypageDAO;
import com.gather.we.dto.MypageApplyListDTO;
import com.gather.we.dto.MypagePaymentDTO;
import com.gather.we.dto.MypageRankDTO;
import com.gather.we.dto.MypageUserDTO;
import com.gather.we.dto.PagingVO;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Inject
	MypageDAO dao;

	@Override
	public MypageUserDTO getUserinfo(String userid) {
	return dao.getUserinfo(userid);
	}
	
	@Override
	public String getUsername(String userid) {
		return dao.getUsername(userid);
	}
	
	@Override
	public List<MypageApplyListDTO> allgameList(PagingVO vo) {
		return dao.allgameList(vo);
	}
	
	@Override
	public List<MypageApplyListDTO> rankgameList(PagingVO vo) {
		return dao.rankgameList(vo);
	}

	@Override
	public List<MypageApplyListDTO> normgameList(PagingVO vo) {
		return dao.normgameList(vo);
	}

	@Override
	public List<MypageRankDTO> rank(String userid, String sportname) {
		return dao.rank(userid, sportname);
	}

	@Override
	public List<MypageRankDTO> rankResult(String userid) {
		return dao.rankResult(userid);
	}

	@Override
	public List<MypagePaymentDTO> paymentList(PagingVO vo) {
		return dao.paymentList(vo);
	}

	@Override
	public int infoEdit(MypageUserDTO dto) {
		return dao.infoEdit(dto);
	}

	@Override
	public int allTotalRecord(String userid) {
		return dao.allTotalRecord(userid);
	}

	@Override
	public int normTotalRecord(String userid) {
		return dao.normTotalRecord(userid);
	}

	@Override
	public int rankTotalRecord(String userid) {
		return dao.rankTotalRecord(userid);
	}

	@Override
	public int paymentTotalRecord(String username) {
		return dao.paymentTotalRecord(username);
	}

	@Override
	public int gameCancel(MypageApplyListDTO dto) {
		return dao.gameCancel(dto);
	}
}
