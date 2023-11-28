package com.gather.we.service;

import java.util.List;

import com.gather.we.dto.RequestBoardCriteria;
import com.gather.we.dto.RequestBoardDTO;

public interface RequestBoardService {
	//게시글 등록
	public void enroll(RequestBoardDTO dto);
	
	//게시글 목록
	public List<RequestBoardDTO> getList();
	
	//게시글 목록(페이징 적용)
	public List<RequestBoardDTO> getListPaging(RequestBoardCriteria cri);
		
	//게시글 조회
	public RequestBoardDTO getPage(int no);
	
	//게시글 수정
	public int modify(RequestBoardDTO dto);
	
	//게시글 삭제
	public int delete(int no);
	
	//게시글 총 개수
	public int getTotal(RequestBoardCriteria cri);
}
