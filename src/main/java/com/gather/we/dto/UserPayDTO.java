package com.gather.we.dto;

import lombok.Data;

@Data
public class UserPayDTO {
	private String payment_no;
	private String success;
	private String payer_name;
	private long paid_at;
	private int paid_amount;
	private int sum;
}
