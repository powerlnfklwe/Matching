package com.gather.we.dto;

public class ManagerPagingVO {
	//PagingVO-> ManagerPagingVO로 파일이름변경(devlop에도 같은 이름 파일 있어서)
	//private static final int onePageNumCount = 0;
	//페이징에 필요한 변수들
	private int nowPage = 1;//현재페이지
	private int onePageRecord = 4; //한 페이지에 표시할 레코드 수
	private int totalRecord;//총 레코드 수
	private int totalPage;//총 페이지 수
	//마지막 페이지에 남아 있는 레코드 수. 
	private int lastPageRecord;
	private int startPageNum = 1;
	private int onePageNumCount=10; //한페이지 당 페이지 개수
	private String managerid;
	//
	private Integer no;
	//검색에 필요한 변수들
	
	//private String rank_game;
	
	
	
	
	public int getNowPage() {
		return nowPage;
		

		//출력할 페이지 시작 번호. 
		
		
	}




@Override
	public String toString() {
		return "ManagerPagingVO [nowPage=" + nowPage + ", onePageRecord=" + onePageRecord + ", totalRecord="
				+ totalRecord + ", totalPage=" + totalPage + ", lastPageRecord=" + lastPageRecord + ", startPageNum="
				+ startPageNum + ", onePageNumCount=" + onePageNumCount + ", managerid=" + managerid + ", no=" + no
				+ "]";
	}




public void setNowPage(int nowPage) {
	this.nowPage = nowPage;

	startPageNum= ((nowPage-1)/onePageNumCount)*onePageNumCount+1;
	
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
	
	//총레코드 수를 이용하여 총페이지 수를 구하기 
	
	totalPage = (int)Math.ceil((double)totalRecord/onePageRecord);
	
	//마지막 페이지에 남아 있는 레코드 수
	
	lastPageRecord = onePageRecord;
	if(nowPage==totalPage) {
		if(totalRecord%onePageRecord==0){//나머지가 0인 경우는 lastPageRecord<- onePageRecord
			lastPageRecord = onePageRecord;
		}else{//나머지가 있을 경우 남아 있는 레코드수를 lastpageRecord
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

public int getStartPageNum() {
	return startPageNum;
}

public void setStartPageNum(int startPageNum) {
	this.startPageNum = startPageNum;
}

public int getOnePageNumCount() {
	return onePageNumCount;
}

public void setOnePageNumCount(int onePageNumCount) {
	this.onePageNumCount = onePageNumCount;
}


public String getManagerid() {
	return managerid;
}


public void setManagerid(String managerid) {
	this.managerid = managerid;
}


public Integer getNo() {
	return no;
}


public void setNo(Integer no) {
	this.no = no;
}


//검색에 필요한 변수들



}
	
	
