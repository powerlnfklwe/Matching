package com.gather.we.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.NoticeBoardDAO;
import com.gather.we.dto.NoticeBoardCriteria;
import com.gather.we.dto.NoticeBoardDTO;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
	
	@Autowired
	private NoticeBoardDAO dao;
	
	//게시글 등록
	@Override
	public void enroll(NoticeBoardDTO dto) {
		dao.enroll(dto);
	}
		
	//게시글 목록
	@Override
	public List<NoticeBoardDTO> getList() {
		return dao.getList();
	}
	
	//게시글 목록(페이징 적용)
	@Override
	public List<NoticeBoardDTO> getListPaging(NoticeBoardCriteria cri) {
		return dao.getListPaging(cri);
	}
		
	//게시글 조회
	@Override
	public NoticeBoardDTO getPage(int no) {
		return dao.getPage(no);
	}
		
	//게시글 수정
	@Override
	public int modify(NoticeBoardDTO dto) {
		return dao.modify(dto);
	}
		
	//게시글 삭제
	@Override
	public int delete(int no) {
		return dao.delete(no);
	}

	@Override
	public int getTotal(NoticeBoardCriteria cri) {
		return dao.getTotal(cri);
	}

}
