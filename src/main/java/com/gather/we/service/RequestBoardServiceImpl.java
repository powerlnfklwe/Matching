package com.gather.we.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gather.we.dao.RequestBoardDAO;
import com.gather.we.dto.RequestBoardCriteria;
import com.gather.we.dto.RequestBoardDTO;

@Service
public class RequestBoardServiceImpl implements RequestBoardService {
	
	@Autowired
	private RequestBoardDAO dao;
	
	//게시글 등록
	@Override
	public void enroll(RequestBoardDTO dto) {
		dao.enroll(dto);
	}
	
	//게시글 목록
	@Override
	public List<RequestBoardDTO> getList() {
		return dao.getList();
	}
	
	//게시글 목록(페이징 적용)
	@Override
	public List<RequestBoardDTO> getListPaging(RequestBoardCriteria cri) {
		return dao.getListPaging(cri);
	}
	
	//게시글 조회
	@Override
	public RequestBoardDTO getPage(int no) {
		return dao.getPage(no);
	}
	
	//게시글 수정
	@Override
	public int modify(RequestBoardDTO dto) {
		return dao.modify(dto);
	}
	
	//게시글 삭제
	@Override
	public int delete(int no) {
		return dao.delete(no);
	}

	@Override
	public int getTotal(RequestBoardCriteria cri) {
		return dao.getTotal(cri);
	}


}
