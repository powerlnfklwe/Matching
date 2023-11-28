package com.gather.we.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ManagerRankGameDTO {
	private int no;
	private int s_no;
	private String managerid;
	private int st_no;
	private String gametime;
	private int min_people;
	private int max_people;
	private int curr_people;
	private String gendertype;
	private int req_rank;
	private int payment;
	private int managerfee;
	private int g_status;
}
