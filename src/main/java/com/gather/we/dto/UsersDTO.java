package com.gather.we.dto;

import java.util.Date;

import lombok.Data;

@Data
public class UsersDTO {
	private String userid;
	private String type;
	private String username;
	private String password;
	private String email;
	private String tel;
	private int age;
	private String address;
	private String gender;
	private String mbti;
	private Date signupdate;
}