package com.gather.we.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NormGameListDTO {
	private int no;
	private int s_no;
	private Date gametime;
	private String usetime;
	private int min_people;
	private int max_people;
	private int curr_people;
	private String writer;
	private String gendertype;
	private String stadium;
	private String region;
	
	// 지역 필터링 시 사용할 변수
	private List<String> regionList;
}
