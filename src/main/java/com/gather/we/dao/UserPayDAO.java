package com.gather.we.dao;

import com.gather.we.dto.UserPayDTO;
import com.gather.we.dto.UserPayDoneDTO;

public interface UserPayDAO {
	// 사용자 결제내역 등록
	public int userPayInsert(UserPayDTO dto);
	// 결제완료 정보 선택 - 랭크경기
	public UserPayDoneDTO rankPayDoneSelect(String payment_no);
	// 결제완료 정보 선택 - 일반경기
	public UserPayDoneDTO normPayDoneSelect(String payment_no);
}
