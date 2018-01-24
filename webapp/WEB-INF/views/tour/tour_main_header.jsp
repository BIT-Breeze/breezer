<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- css --> 
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css"> --%>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main_header.css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- jQuery 기본 js파일 -->
<script src="/breezer/assets/js/jquery/jquery-1.9.0.js" type="text/javascript"></script>  

<!-- jQuery datepicker를 사용하기 위한 라이브러리 추가 -->
<!-- jQuery UI CSS파일 , jQuery UI 라이브러리 js파일, jQuery form 라이브러리 js파일 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css">
<script src="/breezer/assets/js/jquery/jquery-ui.js" type="text/javascript"></script>
<script src="/breezer/assets/js/jquery/jquery-ui.min.js" type="text/javascript"></script>
<script src="/breezer/assets/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/breezer/assets/js/bootstrap.js" type="text/javascript"></script>
<script src="/breezer/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!-- 달력 js -->
<script type="text/javascript">
$(function() {
	$("#modify_start-datepicker, #modify_end-datepicker").datepicker({
		showOn: "both", 
        buttonImage: "/breezer/assets/images/tour/calendar_button.JPG", 
        buttonImageOnly: true,
        changeMonth: true,
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달',
        showButtonPanel: true,
        closeText: '닫기',
        dateFormat: "yy-mm-dd"
 
	});
});

</script>

<!-- 이미지 파일 업로더 onchange -->
<script type="text/javascript">

var isJpg = function(name) {
	return name.match(/jpg$/i)
}

var isPng = function(name) {
	return name.match(/png$/i)
}

var imagePath;

$(document).ready(function() {
	var file = $('[name="file"]');

	$('#modify_fileUpload').on('change', function() {

		var filename = $.trim(file.val());
		
		if(!(isJpg(filename) || isPng(filename))) {
			alert('Please browse a JPG/PNG file to upload...');
			return;
		}
		
		var formData = new FormData($('#modify_fileForm')[0]);
		$.ajax({
			url: '/breezer/upload/echofile',
			type: "POST",
			data: formData,
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
		}).done(function(data) {
			var data = data;
			imagePath = data;
			
			// css selector를 통해 background 변경
			$("#header").css("background-color", "transparent");
			$("#tour_main_header").css("background-color", "transparent");
			$("#tour_main_header_bg").css('background-image',"url(${pageContext.request.contextPath }"+data+")");
			
		});
	});
});

</script>

<!-- 이미지 업로더 아이콘이미지로 변경 -->
<script type="text/javascript">
function check() {
	uploadEventOccur(document.getElementById('modify_fileUpload'),'click');
}

function uploadEventOccur(evEle, evType) {
	 if (evEle.fireEvent) {
	 	evEle.fireEvent('on' + evType);
	 } else {
		 var mouseEvent = document.createEvent('MouseEvents');
		 /* API문서 initEvent(type,bubbles,cancelable) */
		 mouseEvent.initEvent(evType, true, false);
		 
		 var transCheck = evEle.dispatchEvent(mouseEvent);
		 
		 if (!transCheck) {
		 //만약 이벤트에 실패했다면
		 console.log("클릭 이벤트 발생 실패!");
		 }
	 }
}

</script>

<!-- public, private checked 이미지 변경 및 hover -->
<script type="text/javascript">

var changeCode = 0;

function security() {
	securityEventOccur();
}

function securityEventOccur() {
	/* console.log("securityEventOccur() Clicked"); */
		
	if(changeCode == 1) {
		console.log("공개 상태 - changeCode:" + changeCode);
		$("#modify_publicImg").attr("class", "modify_public_ico");
		$("#modify_cover_public").attr("value", "public");
		$("#modify_publicImg").attr("src", "/breezer/assets/images/tour/public_button.png");
		$("#modify_public").attr("checked", "checked");
		$("#modify_private").removeAttr("checked");
		changeCode = 0;
		
	} else if (changeCode == 0) {
		console.log("비공개 상태 - changeCode:" + changeCode);
		$("#modify_publicImg").attr("class", "modify_private_ico");
		$("#modify_cover_public").attr("value", "private");
		$("#modify_publicImg").attr("src", "/breezer/assets/images/tour/private_button.png");
		$("#modify_private").attr("checked", "checked");
		$("#modify_public").removeAttr("checked");
		changeCode = 1;
		
	} else {
		alert("Error the public, private status!!");
	}

}

</script>

