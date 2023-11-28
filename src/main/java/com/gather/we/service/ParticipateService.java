package com.gather.we.service;

import org.apache.ibatis.annotations.Param;

import com.gather.we.dto.NParticipateDTO;
import com.gather.we.dto.RParticipateDTO;

public interface ParticipateService {
	// 랭크경기 참여 등록
	public int rParticipateInsert(RParticipateDTO dto);
	// 일반경기 참여 등록
	public int nParticipateInsert(NParticipateDTO dto);
	// 일반경기 참가 여부 확인
	public int isNormParticipate(String userid, int no);
	// 랭크경기 참가 여부 확인
	public int isRankParticipate(String userid, int no);
	// 해당 종목의 사용자 랭크 선택
	public Integer userRankOfSport(@Param("userid") String userid, @Param("s_no")int s_no);
}
