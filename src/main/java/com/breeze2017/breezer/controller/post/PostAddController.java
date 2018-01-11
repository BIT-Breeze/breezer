package com.breeze2017.breezer.controller.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String addPost(
			@RequestParam(value="tourIdx", required=true) long tourIdx,
			Model model) {
		
		model.addAttribute("tourIdx", tourIdx);	
		
		return "post/post_add";
	}
	
	@Auth
	@RequestMapping(value="post/add", method=RequestMethod.POST)
	public String addPost(@ModelAttribute PostVo vo, @PathVariable String id) {
		System.out.println("====== post/add(post) ======");
		System.out.println("PostVo : " + vo );
		
		
		System.out.println("--id--:" + id);
		System.out.println(" >> PostAddController post/add");
		vo.setUserId(id);
		postAddService.insertMessage(vo);

		//return은 임시
		//return "post/post_add";
		return "redirect:/"+id+"/tour?idx="+vo.getTourIdx();
	}
	
	
}
