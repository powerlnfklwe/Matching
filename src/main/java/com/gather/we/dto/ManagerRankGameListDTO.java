package com.gather.we.dto;

import java.util.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class ManagerRankGameListDTO {
	private int no;
	private String managerid;
	private String stadium;
	private String region;
	private String location;
	private String sportname;
	private Date gametime;
	private int currPeople;
	private int max_people;
	private int payment;
	private int managerfee;
	private int g_status;
}
