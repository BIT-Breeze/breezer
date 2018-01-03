package com.breeze2017.breezer.service.fileupload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

@Service
public class MultiFileUploadService {
	
	private static String SAVE_PATH = "/uploads";
	private static String PREFIX_URL = "/uploads/images/";

	public List<MultipartFile> restore(List<MultipartFile> multipartFile) {
		
		System.out.println(multipartFile.get(0));
		System.out.println("multpart size >> " + multipartFile.size());
		//System.out.println("#from service >>" + ((MultipartFile) multipartFile).getOriginalFilename());
		//System.out.println("#from service >>" + multipartFile);
		//System.out.println("#from service >>" + ((MultipartRequest) multipartFile).getFile("multiFile"));
		
		String url = "";
		String path = "D://uploads";
		//Map<Integer, String> resultURL = new HashMap<Integer, String>();
		List<MultipartFile> resultURL = new ArrayList<>();
		
		File file = new File(path);
		if(!file.exists()) {
			file.mkdirs();
			System.out.println("create a folder - success !");
		}
		
		for (int i = 1; i <= multipartFile.size(); i++) {
			try {
				String originalFileName = ((MultipartFile) multipartFile).getOriginalFilename();
				/* 파일 확장자 */
				String extName = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());
				Long size = ((MultipartFile) multipartFile).getSize();
				/* 파일이름을 변경해서 서버에 저장할 때, 이름이 중복되면 안됨 */
				String saveFileName = genSaveFileName(extName);
				
				System.out.println("######" + originalFileName);
				System.out.println("######" + extName);
				System.out.println("######" + saveFileName);
				System.out.println("######" + size);
	
				writeFile((MultipartFile) multipartFile, saveFileName);
	
				url = PREFIX_URL + saveFileName;
				System.out.println("######" + url);

				
			} catch (IOException ex) {
				throw new RuntimeException(ex);
			}
			
		} // end for
		return resultURL;
		
	}
	
	
	private void writeFile(MultipartFile multipartFile, String saveFileName) throws IOException {
		byte[] fileData = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(fileData);
		fos.close();
	}
	

	private String genSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);

		fileName += extName;

		return fileName;
	}
}

