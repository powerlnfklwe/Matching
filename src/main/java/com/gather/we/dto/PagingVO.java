package com.gather.we.dto;

public class PagingVO {
	// 페이징처리시 필요한 변수들
	private int nowPage = 1; // 현재페이지
	private int onePageRecord = 10; // 한 페이지에 표시할 레코드수
	private int totalRecord; // 총레코드수
	private int totalPage; // 총페이지수
	
	private int lastPageRecord;	// 마지막 페이지에 남아있는 레코드수
	
	private int onePageNumCount = 5; // 페이지 목록에 표시할 페이지 갯수
	private int startPageNum = 1;
	
	private String userid;
	private String username;
	private String managerid;
	private String adminid;
	
	 
	
	// 검색에 필요한 변수들
	private String searchKey;
	private String searchWord;
	private String SelectedDate; //마이페이지 날짜필터 변수
	private String datepicker; //지출내역 날짜필터 시작일
	private String datepicker2; //지출내역 날짜필터 종료일
	
	
	@Override
	public String toString() {
		return "PagingVO [nowPage=" + nowPage + ", onePageRecord=" + onePageRecord + ", totalRecord=" + totalRecord
				+ ", totalPage=" + totalPage + ", lastPageRecord=" + lastPageRecord + ", onePageNumCount="
				+ onePageNumCount + ", startPageNum=" + startPageNum + ", userid=" + userid + ", username=" + username
				+ ", managerid=" + managerid + ", adminid=" + adminid + ", searchKey=" + searchKey + ", searchWord="
				+ searchWord + ", SelectedDate=" + SelectedDate + ", datepicker=" + datepicker + ", datepicker2="
				+ datepicker2 + "]";
	}
	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
		
		// 출력할 페이지 시작번호를 계산
		// ((현재페이지-1)/표시할 페이지수)*표시할 페이지수+1
		startPageNum = ((nowPage-1)/onePageNumCount)*onePageNumCount+1;
	}
	public int getOnePageRecord() {
		return onePageRecord;
	}
	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		// 총레코드 수를 이용하여 총페이지 수를 구하기
		totalPage = (int)Math.ceil((double)totalRecord/onePageRecord);
		
		// 마지막 페이지에 남아 있는 레코드수
		lastPageRecord = onePageRecord;
		if(nowPage==totalPage){
			if(totalRecord % onePageRecord == 0){ // 나머지가 0일 경우는 lastPageRecord <- onePageRecord
				lastPageRecord = onePageRecord;
			}else { // 나머지가 존재하는 경우 남아있는 레코드수를 lastPageRecord에 삽입
				lastPageRecord = totalRecord % onePageRecord;
			}
		}
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getLastPageRecord() {
		return lastPageRecord;
	}
	public void setLastPageRecord(int lastPageRecord) {
		this.lastPageRecord = lastPageRecord;
	}
	public int getOnePageNumCount() {
		return onePageNumCount;
	}
	public void setOnePageNumCount(int onePageNumCount) {
		this.onePageNumCount = onePageNumCount;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getManagerid() {
		return managerid;
	}
	public void setManagerid(String managerid) {
		this.managerid = managerid;
	}
	public String getAdminid() {
		return adminid;
	}
	public void setAdminid(String adminid) {
		this.adminid = adminid;
	}
	
	public String getSelectedDate() {
		return SelectedDate;
	}
	public void setSelectedDate(String selectedDate) {
		SelectedDate = selectedDate;
	}

	public String getDatepicker() {
		return datepicker;
	}

	public void setDatepicker(String datepicker) {
		this.datepicker = datepicker;
	}

	public String getDatepicker2() {
		return datepicker2;
	}

	public void setDatepicker2(String datepicker2) {
		this.datepicker2 = datepicker2;
	}
	
	
}
