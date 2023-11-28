package com.gather.we.service;

import java.util.List;

import com.gather.we.dto.NormGameDTO;
import com.gather.we.dto.NormGameDetailDTO;
import com.gather.we.dto.NormGameListDTO;
import com.gather.we.dto.PagingVO;

public interface NormalGameService {
	// 일반경기 목록 선택
	public List<NormGameDTO> normGameListSelect(NormGameListDTO dto);
	// 일반경기 세부정보 선택
	public NormGameDetailDTO normGameDetailSelect(int no);
	// 일반경기 세부정보 목록
	public List<NormGameDetailDTO> normGameDetailAllSelect();
	// 일반경기 등록 (DB)
	public int normGameInsert(NormGameDTO dto);
	// 일반경기 수정 (DB)
	public int normGameDetailUpdate(NormGameDetailDTO dto);
	// 미개설 일반경기 정보 불러오기
	public List<NormGameDetailDTO> newNormGameList(int st_no);
	// 일반경기 사용자 개설 (DB)
	public int normGameUpdate(NormGameDTO dto);
	// 일반경기 개설 후 참여인원 증가
	public int normGameCountUp(int no);
	// 일반경기 현재인원수 업데이트
	public int currPeopleCount(int no);
	// 해당 페이지 일반경기 레코드 불러오기
	public List<NormGameDetailDTO> pageSelect(PagingVO vo);
	// 총레코드수
	public int totalRecord();
}
