package com.gather.we.dto;

public class RegisterDTO {

	private String userid;
	private String type;
	private String username;
	private String password;
	private String email;
	private String tel;
	
	private String tel1;
	private String tel2;
	private String tel3;
	
	private String address;
	private String gender;
	private String mbti;
	private int rank;
	private int temperature;
	private int active;
	private String signupdate;
	private int age;
	
	
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	@Override
	public String toString() {
		return "RegisterDTO [userid=" + userid + ", type=" + type + ", username=" + username + ", password=" + password
				+ ", email=" + email + ", tel=" + tel + ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3
				+ ", address=" + address + ", gender=" + gender + ", mbti=" + mbti + ", rank=" + rank + ", temperature="
				+ temperature + ", active=" + active + ", signupdate=" + signupdate + "]";
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		tel = tel1+"-"+tel2+"-"+tel3;
		return tel;
	}
	public void setTel(String tel) {
		
		this.tel = tel;
		
		String telCut[] = tel.split("-");
		tel1 = telCut[0];
		tel2 = telCut[1];
		tel3 = telCut[2];
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getMbti() {
		return mbti;
	}
	public void setMbti(String mbti) {
		this.mbti = mbti;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public int getTemperature() {
		return temperature;
	}
	public void setTemperature(int temperature) {
		this.temperature = temperature;
	}
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
	public String getSignupdate() {
		return signupdate;
	}
	public void setSignupdate(String signupdate) {
		this.signupdate = signupdate;
	}

	
	
	
}
