package com.gather.we.dto;

import lombok.Data;

@Data
public class MRankGameListCriteria {
	
	private int pageNum; // 현재 페이지 - page
	private int amount; //한페이지에 표시되는 데이터 갯수 - perPageNum
	
	public MRankGameListCriteria() {//생성자를 이용한 기본값셋팅
		this.pageNum = 1;
		this.amount = 4;//한페이지에 데이터 4개씩 출력
	}
	
}
