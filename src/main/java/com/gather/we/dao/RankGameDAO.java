package com.gather.we.dao;

import java.util.List;

import com.gather.we.dto.AdminRankGameDTO;
import com.gather.we.dto.PagingVO;
import com.gather.we.dto.RankGameDTO;
import com.gather.we.dto.RankGameDetailDTO;
import com.gather.we.dto.RankGameListDTO;

public interface RankGameDAO {
	// 랭크경기 등록
	public int rankGameInsert(RankGameDTO dto);
	// 랭크게임 한 개 선택
	public RankGameDTO rankGameOneSelect(int no);
	// 랭크게임 수정
	public int rankGameUpdate(RankGameDTO dto);
	// 랭크경기 목록 선택
	public List<RankGameDTO> rankGameListSelect(RankGameListDTO dto);
	// 랭크경기 세부정보 선택
	public RankGameDetailDTO rankGameDetailSelect(int no);
	// 랭크경기 현재인원수 업데이트
	public int currPeopleCount(int no);
	// 관리자 랭크게임 목록 전체선택
	public List<AdminRankGameDTO> adminRankGameAllSelect();
	// 관리자 랭크게임 해당 페이지 레코드 선택
	public List<AdminRankGameDTO> pageSelect(PagingVO vo);
	// 랭크게임 총레코드 수
	public int totalRecord();
}

