package com.gather.we.service;

import java.util.List;

import com.gather.we.dto.RecommendDTO;

public interface RecommendService {
	// mbti유형의 스포츠 통계 선택
	public List<RecommendDTO> mbtiStatisticsSelect(String mbtiType);
	// 성별 스포츠 통계 선택
	public List<RecommendDTO> genderStatisticsSelect(String gender);
	// 하나의 나이 그룹에 대한 스포츠 통계 선택
	public List<RecommendDTO> ageStatisticsSelect(String age);
	// 하나의 나이 그룹에서 비율이 가장 높은 스포츠 선택
	public RecommendDTO ageTopStatisticsSelect(String age);
}