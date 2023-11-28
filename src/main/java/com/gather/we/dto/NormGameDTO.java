package com.gather.we.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NormGameDTO {
	private int no;
	private int s_no;
	private int st_no;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private Date gametime;
	
	private String usetime;
	private int min_people;
	private int max_people;
	private int curr_people;
	private String gendertype;
	private int payment;
	private int g_status;
	private String writer;
}