<!-- public, private hover -->
<script type="text/javascript">
$(function() {
	var class_name = $("#modify_publicImg").attr("class"); 

	if (class_name == "modify_public_ico") {
		$("#modify_publicImg").hover(
			function(){
				$(".modify_tourAdd_left .modify_hover_me_pp .modify_type_pp #modify_cover_public").css("display", "block");
			},
			function() {
				$(".modify_tourAdd_left .modify_hover_me_pp .modify_type_pp #modify_cover_public").css("display", "none");
			}
		);
		
	} else if (class_name == "modify_private_ico") {
	 	$("#modify_publicImg").hover(
	 		function() {
				$(".modify_tourAdd_left .modify_hover_me_pp .modify_type_pp #modify_cover_private").css("display", "block");
	 		},
	 		function() {
	 			$(".modify_tourAdd_left .modify_hover_me_pp .modify_type_pp #modify_cover_private").css("display", "none");
	 		}
	 	);
	 	
	 	
	} else {
		alert("Error the public, private hover status!!");
	}
	
	
});
</script>

<!-- form 전송 -->
<script type="text/javascript">

$(document).ready(function() {
	var url = "${pageContext.servletContext.contextPath }/${ authUser.id}/tour/modify";

	$("#modify_imagePath").val(imagePath);
	/* document.getElementById("modify_fileForm").submit(); */
	
	$("#modify_add").click(function(){
		var formData = $("#modify_fileForm").serialize();
		$.ajax({
			type: "POST",
			url: url,
			data: formData,
		}).done(function(data) {
			
		});
	});
});

	

	
</script>


<!-- 대문 사진 가져오기 -->
<script type="text/javascript">
$(function() {

	$("div#tour_main_header").css("background-color", "transparent");
	$("div#header").css("background-color", "transparent");
	$("#tour_main_header_bg").css('background-image',"url(${pageContext.request.contextPath }"+"${tour.mainPhoto }");

});
</script>

<!-- EDIT 버튼 클릭 시 -->
<script type="text/javascript">
function editForm() {
	console.log("EDIT CLICKED!")
	$(".editForm").hide();
	$(".modify_addform").css("display", "block");
	/* $("#edit_title_area").css("autofocus", "autofocus"); */
	
};
</script>




<title>Breezer</title>
</head>
<body data-spy="scroll" data-target="#tour_navigation" data-offset="20">
	
	<!-- EDIT FORM -->
	<div id="tour_main_header_bg">
		<div id="tour_main_header">
		
			<form id="edit_fileForm" class="editForm" >
				
				<!-- 오른쪽 구간 -->
				<div class="edit_tourAdd_right">
					<input type="button" id="edit" value="EDIT" onclick="editForm()"><br><br><br>
				</div>
				
				<!-- 센터 구간 -->
				<div class="edit_tourAdd_center">
					<input type="text" id="edit_title_area" value="${tour.title }" name="title" readonly><br><br><br>
				
					<div class="edit_tourDate">
						<input type="text" id="edit_startDate" value="${tour.startDate }" name="startDate" readonly>
						<input type="text" id="edit_endDate" value="${tour.endDate }" name="endDate" readonly>
					</div>
				</div>
				
			</form>
			
			
			<!-- MODIFY FORM -->
			<form id="modify_fileForm" class="modify_addform" method="post" action="">	

				<!-- 왼쪽 구간 -->
				<div class="modify_tourAdd_left">
					
					<!-- 이미지 업로드 -->
					<div class="modify_hover_me_img">
						<input type="file" name="file" id="modify_fileUpload"><br><br>
						<img id="modify_newFile" src="/breezer/assets/images/tour/cover_pic_button.png" onClick="check()" >
						<div class="modify_hover_target_img">
							<input type="text" id="modify_cover_photo" value="Cover Photo" ><br><br>	
						</div>
					</div>
					
					<!-- 공개/비공개 부분 -->
					<div class="modify_hover_me_pp">
						<img id="modify_publicImg" class="modify_public_ico" src="/breezer/assets/images/tour/public_button.png" onclick="security()" ><br>
						<div class="modify_type_pp">
							<input type="text" id="modify_cover_public" value="public" >
						</div>
					</div>
					<br><br>
					<input id="modify_public" type="radio" name="secret" value="0" checked="checked" />  <br>					
					<input id="modify_private" type="radio" name="secret" value="1" />
				</div>
				
				<!-- 오른쪽 구간 -->
				<div class="modify_tourAdd_right">
					<input type="button" id="modify_add" value="SAVE"><br><br><br>
					<input type="button" id="modify_leave" value="LEAVE" onClick="location.href='/breezer'">		
				</div>
				
				<!-- 센터 구간 -->
				<div class="modify_tourAdd_center">
					<input type="text" id="modify_title_area" value="${tour.title }" name="title" ><br><br><br>
					<input type="text" id="modify_start-datepicker" value="${tour.startDate }" name="startDate">
					<input type="text" id="modify_end-datepicker" value="${tour.endDate }" name="endDate"><br><br>
					<input type="hidden"  id="idx_value" value="${tour.idx }" name="idx">
					<input type="hidden"  id="modify_imagePath" value="imagePath" name="mainPhoto">
					<%-- <input type="hidden"  id="modify_imagePath" value="${tour.mainPhoto }" name="mainPhoto"> --%>
				</div>
			</form>
		</div>
	</div>
	
	
	
	
	
			
	

</body>
</html>