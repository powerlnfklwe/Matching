package com.gather.we.dto;

import java.util.Date;

import lombok.Data;

@Data
public class UserLogDTO {
	private String userid;
	private int no;
	private int st_no;
	private Date gametime;
	private String stadium;
	private String location;
	private String region;
	
	
}
