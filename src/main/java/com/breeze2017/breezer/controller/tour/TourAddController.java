package com.breeze2017.breezer.controller.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.breeze2017.breezer.service.tour.TourAddService;
import com.breeze2017.breezer.vo.TourVo;

@Controller
@RequestMapping("tour")
public class TourAddController {
	
	@Autowired
	private TourAddService tourAddService;
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String tourAdd(@ModelAttribute TourVo vo, Model model) {
		System.out.println(">> tourAdd Controller");
		System.out.println(vo);
		tourAddService.insertMessage(vo);
		
		return "tour/tour_main";
	}
	
}
