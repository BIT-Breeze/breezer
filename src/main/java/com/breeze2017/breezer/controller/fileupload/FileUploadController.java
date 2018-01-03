package com.breeze2017.breezer.controller.fileupload;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.breeze2017.breezer.dto.JSONResult;
import com.breeze2017.breezer.service.fileupload.FileUploadService;

@Controller
@RequestMapping("/upload")
public class FileUploadController {
	
	@Autowired
	private FileUploadService fileUploadService;

	// Single Upload
	@ResponseBody
	@RequestMapping(value="/echofile", method=RequestMethod.POST)
	public String upload( @RequestParam("file") MultipartFile file, Model model ) {
		System.out.println(" >> fileupload controller");
		
		String url = fileUploadService.restore(file);
		model.addAttribute("url", url);
		
		System.out.println("=============================");
		System.out.println(" file >> " + file);
		System.out.println(" model >> " + model);
		System.out.println(" url >> " + url);
		System.out.println("=============================");
		
		return url;
	
	}
	
	// Multi Upload
	@ResponseBody
	@RequestMapping(value="/multiechofile", method=RequestMethod.POST)
	public JSONResult multiUpload( 
			//@RequestParam("file") MultipartFile file ) {
			MultipartHttpServletRequest multi) {
		
		
		
		System.out.println("====== multiUpload ======1");
		
		
		List<MultipartFile> mf = multi.getFiles("multiFile");
		
		for (int i=0; i<mf.size(); i++ ) {
			System.out.println( mf.get(i).getOriginalFilename() );
		}
		

		
		//System.out.println("file : "+file);
//		
//		
//		String url = fileUploadService.restore(file);
//		model.addAttribute("url", url);
//		
//		System.out.println("=============================");
//		System.out.println(" file >> " + file);
//		System.out.println(" model >> " + model);
//		System.out.println(" url >> " + url);
//		System.out.println("=============================");
		
		return JSONResult.success("-json-success-");
	}
	
	
	
	
	// 포스트 페이지에서 mainPhoto 가져오기
		@ResponseBody
		@RequestMapping(value="/getimage", method=RequestMethod.POST)
		public String getMainPhoto() {
			System.out.println(" >> getImage controller");
			
			return "post/addpost";
		}
	
	
	
	
}	
