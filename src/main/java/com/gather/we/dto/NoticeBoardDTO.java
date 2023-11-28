package com.gather.we.dto;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeBoardDTO {
	private int no;
	private String adminid;
	private String title;
	private String content;
	private Date writedate;
	
}
