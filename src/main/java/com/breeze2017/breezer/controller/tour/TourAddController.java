package com.breeze2017.breezer.controller.tour;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		System.out.println("TourVo : "+vo);
		System.out.println(id);
		vo.setUserId(id);
		tourAddService.insertMessage(vo);
		
		System.out.println("current idx >> " + vo.getIdx());
		
		return "redirect:/{id}/tour?idx="+vo.getIdx();
	}

	
	@Auth
	@ResponseBody
	@RequestMapping(value="tour/modify", method=RequestMethod.POST)
	public String tourModify( @ModelAttribute TourVo vo, @PathVariable String id) {
		System.out.println(">> TourAddController tour/modify");

		vo.setUserId(id);
		
		System.out.println("modify vo : " + vo );
		
		tourAddService.modify(vo);

		System.out.println("after vo :" + vo );
		
		return "";
		
	}

	
	
	
	
/*	
	@Auth
	@RequestMapping(value="tour/modify", method=RequestMethod.POST)
	public String tourModify( 
			@RequestParam(value="title", required=false) String title,
			@RequestParam(value="startDate", required=false) String startDate,
			@RequestParam(value="endDate", required=false) String endDate,
			@RequestParam(value="idx", required=false) Long idx,
			@RequestParam(value="mainPhoto", required=false) String mainPhoto,
			Model model
			) {
		
		System.out.println(">> TourAddController tour/modify");
		
		TourVo vo = new TourVo();
		vo.setTitle(title);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		vo.setIdx(idx);
		vo.setMainPhoto(mainPhoto);

		System.out.println(vo);
		
		tourAddService.modify(vo);
		
		return "redirect:/{id}/tour?idx="+vo.getIdx();
		
	}*/
}





