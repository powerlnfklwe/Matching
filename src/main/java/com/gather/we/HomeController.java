package com.gather.we;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("redirect:/welcome");
		
		return mav;
	}
	
	@GetMapping("/welcome")
	public String welcome() {
		
		return "home";
	}
	
	@GetMapping("/userHome")
	public ModelAndView userHome(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			String logName = (String)session.getAttribute("logName");
			mav.addObject(logName);
			mav.setViewName("user/userHome");
		}catch(Exception e) {
			mav.setViewName("user/userHome");
		}
		return mav;
	}
}
