package com.breeze2017.breezer.controller.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.breeze2017.breezer.service.tour.TourAddService;
import com.breeze2017.breezer.vo.TourVo;
import com.breeze2017.security.Auth;

@Controller
@RequestMapping("/{id}")
public class TourAddController {
	
	@Autowired
	private TourAddService tourAddService;
	
	@Auth
	@RequestMapping(value="tour/add", method=RequestMethod.GET)
	public String tourAdd() {
		return "tour/tour_add";
	}
	
	@Auth
	@RequestMapping(value="tour/add", method=RequestMethod.POST)
	public String tourAdd(@ModelAttribute TourVo vo) {
		System.out.println(">> tourAdd Controller");
		System.out.println(vo);
		tourAddService.insertMessage(vo);
		
		return "tour/tour_main";
	}
	
	/* 임시로 만든거 */
	@Auth
	@RequestMapping("tour/movepostadd")
	public String moveAddPost() {
		return "post/post_add";
	}
	
}