

package com.gather.we.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.jdbc.core.JdbcTemplate;

import com.gather.we.dto.ManagerInfoDTO;
import com.gather.we.dto.ManagerPagingVO;


public interface ManagerInfoService {

	 public List<ManagerInfoDTO> getAllManagerInfo();
	
	 	 
	 public List<ManagerInfoDTO> getAllManagerInput(Integer no);
	
	 public List<ManagerInfoDTO> getAllEntry(Integer no);
	 
	
		//해당페이지 선택 위에 int가 반환형이었음. 
	 public List<ManagerInfoDTO> pageSelect(ManagerPagingVO vo);
	
	 
	 
	 public List<ManagerInfoDTO> getAllManagerInfoBy(String managerid);
	 
	 
	 
	 public int getTotalRecordByManagerid(String managerid);
	 
	 public List<ManagerInfoDTO> getAllManagerInputByManagerid(String rank, Integer no);
	 
	 public List<ManagerInfoDTO> getAllManagerPast(ManagerPagingVO vo);
	 
	// public List<Manager10DTO> getAllManagerPast(ManagerPagingVO vo, String managerid, Integer no);
	

	public void updateRankGame(@Param("managerid") String managerid, @Param("no") Integer no);

	public void deleteMSettlement(@Param("managerid") String managerid, @Param("no") Integer no);
	
	public void updateRank(@Param("userid") String userid, @Param("rank") Integer rank, @Param("no") Integer no);
	
	public List<ManagerInfoDTO> getAllManagerInputByRank(Integer rank, Integer no);

	public int getTotalRecordByManageridInfo(String managerid);


	//int getTotalRecordByManageridInfo(String managerid);

	

	

	
	 
	 
	 
	 
}
