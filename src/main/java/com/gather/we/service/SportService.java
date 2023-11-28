package com.gather.we.service;

import java.util.List;

import com.gather.we.dto.SportDTO;

public interface SportService {
	public List<SportDTO> dataSelect();
	// 종목 등록
	public int sportInsert(SportDTO dto);
	// 종목 삭제
	public int sportDelete(int no);
	// 종목 전체선택
	public List<SportDTO> sportAllSelect();
	// 스포츠 종목 하나 선택
	public SportDTO sportOneSelect(int s_no);
	// 종목 수정
	public int sportUpdate(SportDTO dto);
	// 종목이름 이름순 선택
	public List<String> sortedSportnameSelect();
}
