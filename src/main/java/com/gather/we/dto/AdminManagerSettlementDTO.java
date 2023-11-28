package com.gather.we.dto;

import java.util.Date;

import lombok.Data;
@Data
public class AdminManagerSettlementDTO {
	private int no;
	private String managerid;
	private Date datetime;
	private String d_status;
	private int amount;
	private String stadium;
	private Date gametime;
	private String m_name;
	private String m_account;
}