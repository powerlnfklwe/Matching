package com.gather.we.controller;


import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gather.we.dto.AdminRankGameDTO;
import com.gather.we.dto.AdminDTO;
import com.gather.we.dto.AdminManagerSettlementDTO;
import com.gather.we.dto.RegisterDTO;
import com.gather.we.service.AdminService;
import com.gather.we.service.NormalGameService;
import com.gather.we.service.RegisterService;


import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



import com.gather.we.dto.ManagerDTO;
import com.gather.we.dto.ManagerSettlementDTO;
import com.gather.we.dto.NormGameDTO;
import com.gather.we.dto.NormGameDetailDTO;
import com.gather.we.dto.PagingVO;
import com.gather.we.dto.RankGameDTO;
import com.gather.we.dto.SportDTO;
import com.gather.we.dto.StadiumInfoDTO;

import com.gather.we.dto.UserLogDTO;
import com.gather.we.dto.UserPayDTO;
import com.gather.we.service.AdminManagerService;

import com.gather.we.service.RankGameService;
import com.gather.we.service.SportService;
import com.gather.we.service.StadiumInfoService;
import com.gather.we.service.UserPayService;

@RestController
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	SportService sportService;
	@Autowired
	StadiumInfoService stadiumInfoService;
	@Autowired
	RankGameService rankGameService;
	@Autowired
	AdminManagerService adminManagerService;
	@Autowired
	AdminService service;
	@Autowired
	RegisterService regservice;
	@Autowired
	NormalGameService normGameService;

	// 관리자 홈
	@GetMapping("/")
	public ModelAndView adminHome(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		

		if(adminlogStatus.equals("Y")) {
			mav.setViewName("redirect:/admin/userList");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}

	//(관리자 페이지)회원 리스트
	@GetMapping("/userList")
	public ModelAndView loginList(HttpSession session, PagingVO vo) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);
				
		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);
		
		// 총레코드 수 세팅
		vo.setTotalRecord(service.totalRecord(vo));
		
		List<RegisterDTO> list = regservice.dataAllSelect(vo);
		mav.addObject("vo", vo);
		mav.addObject("list", list);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/userList/userList");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	//(관리자 페이지)회원정보 수정폼
	@GetMapping("/userEdit/{userid}")
	public ModelAndView loginEdit(@PathVariable("userid") String userid, HttpSession session) {
		RegisterDTO dto = regservice.registerEdit(userid);
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		mav.addObject("dto", dto);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/userList/userEdit");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	//(관리자 페이지)회원활동내역
	@GetMapping("/userLog/{userid}")
	public ModelAndView userLog(@PathVariable("userid") String userid, String searchKey, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		//UserLogDTO dto = regservice.userLogSelect(userid);
		List<UserLogDTO> list = regservice.userLogSelect(userid);
		List<UserLogDTO> listNorm = regservice.userLogNormSelect(userid);
		
		mav.addObject("userid", userid);
		if(searchKey == null ||searchKey.equals("all")) {
			mav.addObject("list", list);
			mav.addObject("listNorm", listNorm);
		}else if(searchKey.equals("rank_game")) {
			mav.addObject("list", list);
		}else if(searchKey.equals("norm_game")) {
			mav.addObject("listNorm", listNorm);
		}
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/userList/userLog");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	//(관리자) 수입내역
	@GetMapping("/revenue")
	public ModelAndView revenue(PagingVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);
						
		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);
				
		// 총레코드 수 세팅
		vo.setTotalRecord(service.revenueTotalRecord(vo));
		
		//전체 수입내역 리스트
		List<UserPayDTO> pay = service.revenue(vo);
		
		mav.addObject("pay", pay);
		mav.addObject("vo", vo);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/revenue/revenue");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	//(관리자) 지출내역
	@GetMapping("/expense")
	public ModelAndView expense(PagingVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);

		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);

		// 총레코드 수 세팅
		vo.setTotalRecord(service.expenseTotalRecord(vo));
		
		List<AdminManagerSettlementDTO> expense = service.expense(vo);
		
		mav.addObject("expense", expense);
		mav.addObject("vo", vo);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/revenue/expense");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	//(관리자) 매니저비
	@GetMapping("/managerfee")
	public ModelAndView managerFee(PagingVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);
								
		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);
						
		// 총레코드 수 세팅
		vo.setTotalRecord(service.managerFeeTotalRecord(vo));
		
		List<AdminManagerSettlementDTO> managerFee = service.managerFee(vo);
		
		mav.addObject("managerFee", managerFee);
		mav.addObject("vo", vo);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/revenue/managerFee");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// (관리자) 매니저 지급 완료
	@PostMapping("/waitOk")
	public ModelAndView waitOk(AdminManagerSettlementDTO dto) {
		// 지급일 셋팅
		Date datetime = new Date();
		dto.setDatetime(datetime);
		
		ModelAndView mav = new ModelAndView();
		int cnt = service.waitOk(dto);
		if(cnt>0) {
			mav.setViewName("redirect:/admin/managerfee");
		}else {
			mav.addObject("msg", "회원정보수정 실패하였습니다.");
			mav.setViewName("redirect:/admin/managerfee");
		}

		return mav;
	}
	
	// 종목 목록
	@GetMapping("/sport/sportlist")
	public ModelAndView sportList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		List<SportDTO> sportList = sportService.sportAllSelect();
		
		mav.addObject("sportList", sportList);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/sport/sportList");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 종목 등록
	@GetMapping("/sport/new")
	public ModelAndView sportNew(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/sport/sportNew");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 종목 등록(DB)
	@PostMapping("/sport/newOk")
	public ModelAndView sportNewOk(HttpServletRequest request){
		SportDTO dto = new SportDTO();
		dto.setSportname(request.getParameter("sportname"));
		dto.setSportdesc(request.getParameter("sportdesc"));
		
		// 파일 업로드 구현
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		// mr에서 MultipartFile객체를 얻어오기
		MultipartFile file = mr.getFile("filename"); //form에 있는 name
		
		// 파일을 서버에 업로드할 위치의 절대주소
		String path = request.getSession().getServletContext().getRealPath("/uploadfile/sport");
		System.out.println("path->" + path);
		
		// 경로에 폴더가 존재하지 않으면 폴더 생성
		if (!new File(path).exists()) {
			new File(path).mkdirs();
        }
		
		if(file!=null) {//업로드 파일이 있을 경우			
			String orgFilename = file.getOriginalFilename();// 사용자가 업로드한 파일명
			if(orgFilename != null && !orgFilename.equals("")) {
				// 같은 파일명이 이미 존재하면 rename 수행
				File f = new File(path, orgFilename);
				if(f.exists()) {
					//	abc.gif -> abc (1).gif -> abc (2).gif -> abc (3).gif
					for(int renameNum=1;;renameNum++) {// 1,2,3,4....
						// 파일명, 확장자를 나눈다.
						int point = orgFilename.lastIndexOf(".");// 마지막 .의 위치구하기
						String orgFile = orgFilename.substring(0, point);// 확장자를 뺀 파일명
						String orgExt = orgFilename.substring(point+1);// 확장자
						
						String newFilename = orgFile+" ("+renameNum+")."+orgExt;//새로만들어진 파일명
						f = new File(path, newFilename);
						if(!f.exists()) {// 새로 만들 파일이 존재하지 않으면 반복문 중단
							orgFilename = newFilename;
							break;
						}
					}
				}
				
				// 파일 업로드 수행
				try {
					file.transferTo(new File(path, orgFilename));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				// 파일명을 DB에 저장하기 위해 dto에 셋팅
				dto.setFilename(orgFilename);
			}
		}

		ModelAndView mav = new ModelAndView();
		try {
			// 작성된 글 내용을 DB에 저장
			int result = sportService.sportInsert(dto);

			// 정상처리되면 종목 목록 페이지로 이동
			mav.setViewName("redirect:sportlist");
			
		}catch(Exception e) {
			// 레코드 추가 에러
			e.printStackTrace();
			
			// 파일삭제 
			fileDelete(path, dto.getFilename());
			
			// DB에 저장된 레코드 삭제
			sportService.sportDelete(dto.getS_no());
			
			mav.addObject("msg", "종목 등록 실패하였습니다.");
			mav.setViewName("admin/dataResult");
		}
		
		return mav;
	}           

	// 업로드된 파일 삭제
	public void fileDelete(String path, String filename) {
		File f = new File(path, filename);
		f.delete();
	}
	
	// 종목 수정
	@GetMapping("/sport/edit")
	public ModelAndView sportNew(int s_no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		SportDTO sportInfo = sportService.sportOneSelect(s_no);
		
		mav.addObject("sportInfo", sportInfo);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/sport/sportEdit");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 종목 수정(DB)
	@PostMapping("/sport/editOk")
	public ModelAndView sportEditOk(int no, HttpServletRequest request){
		SportDTO dto = new SportDTO();
		dto.setSportname(request.getParameter("sportname"));
		dto.setSportdesc(request.getParameter("sportdesc"));
		
		// 기존에 DB에 저장되어 있는 파일명 받아오기
		SportDTO sportInfo = sportService.sportOneSelect(no);
		String fileBeforeEdit = sportInfo.getFilename();
		
		// 파일 업로드 구현
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		// mr에서 MultipartFile객체를 얻어오기
		MultipartFile file = mr.getFile("filename"); //form에 있는 name

		// 파일을 서버에 업로드할 위치의 절대주소
		String path = request.getSession().getServletContext().getRealPath("/uploadfile/sport");
		System.out.println("path->" + path);
		
		if(file!=null) {//업로드 파일이 있을 경우
			String orgFilename = file.getOriginalFilename();// 사용자가 업로드한 파일명
			if(orgFilename != null && !orgFilename.equals("")) {
				// 같은 파일명이 이미 존재하면 rename 수행
				File f = new File(path, orgFilename);
				if(f.exists()) {
					//	abc.gif -> abc (1).gif -> abc (2).gif -> abc (3).gif
					for(int renameNum=1;;renameNum++) {// 1,2,3,4....
						// 파일명, 확장자를 나눈다.
						int point = orgFilename.lastIndexOf(".");// 마지막 .의 위치구하기
						String orgFile = orgFilename.substring(0, point);// 확장자를 뺀 파일명
						String orgExt = orgFilename.substring(point+1);// 확장자
						
						String newFilename = orgFile+" ("+renameNum+")."+orgExt;//새로만들어진 파일명
						f = new File(path, newFilename);
						if(!f.exists()) {// 새로 만들 파일이 존재하지 않으면 반복문 중단
							orgFilename = newFilename;
							break;
						}
					}
				}
				
				// 파일 업로드 수행
				try {
					file.transferTo(new File(path, orgFilename));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				// 파일명을 DB에 저장하기 위해 dto에 셋팅
				dto.setFilename(orgFilename);
			}
		}

		ModelAndView mav = new ModelAndView();
		try {
			// 수정된 글 내용을 DB에 업데이트
			sportService.sportInsert(dto);
			
			// 글 수정 전의 기존 파일 삭제
			fileDelete(path, fileBeforeEdit);

			// 정상처리되면 종목 목록 페이지로 이동
			mav.setViewName("redirect:sportlist");
			
		}catch(Exception e) {
			// 레코드 추가 에러
			e.printStackTrace();
			
			// 새로 업로드된 파일삭제 
			fileDelete(path, dto.getFilename());
			
			mav.addObject("msg", "종목 수정 실패하였습니다.");
			mav.setViewName("admin/dataResult");
		}
		
		return mav;
	}
	
	// 랭크경기 목록
	@GetMapping("/rankgame/rankgamelist")
	public ModelAndView rankGameList(PagingVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);
				
		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);
		
		// 총레코드수를 구하여 PagingVO에 세팅
		vo.setTotalRecord(rankGameService.totalRecord());
		
		mav.addObject("rankGameList", rankGameService.pageSelect(vo)); // 해당페이지 레코드 선택하기
		mav.addObject("vo", vo); // view페이지로 페이지정보를 세팅
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/rankGame/rankGameList");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 일반경기 목록
	@GetMapping("/normgame/normgamelist")
	public ModelAndView normGameList(PagingVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);
		
		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);
		
		// 총레코드수를 구하여 PagingVO에 세팅
		vo.setTotalRecord(normGameService.totalRecord());
		
		// DB조회
		mav.addObject("normGameList", normGameService.pageSelect(vo)); // 해당페이지 레코드 선택하기
		mav.addObject("vo", vo); // view페이지로 페이지정보를 세팅
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/normGame/normGameList");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 경기 등록
	@GetMapping("/game/new")
	public ModelAndView rankGameNew(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		List<SportDTO> sportList = sportService.sportAllSelect();
		List<StadiumInfoDTO> stadiumInfoList = stadiumInfoService.stadiumInfoAllSelect();
		
		mav.addObject("sportList", sportList);
		mav.addObject("stadiumInfoList", stadiumInfoList);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/rankGame/rankGameNew");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 랭크경기 등록(DB)
	@PostMapping("/rankgame/ranknewOk")
	public ResponseEntity<String> rankgameNewOk(RankGameDTO dto, HttpServletRequest request){
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		try {
			// 작성된 랭크경기 내용을 DB에 저장
			rankGameService.rankGameInsert(dto);
			
			// 랭크경기 목록으로 이동
			String body = "<script> alert('랭크경기를 등록하였습니다.'); location.href='/admin/rankgame/rankgamelist';</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.OK);
		}catch(Exception e) {
			// 랭크경기 등록 실패
			e.printStackTrace();
			String body = "<script>";
			body += "alert('랭크경기 등록을 실패하였습니다.');";
			body += "history.go(-1);";
			body += "</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 일반경기 등록(DB)
	@PostMapping("/normgame/normnewOk")
	public ResponseEntity<String> normgameNewOk(NormGameDTO dto, HttpServletRequest request){
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		try {
			// 작성된 일반경기 내용을 DB에 저장
			normGameService.normGameInsert(dto);

			// 일반경기 목록으로 이동
			String body = "<script> alert('일반경기를 등록하였습니다.'); location.href='/admin/normgame/normgamelist';</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.OK);
		}catch(Exception e) {
			// 일반경기 등록 실패
			e.printStackTrace();
			String body = "<script>";
			body += "alert('일반경기 등록을 실패하였습니다.');";
			body += "history.go(-1);";
			body += "</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 랭크경기 수정
	@GetMapping("/rankgame/edit")
	public ModelAndView rankGameList(int no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		List<SportDTO> sportList = sportService.sportAllSelect();
		List<StadiumInfoDTO> stadiumInfoList = stadiumInfoService.stadiumInfoAllSelect();
		RankGameDTO rankgameInfo = rankGameService.rankGameOneSelect(no);
		
		// gametime의 데이터 타입을 Date -> String으로 변환
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		String gametimeStr = df.format(rankgameInfo.getGametime());
		
		mav.addObject("gametimeStr", gametimeStr);
		mav.addObject("sportList", sportList);
		mav.addObject("stadiumInfoList", stadiumInfoList);		
		mav.addObject("rankgameInfo", rankgameInfo);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/rankGame/rankGameEdit");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 랭크경기 수정(DB)
	@PostMapping("/rankgame/editOk")
	public ResponseEntity<String> rankgameEditOk(RankGameDTO dto, HttpServletRequest request){
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		try {
			// 수정된 내용을 DB에 업데이트
			rankGameService.rankGameUpdate(dto);
			
			// 랭크경기 목록으로 이동
			String body = "<script> location.href='/admin/rankgame/rankgamelist';</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.OK);
		}catch(Exception e) {
			// 랭크경기 수정 실패
			e.printStackTrace();
			String body = "<script>";
			body += "alert('랭크경기 수정을 실패하였습니다.');";
			body += "history.go(-1);";
			body += "</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 일반경기 수정
	@GetMapping("/normgame/edit")
	public ModelAndView normGameList(int no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");

		List<SportDTO> sportList = sportService.sportAllSelect();
		List<StadiumInfoDTO> stadiumInfoList = stadiumInfoService.stadiumInfoAllSelect();
		NormGameDetailDTO normgameInfo = normGameService.normGameDetailSelect(no);

		// gametime의 데이터 타입을 Date -> String으로 변환
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		String gametimeStr = df.format(normgameInfo.getGametime());

		mav.addObject("gametimeStr", gametimeStr);
		mav.addObject("sportList", sportList);
		mav.addObject("stadiumInfoList", stadiumInfoList);		
		mav.addObject("normgameInfo", normgameInfo);

		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/normGame/normGameEdit");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 랭크경기 수정(DB)
	@PostMapping("/normgame/editOk")
	public ResponseEntity<String> normgameEditOk(NormGameDetailDTO dto, HttpServletRequest request){
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		try {
			// 수정된 내용을 DB에 업데이트
			normGameService.normGameDetailUpdate(dto);

			// 랭크경기 목록으로 이동
			String body = "<script> location.href='/admin/normgame/normgamelist';</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.OK);
		}catch(Exception e) {
			// 랭크경기 수정 실패
			e.printStackTrace();
			String body = "<script>";
			body += "alert('일반경기 수정을 실패하였습니다.');";
			body += "history.go(-1);";
			body += "</script>";
			entity = new ResponseEntity<String>(body, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
		
	// 매니저 승인 요청 목록
	@GetMapping("/manager/approvelist")
	public ModelAndView managerApproveList(PagingVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);
								
		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);
						
		// 총레코드수를 구하여 PagingVO에 세팅
		vo.setTotalRecord(adminManagerService.managerApproveTotalRecord());
		
		// 매니저 계정 승인 요청 목록을 DB에서 조회
		mav.addObject("list", adminManagerService.approveList(vo));
		mav.addObject("vo", vo);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/allManager/managerApproveList");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 매니저 승인 요청 상세 페이지
	@GetMapping("/manager/approvedetail")
	public ModelAndView managerApproveDetail(String managerid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		mav.addObject("dto", adminManagerService.approveDetail(managerid));
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/allManager/managerApproveDetail");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 매니저 요청 승인 (매니저 계정 활성화)
	@PostMapping("/manager/approveOk")
	public ModelAndView managerApproveOk(String managerid) {
		ModelAndView mav = new ModelAndView();
		
		adminManagerService.approveOk(managerid);
		
		mav.setViewName("redirect:approvelist");
		
		return mav;
	}
	
	// 매니저 요청 거부 (요청 계정 DB에서 삭제)
	@PostMapping("/manager/refuseOk")
	public ModelAndView managerRefuseOk(String managerid) {
		ModelAndView mav = new ModelAndView();
		
		adminManagerService.refuseOk(managerid);
		
		
		mav.setViewName("redirect:approvelist");
		
		return mav;
	}
	
	// 매니저 목록 조회
	@GetMapping("/manager/managerlist")
	public ModelAndView managerList(PagingVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		// 한 페이지에 표시할 레코드수
		vo.setOnePageRecord(10);
						
		// 페이지 목록에 표시할 페이지 갯수
		vo.setOnePageNumCount(5);
				
		// 총레코드수를 구하여 PagingVO에 세팅
		vo.setTotalRecord(adminManagerService.managerTotalRecord());
		
		List<ManagerDTO> olist = adminManagerService.managerList(vo);
		List<ManagerDTO> nlist = new ArrayList<ManagerDTO>();
		
		try {
			Iterator<ManagerDTO> ir = olist.iterator();
			
			while(ir.hasNext()) {
				ManagerDTO dto = ir.next();
				String managerid = dto.getManagerid();
				
				List<RankGameDTO> recent = adminManagerService.managerRecent(managerid);
				
				if(!recent.isEmpty()) dto.setRankgameList(recent);
				
				nlist.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		mav.addObject("list", nlist);
		mav.addObject("vo", vo);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/allManager/managerList");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 매니저 상세 페이지
	@GetMapping("/manager/managerdetail")
	public ModelAndView managerDetail(String managerid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		mav.addObject("dto", adminManagerService.managerDetail(managerid));
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/allManager/managerDetail");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
	
	// 매니저 제명
	@PostMapping("/manager/dismissOk")
	public ModelAndView managerDismiss(String managerid) {
		ModelAndView mav = new ModelAndView();
		
		adminManagerService.refuseOk(managerid);
		
		mav.setViewName("redirect:managerlist");
		
		return mav;
	}
	
	// 매니저 활동 내역
	@PostMapping("/manager/recentOk")
	public ModelAndView managerRecent(String managerid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String adminlogStatus = (String) session.getAttribute("adminlogStatus");
		
		List<StadiumInfoDTO> stadium = new ArrayList<StadiumInfoDTO>();
		
		ManagerDTO dto = adminManagerService.managerDetail(managerid);
		
		List<RankGameDTO> recent = adminManagerService.managerRecent(managerid);
		
		if(recent.isEmpty()) {
			
			recent = null;
			
		}else {
		
			Iterator<RankGameDTO> ir = recent.iterator();
			
			while(ir.hasNext()) {
				RankGameDTO rdto = ir.next();
				StadiumInfoDTO sdto = stadiumInfoService.stadiumInfoOneSelect(rdto.getSt_no());
				stadium.add(sdto);
			}
		}
		
		mav.addObject("dto", dto);
		mav.addObject("recent", recent);
		mav.addObject("stadium", stadium);
		
		if(adminlogStatus.equals("Y")) {
			mav.setViewName("admin/allManager/managerRecent");
		}else {
			mav.setViewName("redirect:/login");
		}
		return mav;
	}
}
