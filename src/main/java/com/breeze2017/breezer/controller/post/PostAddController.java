package com.breeze2017.breezer.controller.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.breeze2017.breezer.service.post.PostAddService;
import com.breeze2017.breezer.vo.PostVo;
import com.breeze2017.security.Auth;

@Controller
@RequestMapping("/{id}")
public class PostAddController {

	@Autowired
	PostAddService postAddService;
	
	@Auth
	@RequestMapping(value="post/add", method=RequestMethod.GET)
	public String addPost() {
		return "post/post_add";
	}
	
	@Auth
	@RequestMapping(value="post/add", method=RequestMethod.POST)
	public String addPost(@ModelAttribute PostVo vo) {
		
		
		System.out.println(" >> PostAddController post/add");
		postAddService.insertMessage(vo);
		
		//return은 임시
		return "post/post_add";
	}
	
	
}
