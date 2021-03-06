<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/breezer/assets/js/jquery/jquery-1.9.0.js" type="text/javascript"></script>
<script src="/breezer/assets/js/bootstrap.js" type="text/javascript"></script>
<script src="/breezer/assets/js/bootstrap.min.js" type="text/javascript"></script>

<script type="text/javascript">
	
	var imagePath = ""; // 이미지 경로 저장 변수
	var file = $('[name="file"]');
	var sel_files = []; // 파일 저장되는 변수 [배열]
	
	// #fileUpload를 했을때 실행
	$(document).ready(function() {
		
		
		// jsp에 사진이 업로드 되어있는 상태면 다르게 동작해야되지 않을까(파일을 추가해야 됨, 초기화되서 업로드가 아니라)
		// 그럼 fileUpload 버튼 클릭시 if문을 사용해야하는걸까
		// 글구 삭제도 되야함
		
	//	if(('#multiImgContainer').isEmpty != null) {
	//		$('#fileUpload').on('change', )	
	//	}
	 $('#fileUpload').on('change', ImgFileSelect);
	
	});
	
	
	
	// 파일 업로더 했을 때 실행되는 함수
	function ImgFileSelect(e) {
		console.log("====== ImgFileSelect ======");
		var files = e.target.files; // 넘어 오는 파일들을 files에 담고
		var filesArr = Array.prototype.slice.call(files); // 제목을 분할하여 filesArr에 저장
		
		var index = 0; // 순서를 위해 index를 선언
		filesArr.forEach(function(f) { // 반복문으로
			index++; // 인덱스를 한순차씩 올려주며
			sel_files.push(f); // 배열로 선언했던 파일저장변수에 하나씩 push
			console.log(f); // 로그 출력
			
		});
		
		//console.log("sel_files = "+sel_files)
		
		var formData = new FormData($('#MultifileForm')[0]);
		$.ajax({
			url: '/breezer/upload/multiechofile',
			type: "POST",
			dataType : "json",
			data: formData,
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
		}).success(function(response) {
			
			var multiImgContainer = $('#multiImgContainer');
			var index = 0;
			var currentIndex = 0;
			multiImgContainer.html('');
			
			for ( data in response.data ) {
				console.log("data[" + index + "] >> " + response.data[index])
				
				if ( index > 0 ) {
					imagePath += ',';
				}
				
				// var img = '<img src="${pageContext.request.contextPath }'+ response.data[index] +'"/>';
				
				var img = '<img src="${pageContext.request.contextPath }'+ response.data[index] +'" width="480" height="320"/>';
				multiImgContainer.append(img);
				
				// image path 설정해서 DB에 때려박을 url경로 보내주기위해 하는 짓
				imagePath += response.data[index];
				index++;
			}
			currentIndex = index; // 현재 인덱스 저장
		
		}).fail(function(jqXHRm, textStatus) {
			alert('File upload failed ... >> ' + jqXHRm + ', ' + textStatus); 
		});
	}
	
	
	var add = function() {
		$("#imagePath").val(imagePath);
		document.getElementById("addform").submit();
	}

</script>

<title>Breezer</title>
</head>

<body>

	<div id="top-section">
	
	</div>
	
	<!-- 메인 포토 -->
	<div id=imgContainer>
	</div>
	
	<form id="addform" method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/post/add">
		<div>
			location <input type="text" value="location" name="location"><br>
			category <input type="text" value="0" name="category"><br>
			price <input type="text" value="0" name="price"><br>
			score <input type="text" value="0" name="score"><br>
			content <input type="text" value="content" name="content"><br>
			<input type="hidden"  id="imagePath" value="imagePath" name="photo"><br>
			<input type="hidden" name="tourIdx" value=${tourIdx }>
	
			<div id=multiImgContainer></div>
			
			<!-- Map Modal 띄우기 -->
			<!-- <input type="button" value="map" onclick=""><br><br> -->
			
			<!-- MODAL TEST -->
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
			  Modal 띄우기(MAP)
			</button>
			
		  
			
			<input type="button" value="add" onclick="add()"><br><br>
		</div>
	</form>
	
	<!-- 다중 파일 업로더 -->
	<form id="MultifileForm">
		<input type="file" multiple="multiple" name="multiFile" id="fileUpload"><br><br>
	</form>
	
</body>

</html>



		 
	<!-- MODAL
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">Modal 제목</h4>
			      </div>
			      <div class="modal-body">
			        Modal 내용
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div></div>
	 -->
