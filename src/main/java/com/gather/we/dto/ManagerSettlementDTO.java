package com.gather.we.dto;

import java.util.Date;

import lombok.Data;
@Data
public class ManagerSettlementDTO {
	private int no;
	private String managerid;
	private String datetime;
	private String d_status;
	private int amount;
	private String stadium;
	private Date gametime;
	private int completed_amount;
	private int inprogress_amount;

}
