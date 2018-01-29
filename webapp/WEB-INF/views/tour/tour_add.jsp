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
 
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css">
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main.css"> --%>
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_add.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery.form.js" type="text/javascript"></script>

<link href="${pageContext.servletContext.contextPath }/assets/datePicker/css/datepicker.min.css" rel="stylesheet" type="text/css">
<script src="${pageContext.servletContext.contextPath }/assets/datePicker/js/datepicker.min.js"></script>
<script src="${pageContext.servletContext.contextPath }/assets/datePicker/js/i18n/datepicker.en.js"></script>
        
<!-- <script src="/breezer/assets/js/jquery/jquery-ui.js" type="text/javascript"></script> -->

<script src="/breezer/assets/js/bootstrap.js" type="text/javascript"></script>
<script src="/breezer/assets/js/bootstrap.min.js" type="text/javascript"></script>

<script type="text/javascript">
		
		$(document).ready(function () {
		    $(document).on("scroll", onScroll);
		    
		    //smoothscroll
		    $('a[href^="#"]').on('click', function (e) {
		        e.preventDefault();
		        $(document).off("scroll");
		        
		        $('a').each(function () {
		            $(this).removeClass('active');
		        })
		        $(this).addClass('active');
		      
		        var target = this.hash,
		            menu = target;
		        $target = $(target);
		        $('html, body').stop().animate({
		            'scrollTop': $target.offset().top+2
		        }, 500, 'swing', function () {
		            window.location.hash = target;
		            $(document).on("scroll", onScroll);
		        });
		    });
		});

		function onScroll(event){
		    var scrollPos = $(document).scrollTop();
		    $('#tour_navigation a').each(function () {
		        var currLink = $(this);
		        var refElement = $(currLink.attr("href"));
		        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
		            $('#tour_navigation ul li a').removeClass("active");
		            currLink.addClass("active");
		        }
		        else{
		            currLink.removeClass("active");
		        }
		    });
		}
		
		$(window).scroll(function () {
			var $window = $(this);
			var scrollTop = $(window).scrollTop();
			var elementOffset = $("#tour_navigation").offset().top;
			var currentElementOffset = (elementOffset - scrollTop);
			if(currentElementOffset > 0 && scrollTop < 360){
				$("#tour_navigation").css('margin', '-' + scrollTop + 'px 0px 0px 0px');
			}
		});
		
		function addPost() {
			window.open('${pageContext.servletContext.contextPath}/${userId}/post/add?touridx=${tourIdx}', 'window', 'width=1100, height=900,scroll=yes');
		}
		
		</script>

<!-- 달력 js -->
<script type="text/javascript">
$(function() {
	$("#start-datepicker, #end-datepicker").datepicker({
		autoClose: true,
	   	todayButton: true,
	   	clearButton: true,
        language: 'en',
		showOn: "both", 
        buttonImage: "/breezer/assets/images/tour/calendar_button.jpg", 
        buttonImageOnly: true,
        changeMonth: true,
        changeYear: true,
        nextText: '다음 달',
        prevText: '이전 달',
        showButtonPanel: true,
        closeText: '닫기',
        dateFormat: "yyyy-mm-dd"
 
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

	$('#fileUpload').on('change', function() {

		var filename = $.trim(file.val());
		
		if(!(isJpg(filename) || isPng(filename))) {
			alert('Please browse a JPG/PNG file to upload...');
			return;
		}
		
		var formData = new FormData($('#fileForm')[0]);
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
	uploadEventOccur(document.getElementById('fileUpload'),'click');
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
		$("#publicImg").attr("class", "public_ico");
		$("#cover_public").attr("value", "public");
		$("#publicImg").attr("src", "/breezer/assets/images/tour/public_button.png");
		$("#public").attr("checked", "checked");
		$("#private").removeAttr("checked");
		changeCode = 0;
		
	} else if (changeCode == 0) {
		console.log("비공개 상태 - changeCode:" + changeCode);
		$("#publicImg").attr("class", "private_ico");
		$("#cover_public").attr("value", "private");
		$("#publicImg").attr("src", "/breezer/assets/images/tour/private_button.png");
		$("#private").attr("checked", "checked");
		$("#public").removeAttr("checked");
		changeCode = 1;
		
	} else {
		alert("Error the public, private status!!");
	}

}

</script>

<!-- public, private hover -->
<script type="text/javascript">
$(function() {
	var class_name = $("#publicImg").attr("class"); 

	if (class_name == "public_ico") {
		$("#publicImg").hover(
			function(){
				$(".tourAdd_left .hover_me_pp .type_pp #cover_public").css("display", "block");
			},
			function() {
				$(".tourAdd_left .hover_me_pp .type_pp #cover_public").css("display", "none");
			}
		);
		
	} else if (class_name == "private_ico") {
	 	$("#publicImg").hover(
	 		function() {
				$(".tourAdd_left .hover_me_pp .type_pp #cover_private").css("display", "block");
	 		},
	 		function() {
	 			$(".tourAdd_left .hover_me_pp .type_pp #cover_private").css("display", "none");
	 		}
	 	);
	 	
	 	
	} else {
		alert("Error the public, private hover status!!");
	}
	
	
});
</script>

<!-- form 전송 -->
<script type="text/javascript">
function submitForm() {
	$("#imagePath").val(imagePath); /* imagePath 값을 얻어와서 DB에 같이 */
	document.getElementById("fileForm").submit();
}
	
</script>

<title>Breezer</title>
</head>
<body data-spy="scroll" data-target="#tour_navigation" data-offset="20">
	
	<div id="tour_main_header_bg">
		
		<div id="tour_main_header">
			<c:import url="/WEB-INF/views/includes/header.jsp" /> <!-- header -->
			
			<br><br>
				
			<form id="fileForm" class="addform" method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/tour/add">	

				<!-- 왼쪽 구간 -->
				<div class="tourAdd_left">
					
					<!-- 이미지 업로드 -->
					<div class="hover_me_img">
						<input type="file" name="file" id="fileUpload"><br><br>
						<img id="newFile" src="/breezer/assets/images/tour/cover_pic_button.png" onClick="check()" >
						<div class="hover_target_img">
							<input type="text" id="cover_photo" value="Cover Photo" ><br><br>	
						</div>
					</div>
					
					
					<!-- 공개/비공개 부분 -->
					<div class="hover_me_pp">
						<img id="publicImg" class="public_ico" src="/breezer/assets/images/tour/public_button.png" onclick="security()" ><br>
						<div class="type_pp">
							<input type="text" id="cover_public" value="public" >
						</div>
					</div>
					<br><br>
					<input id="public" type="radio" name="secret" value="0" checked="checked" />  <br>					
					<input id="private" type="radio" name="secret" value="1" />
				</div>
				
				<!-- 오른쪽 구간 -->
				<div class="tourAdd_right">
					<input type="button" id="add" value="SAVE" onClick="submitForm()"><br><br><br>
					<input type="button" id="leave" value="LEAVE" onClick="location.href='/breezer'">		
				</div>
				
				<!-- 센터 구간 -->
				<div class="tourAdd_center">
					<input type="text" id="title_area" placeholder="Enter Title" name="title"><br><br><br>
					<input type="text" id="start-datepicker" placeholder="Start Date" name="startDate">
					<input type="text" id="wave" value="~" readonly>
					<input type="text" id="end-datepicker" placeholder="End Date" name="endDate"><br><br>
					<input type="hidden"  id="imagePath" value="imagePath" name="mainPhoto">
				</div>
				
			</form>
			
			
		</div>
	</div>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp" />

</body>
</html>
