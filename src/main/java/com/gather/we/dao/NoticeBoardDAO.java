package com.gather.we.dao;

import java.util.List;

import com.gather.we.dto.NoticeBoardCriteria;
import com.gather.we.dto.NoticeBoardDTO;

public interface NoticeBoardDAO {
	//게시글 등록
	public void enroll(NoticeBoardDTO dto);
	
	//게시글 목록
	public List<NoticeBoardDTO> getList();
	
	//게시글 목록(페이징 적용)
	public List<NoticeBoardDTO> getListPaging(NoticeBoardCriteria cri);
		
	//게시글 조회
	public NoticeBoardDTO getPage(int no);
	
	//게시글 수정
	public int modify(NoticeBoardDTO dto);
	
	//게시글 삭제
	public int delete(int no);
	
	//게시글 총 개수
	public int getTotal(NoticeBoardCriteria cri);
}
