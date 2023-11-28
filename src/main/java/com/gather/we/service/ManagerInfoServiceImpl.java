package com.gather.we.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.gather.we.dao.ManagerInfoDAO;

import com.gather.we.dto.ManagerInfoDTO;
import com.gather.we.dto.ManagerPagingVO;


@Service
public class ManagerInfoServiceImpl implements ManagerInfoService {
	@Inject
	ManagerInfoDAO dao;
//	@Override
	//public List<ManagerInfoDTO> getAllManagerInfo() {
		
//		return dao.getAllManagerInfo();
	//}
	
	
	


	@Override
	public List<ManagerInfoDTO> getAllManagerInfoBy(String managerid) {
		
		return dao.getAllManagerInfo(managerid);
	}


	

	



	@Override
	public List<ManagerInfoDTO> getAllManagerInputByRank(Integer rank, Integer no) {
		
		return dao.getAllManagerInputByRank(rank, no);
	}



	


	



	@Override
	public List<ManagerInfoDTO> getAllManagerInput(Integer no) {
		// TODO Auto-generated method stub
		return dao.getAllManagerInput(no);
	}



	@Override
	public List<ManagerInfoDTO> getAllEntry(Integer no) {
		// TODO Auto-generated method stub
		return dao.getAllEntry(no);
	}


	@Override
	public List<ManagerInfoDTO> pageSelect(ManagerPagingVO vo) {
		
		return dao.pageSelect(vo);
	}

	@Override
	public int getTotalRecordByManagerid(String managerid) {
		return dao.getTotalRecordByManagerid(managerid);
	}







	@Override
	public void updateRankGame(String managerid, Integer no) {
		
		 dao.updateRankGame(managerid, no);
		
	}

	@Override
	public void deleteMSettlement(String managerid, Integer no) {
		dao.deleteMSettlement(managerid, no);
		
	}
	

	@Override
	public void updateRank(String userid, Integer rank, Integer no) {
	 System.out.println(userid + "part" + Integer.valueOf(rank));
		dao.updateRank(userid, rank, no);
		
	}





	@Override
	public List<ManagerInfoDTO> getAllManagerInputByManagerid(String rank, Integer no) {
		
		return dao.getAllManagerInputByManagerid(rank, no);
	}





//	@Override
//	public List<Manager10DTO> getAllManagerPast(ManagerPagingVO vo) {
		
//		return dao.getAllManagerPast(vo);
//	}





	@Override
	public List<ManagerInfoDTO> getAllManagerPast(ManagerPagingVO vo) {
		
		return dao.getAllManagerPast(vo);
	}





//	@Override
//	public int getTotalRecordByManageridInfo(String managerid) {
		
	//	return dao.getTotalRecordByManagerid(managerid);
	//}





	@Override
	public int getTotalRecordByManageridInfo(String managerid) {
		// TODO Auto-generated method stub
		return 0;
	}








	@Override
	public List<ManagerInfoDTO> getAllManagerInfo() {
		// TODO Auto-generated method stub
		return null;
	}





	
	}





	

