package com.breeze2017.breezer.controller.api.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.post.PostAddService;
import com.breeze2017.breezer.vo.PostVo;

@Controller("postAddAPIController")
@RequestMapping("{id}/api/post")
public class PostAddController {

	@Autowired
	private PostAddService postAddService;
	
	@ResponseBody
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public JSONResult postAdd(
			@ModelAttribute PostVo vo,
			@PathVariable String id
			) {
		
		String[] tripDateTime = vo.getTripDateTime().split(" ");
				
		String date = tripDateTime[0];
		String[] time = tripDateTime[1].split(":");
		String hour = time[0];
		String min = time[1];
		String amPm = tripDateTime[2];
		
		if(amPm.equalsIgnoreCase("pm") && Integer.parseInt(hour) < 12) {
			hour = String.valueOf(Integer.valueOf(hour) + 12);
		}
		vo.setTripDateTime(date+" "+hour+":"+min);
		
		vo.setUserId(id);
		
		boolean YN = postAddService.insertPost(vo);
		
		return JSONResult.success(YN);
	}
}
