package com.gather.we.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.gather.we.dto.ManagerInfoDTO;
import com.gather.we.dto.ManagerPagingVO;



public interface ManagerInfoDAO {
	 
	 public List<ManagerInfoDTO> getAllManagerInfo();
	 
	 public List<ManagerInfoDTO> getAllManagerPast();
	 
	 public List<ManagerInfoDTO> getAllManagerInput(Integer no);
	 
	 public List<ManagerInfoDTO> getAllEntry(Integer no);
	  
	 public List<ManagerInfoDTO> getAllManagerInfo(String managerid);
	 
	 public List<ManagerInfoDTO> getAllManagerInputByRank(Integer rank, Integer no);
	 public List<ManagerInfoDTO> getAllManagerInputByManagerid(String rank, Integer no);
	 
	 public int getTotalRecordByManagerid(String managerid);
		//해당페이지 선택
   	 public List<ManagerInfoDTO> pageSelect(ManagerPagingVO vo);
	 
   	public List<ManagerInfoDTO> getAllManagerPast(ManagerPagingVO vo);
   	 
 //   public List<Manager10DTO> getAllManagerPast(ManagerPagingVO vo, String managerid, Integer No);
	
	 public void updateRank(@Param("userid") String userid, @Param("rank") Integer rank, @Param("no") Integer no);
	 
	 public void deleteMSettlement(@Param("managerid") String managerid, @Param("no") Integer no);
	 
	 public void updateRankGame(@Param("managerid") String managerid, @Param("no") Integer no);
	 
	 
	 public int getTotalRecordByManageridInfo(String managerid);
	
	
	}
