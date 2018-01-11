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
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_add.css">
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
		
		function addPost(){
			window.open('${pageContext.servletContext.contextPath}/${userId}/post/add?touridx=${tourIdx}', 'window', 'width=1100, height=900,scroll=yes');
		}
		
		</script>

<!-- 달력 js -->
<script type="text/javascript">
$(function() {
	$("#start-datepicker").datepicker({
		showOn: "both", 
        buttonImage: "/breezer/assets/images/tour/calendar_button.png", 
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

$(function() {
	$("#end-datepicker").datepicker({
		showOn: "both", 
        buttonImage: "/breezer/assets/images/tour/calendar_button.png",
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

<!-- 파일 업로더 onchange -->
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
	var imgContainer = $('#imgContainer');

	$('#fileUpload').on('change', function() {
		
		console.log("response from btnUpload Button")
		
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
			imgContainer.html('');
			
			var img = '<img id="imgCon" src="${pageContext.request.contextPath }'+data+'" width="auto" height="auto"/>';
			
			imagePath = data;
			console.log(data);
			console.log(img);
 			imgContainer.append(img);
 			
 			//var backgroundImage = "${pageContext.request.contextPath }" + data;
 			//console.log(backgroundImage);
 			//document.getElementById("tour_main_header_bg").style.backgroundImage="url('"+backgroundImage+"')";
 			
		}).fail(function(jqXHRm, textStatus) {
			alert('File upload failed ... >> ' + jqXHRm + ', ' + textStatus);
			
		});
	});
});

/* controller 로 submit 하는 부분 */
var add = function() {
	$("#imagePath").val(imagePath);
	document.getElementById("addform").submit();
}


</script>

<script type="text/javascript">

function check() {
	eventOccur(document.getElementById('fileUpload'),'click');
}

function eventOccur(evEle, evType){
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

<title>Breezer</title>
</head>
<body data-spy="scroll" data-target="#tour_navigation" data-offset="20">
	
	<div id="container"></div>
	
		<div id="tour_main_header_bg">
			
			<div id=imgContainer></div>
			<c:import url="/WEB-INF/views/includes/header.jsp" />
			<%-- <c:import url="/WEB-INF/views/tour/tour_main_header.jsp" /> --%>
			
			<div id="tour_main_header"> <!-- main_header css 부분 대체 추가 -->
			<!-- TOUR_ADD 작업 부분 -->
						
			<!-- 파일업로더 -->
				<form id="fileForm">
					<a href="/breezer">Cancel</a><br>
					<input type="file" name="file" id="fileUpload"><br><br>
					<img id="newFile" src="/breezer/assets/images/tour/imgupload.png" onclick="check()" >
				</form>
				
			 	<form id="addform" method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/tour/add">
				
					<input type="text" value="title" name="title"><br>
					<input type="text" id="start-datepicker" value="start date" name="startDate"> ~
					<input type="text" id="end-datepicker" value="end date" name="endDate"><br><br>
					<input type="hidden"  id="imagePath" value="imagePath" name="mainPhoto">
					<input type="radio" name="secret" value="0" checked="checked" /> public
					<input type="radio" name="secret" value="1" /> private
					
					<input type="button" value="add" onclick="add()">
			
				</form>
				
				<!-- MODAL TEST -->
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
				  Modal Test
				</button>

			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
		
		<!-- POST VIEW 부분 -->
		<div id="wrapper">
			<c:import url="/WEB-INF/views/tour/tour_navigation.jsp" />
			<div id="content">
				<div class="row">
					<a style="float: right;" href="javascript:addPost()">여행기 추가</a>
				</div>
				<c:forEach var="post" items="${postList }">
					<c:if test="${post.dateGap != 0}">
						<div>${post.dateGap}일차</div>
					</c:if>
					<div class="post" id="post-${post.idx}">
						<dl>
							<dd>${post.tripDateTime }</dd>
							<dd>${post.content }</dd>
							<dd>${post.location }</dd>
							<dd>${post.locale }</dd>
							<dd>${post.lat }</dd>
							<dd>${post.lot }</dd>
							<dd>${post.category }</dd>
							<dd>${post.price }</dd>
							<dd>${post.score }</dd>
							<dd>${post.hit }</dd>
						</dl>
					</div>
				</c:forEach>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />

</body>
</html>

	