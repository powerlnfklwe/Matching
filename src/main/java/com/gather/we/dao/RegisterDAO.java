package com.gather.we.dao;

import java.util.List;

import com.gather.we.dto.PagingVO;
import com.gather.we.dto.RegisterDTO;
import com.gather.we.dto.UserLogDTO;

public interface RegisterDAO {
	//�쉶�썝媛��엯
	public int registerInsert(RegisterDTO dto);
	//異붿긽硫붿냼�뱶
	public RegisterDTO loginOk(String userid, String password);
	//�븘�씠�뵒 以묐났寃��궗 - �븘�씠�뵒�쓽 媛��닔瑜� 援ы븳�떎.
	public int idCheckCount(String userid);
	public List<RegisterDTO> dataAllSelect(PagingVO vo);
	//�쉶�썝�젙蹂� �닔�젙 �뤌
	public RegisterDTO registerEdit(String userid);
	//�쉶�썝�젙蹂� �닔�젙 DB update
	public int registerEditOk(RegisterDTO dto);
	//회원활동내역 랭크 게임
	public List<UserLogDTO> userLogSelect(String userid);
	//회원활동내역 일반 게임
	public List<UserLogDTO> userLogNormSelect(String userid);
}
