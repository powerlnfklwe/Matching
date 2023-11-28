package com.gather.we.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gather.we.dto.ManagerDTO;
import com.gather.we.dto.SportDTO;
import com.gather.we.service.ManagerService;
import com.gather.we.service.SportService;

@Controller
public class ManagerController {
	@Autowired
	ManagerService service;
	
	@Autowired
	SportService sportservice;
	
	//ȸ���� ��
	@GetMapping("/manager")
	public ModelAndView manager() {
		
		ModelAndView mav = new ModelAndView();
		List<SportDTO> sportList = sportservice.dataSelect();
		mav.addObject("sportList", sportList);
		mav.setViewName("manager/manager");
		return mav;
	}
	
	//ȸ������(db)
	@PostMapping("/managerOk")
	public ModelAndView managerOk(HttpServletRequest request){
		ManagerDTO dto = new ManagerDTO();
		dto.setManagerid(request.getParameter("managerid"));
		dto.setType(request.getParameter("type"));
		dto.setPassword(request.getParameter("password"));
		dto.setM_name(request.getParameter("m_name"));
		dto.setAddress(request.getParameter("address"));
		dto.setEmail(request.getParameter("email"));
		dto.setGender(request.getParameter("gender"));
		dto.setM_account(request.getParameter("m_account"));
		
		String tel =request.getParameter("tel1") +"-"+ request.getParameter("tel2") +"-"+ request.getParameter("tel3");
		dto.setTel(tel);
		dto.setS_no(Integer.parseInt(request.getParameter("s_no")));
	//public ModelAndView managerOk(MultipartHttpServletRequest multi, ManagerDTO dto){
		System.out.println("qwer");
		// ���Ͼ�ε屸��
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		// mr���� MultipartFile��ü �����
		MultipartFile file = mr.getFile("prooffile"); //form�� �ִ� name
		//MultipartFile file = multi.getFile("prooffile");
		
		// ����� ���� ��ε��� �ġ�� ����ּ�
		//String path = request.getSession().getServletContext().getRealPath("/uploadfile");
		String path = request.getSession().getServletContext().getRealPath("/uploadfile");
		System.out.println("path->" + path);
		
		if(file!=null) {//��ε� ������ ��� ���			
			String orgFilename = file.getOriginalFilename();// ����ڰ� ��ε��� ���ϸ�
			if(orgFilename != null && !orgFilename.equals("")) {
				// ��� ���ϸ��� �̹� ����ϸ� rename ����
				File f = new File(path, orgFilename);
				if(f.exists()) {
					//	abc.gif -> abc (1).gif -> abc (2).gif -> abc (3).gif
					for(int renameNum=1;;renameNum++) {// 1,2,3,4....
						// ���ϸ�, Ȯ���ڸ� ������.
						int point = orgFilename.lastIndexOf(".");// ���� .�� �ġ ���ϱ�
						String orgFile = orgFilename.substring(0, point);// Ȯ���ڸ� �� ���ϸ�
						String orgExt = orgFilename.substring(point+1);// Ȯ����
						
						String newFilename = orgFile+" ("+renameNum+")."+orgExt;//��� ������� ���ϸ�
						f = new File(path, newFilename);
						if(!f.exists()) {// ��� ���� ������ ������� ����� �ݺ��� �ߴ�
							orgFilename = newFilename;
							break;
						}
					}
				}
				
				// ���� ��ε� ����
				try {
					file.transferTo(new File(path, orgFilename));
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				// ���ϸ�� db�� �����ϱ� ��� dto�� ����
				dto.setProoffile(orgFilename);
			}
		}

		ModelAndView mav = new ModelAndView();
		try {
			// �ۼ��� �� ����� db�� ����
			int result = service.managerInsert(dto);

			// ���ó���Ǹ� ��� ��� ������� �̵�
			mav.setViewName("redirect:/loginMan");
			
		}catch(Exception e) {
			// ���ڵ� �߰� ����
			e.printStackTrace();
			
			// ���� ���
			fileDelete(path, dto.getProoffile());
			
			// DB�� ����� ���ڵ� ���
			service.dataDelete(dto.getManagerid());
			mav.addObject("msg", "ȸ�� ��� �����Ͽ���ϴ�.");
			mav.setViewName("manager/managerOkResult");
		}
		return mav;
	}
	//아이디 중복검사 폼
	@GetMapping("/idCheckMan")
	public String idCheck(String managerid, Model model) {
		//조회
		//아이디 갯수 구하기 - 0,1
		int result = service.idCheckCount(managerid);
		
		//뷰에서 사용하기 위해서 모델에 세팅
		model.addAttribute("managerid", managerid);
		model.addAttribute("result", result);
		
		return "manager/idCheck";
	}
		// ��ε�� ���� ���
		public void fileDelete(String path, String filename) {
			File f = new File(path, filename);
			f.delete();
		}
		
		//�Ŵ��� �α���
		@GetMapping("/loginMan")
		public String loginMan() {
			return "manager/loginMan";	
		}
		
		//�Ŵ��� �α���(DB)
		@PostMapping("/loginManOk")
		public ModelAndView loginManOk(String managerid, String password, HttpServletRequest request, HttpSession session) {
			// Session ��ü �����
			// �Ű������ HttpServletRequest request -> Session ���ϱ�
			// �Ű������ HttpSession session
			System.out.println("managerid->"+managerid);
			ManagerDTO dto = service.loginManOk(managerid, password);
			// dto->null�� ��� ���÷��ڵ尡 ���. -�α��� ����
			// 		null�� �ƴ� ��� ���÷��ڵ� �ִ�. - �α��� ����
			ModelAndView mav = new ModelAndView();
			System.out.println(dto);
			if(dto!=null && dto.getActive()== 1) {//�α��� ����
				session.setAttribute("logId", dto.getManagerid());
				session.setAttribute("logName", dto.getM_name());
				session.setAttribute("logS_no", dto.getS_no());
				session.setAttribute("logStatus", "Y");
				System.out.println(dto);
				mav.setViewName("redirect:/manager/rankgamelist");
			}else{//로그인 실패
				mav.addObject("msg", "매니저 승인대기중입니다.");
				mav.setViewName("manager/loginFailResult");
				System.out.println(managerid);
				System.out.println(password);
			}
			return mav;
		}
		//���̵� �ߺ��˻� ��
		@GetMapping("/manidCheck")
		public String manidCheck(String managerid, Model model) {
			//��ȸ
			//���̵��� ���� ���ϱ� - 0,1
			int result = service.idCheckCount(managerid);
			
			//�信�� ����ϱ� ���ؼ� �𵨿� ����
			model.addAttribute("managerid", managerid);
			model.addAttribute("result", result);
			
			return "manager/idCheck";
		}
			
}
