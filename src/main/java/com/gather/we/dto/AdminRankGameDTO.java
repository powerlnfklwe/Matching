package com.gather.we.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AdminRankGameDTO {
	private int no;
	private Date gametime;
	private String managerid;
	private int g_status;
	private String sportname;
	private String stadium;
	private String usetime;
}