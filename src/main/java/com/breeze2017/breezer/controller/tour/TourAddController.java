package com.breeze2017.breezer.controller.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
	public String tourAdd( @ModelAttribute TourVo vo, @PathVariable String id ) {

		System.out.println(">> TourAddController tour/add");
		
		vo.setUserId(id);
		tourAddService.insertMessage(vo);
		
		
		
		return "redirect:/{id}/tour?idx=";
	}
}