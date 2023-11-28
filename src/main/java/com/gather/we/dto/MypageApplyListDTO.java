package com.gather.we.dto;

import java.util.Calendar;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MypageApplyListDTO {

	private String userid; //아이디 
	private int no; //경기일련번호
	private String sportname; //종목명
	private Date gametime; //경기날짜
	private String stadium; //구장명(경기명)
	private int g_status; //경기상태
	private Date gt2ago; //경기날짜 이틀전
	private Date gt1ago; //경기날짜 하루전
	
	//날짜 필터링
	private String SelectedDate; 
	
	public void setGt1Ago(Date gt2ago) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(gt2ago);
		cal.add(cal.DATE, 1);
		
		this.gt1ago = cal.getTime();
	}
}
