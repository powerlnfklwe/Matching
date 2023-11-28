package com.gather.we.service;

import com.gather.we.dto.ManagerDTO;

public interface ManagerService {
	//íšŒì›ê°€ì…
	public int managerInsert(ManagerDTO dto);
	public int dataDelete(String managerid);
	public ManagerDTO loginManOk(String managerid, String password);
	//¾ÆÀÌµğ Áßº¹°Ë»ç - ¾ÆÀÌµğÀÇ °¹¼ö¸¦ ±¸ÇÑ´Ù.
	public int idCheckCount(String managerid);
}
