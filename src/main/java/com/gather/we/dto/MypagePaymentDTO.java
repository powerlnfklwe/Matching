package com.gather.we.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MypagePaymentDTO {
	
	private String userid;
	private String username;
	private String gametime;
	private String payment_no;
	private int paid_amount;
	private long paid_at;
	private String success;
	
	
}
