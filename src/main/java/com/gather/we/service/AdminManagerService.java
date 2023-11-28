package com.gather.we.service;

import java.util.List;

import com.gather.we.dto.ManagerDTO;
import com.gather.we.dto.PagingVO;
import com.gather.we.dto.RankGameDTO;

public interface AdminManagerService {
	// 매니저 승인 요청 목록
	public List<ManagerDTO> approveList(PagingVO vo);
	// 매니저 승인 요청 상세
	public ManagerDTO approveDetail(String managerid);
	// 매니저 요청 승인
	public void approveOk(String managerid);
	// 매니저 요청 거부
	public void refuseOk(String managerid);
	// 매니저 목록
	public List<ManagerDTO> managerList(PagingVO vo);
	// 매니저 최근 활동 불러오기
	public List<RankGameDTO> managerRecent(String managerid);
	// 매니저 상세 페이지
	public ManagerDTO managerDetail(String managerid);
	// 등록된 매니저 계정 총레코드수
	public int managerTotalRecord();
	// 매니저 계정 승인요청에 대한 총레코드수
	public int managerApproveTotalRecord();
}
