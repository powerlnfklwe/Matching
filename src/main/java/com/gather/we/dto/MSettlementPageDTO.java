package com.gather.we.dto;

import lombok.Data;

@Data
public class MSettlementPageDTO {

	private int startPage; //첫 페이지
	private int endPage; //마지막페이지
	private boolean prev, next; //이전페이지,다음페이지-있으면 true, 없으면 false
	private int total; //전체 데이터 개수
	private MSettlementCriteria mscriteria; //현재페이지, 페이지당 데이터 개수
	
	//생성자에서 값을 전달 받아서 세팅
	public MSettlementPageDTO(MSettlementCriteria mscriteria, int total) {
		this.mscriteria = mscriteria;
		this.total = total;
		
		//화면에 보여줄 페이지 계산
		this.endPage = (int)(Math.ceil(mscriteria.getPageNum()/ 10.0)*10);
		this.startPage = this.endPage - 9;
		
		//전체 데이터의 마지막 페이지 계산 totalPage
		int realEnd = (int)(Math.ceil((total * 1.0) / mscriteria.getAmount()));
		
		//endPage는 realEnd를 초과할 수 없음.그래서 계산 결과가 초과가 되면 endPage를 realEnd로 바꿔야한다.
		if(realEnd < endPage) this.endPage = realEnd;
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}	
}
