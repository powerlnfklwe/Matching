package com.gather.we.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gather.we.dto.RankBoardCriteria;
import com.gather.we.dto.RankBoardDTO;
import com.gather.we.dto.RankBoardPageDTO;
import com.gather.we.service.RankBoardService;

@Controller
@RequestMapping("/board/*")
public class RankBoardController {
	
	@Autowired
	private RankBoardService service;
	
	@GetMapping("/rankBoard")
	public String rankBoard(RankBoardCriteria criteria,Model model) {
		return "/user/rankBoard/rankBoard";
	}
	
	@GetMapping("/list")
	@ResponseBody
	public ResponseEntity<?> getRankBoardList(Model model) {
		try {
			return ResponseEntity.ok(service.getUserRankList());
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.ok("99");
		}
	}
}
