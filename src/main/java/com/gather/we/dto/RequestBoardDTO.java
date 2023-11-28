package com.gather.we.dto;

import java.util.Date;

import lombok.Data;

@Data
public class RequestBoardDTO {
	private int no;
	private String userid;
	private String title;
	private String content;
	private Date writedate;
}
