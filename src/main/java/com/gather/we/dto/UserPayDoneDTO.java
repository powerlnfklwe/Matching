package com.gather.we.dto;

import java.util.Date;

import lombok.Data;

@Data
public class UserPayDoneDTO {
	private String sportname;
	private Date gametime;
	private String stadium;
	private int payment;
}
