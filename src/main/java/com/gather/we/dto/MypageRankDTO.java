package com.gather.we.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MypageRankDTO {
	private String userid;
	private int no;
	private int g_status;
	private Date gametime;
	private int rank;
	private String sportname;
	private int avg_sn;
	private int avg_all;
	private int rn;
}
