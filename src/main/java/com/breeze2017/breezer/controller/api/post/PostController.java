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
import com.breeze2017.breezer.service.post.PostService;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.security.Auth;

@Controller("postAPIController")
@RequestMapping("{id}/api/post")
public class PostController {

	@Autowired
	private PostService postService;
	
	@Auth
	@ResponseBody
	@RequestMapping(value="/select", method=RequestMethod.POST)
	public JSONResult postSelect(
			@RequestParam(value="tourIdx", required=true) long tourIdx,
			@ModelAttribute PostVo vo,
			@PathVariable String id
			) {

		vo.setUserId(id);
		vo.setTourIdx(tourIdx);
		
		vo = postService.selectPost(vo);
		
		if(vo == null) {
			return JSONResult.fail("포스트 정보 가져오기에 실패했습니다.");
		} else {
			return JSONResult.success(vo);
		}
	}
	
	@Auth
	@ResponseBody
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public JSONResult postModify(
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
		
		boolean successYN = postService.modifyPost(vo);
		
		if(successYN == false) {
			return JSONResult.fail("포스트 수정에 실패했습니다.");
		} else {
			return JSONResult.success(successYN);
		}
	}
	
	@Auth
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
		
		boolean successYN = postService.insertPost(vo);
		
		if(successYN == false) {
			return JSONResult.fail("포스트 등록에 실패했습니다.");
		} else {
			return JSONResult.success(successYN);
		}
	}
}
