package com.gather.we.dto;

import lombok.Data;

@Data
public class AdminDTO {
	private String adminid;
	private String type;
	private String admin_name;
	private String password;
	private String email;
	private String tel;
	private int authority;
}
