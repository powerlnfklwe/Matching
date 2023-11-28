package com.gather.we.dto;

import lombok.Data;

@Data
public class RequestBoardCriteria {

    // 현재 페이지 
    private int pageNum;
    
    // 한 페이지 당 보여질 게시물 수 
    private int amount;
    
    //검색어
    private String keyword;
    
    //검색타입
    private String type;
    
    //검색타입 배열
    private String[] typeArr;
    
    // 기본 생성자 -> 기본 세팅 : pageNum = 1, amount = 10 
    public RequestBoardCriteria() {
    	this.pageNum = 1;
		this.amount =10;//한페이지에 데이터 10개씩 출력
    }
    
    public void setType(String type) {
    	this.type=type;
    	this.typeArr=type.split("");
    }
}
