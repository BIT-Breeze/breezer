<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC  '-//W3C//DTD HTML 4.01//EN' 'http://www.w3.org/TR/html4/strict.dtd'>
<html>
	<head>
		<title>Breezer</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">
  		
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main.css">
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<script type="text/javascript">
		
		var imagePath = ""; // 이미지 경로 저장 변수
		var file = $('[name="file"]');
		var sel_files = []; // 파일 저장되는 변수 [배열]
		
		$(function () {
			
			var addPostDialog = $("#add-post-form").dialog({
				autoOpen: false,
				modal: true,
				buttons: {
					"추가": function() {
						var id = '${userId}';
						var tourIdx = '${tourIdx}';
						
						console.log("추가>"+id+":"+tourIdx);
						
						$("#imagePath").val(imagePath);
						var addPostForm = $("#addPostForm").serialize();
						
						$.ajax({
							url: "/breezer/${userId}/api/post/add",
							type: "post",
							dataType: "json",
							data: addPostForm,
							success: function(response) {
								if(response.result != "success"){
									console.log(response);
									return;
								}

								$("#input-location").val("");
								$("#input-category").val("");
								$("#input-price").val("");
								$("#input-score").val("");
								$("#input-content").val("");
								$("#imagePath").val("");
								$("#input-tourIdx").val("");
								$('#multiImgContainer').html('');
								
								addPostDialog.dialog("close");
							},
							error: function (xhr, status, e) {
								console.error(status+":"+e);
							}
						});
					},
					"취소": function () {
						
						$("#input-location").val("");
						$("#input-category").val("");
						$("#input-price").val("");
						$("#input-score").val("");
						$("#input-content").val("");
						$("#imagePath").val("");
						$("#input-tourIdx").val("");
						$('#multiImgContainer').html('');
						
						$(this).dialog("close");
					}
				},
				close: function () {
					
					$("#input-location").val("");
					$("#input-category").val("");
					$("#input-price").val("");
					$("#input-score").val("");
					$("#input-content").val("");
					$("#imagePath").val("");
					$("#input-tourIdx").val("");
					$('#multiImgContainer').html('');
				}
			});
			
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
		    
		    $('#modifyTour').click(function(){
				$('.toModify').hide();
				$('.modified').show();
			});
		    
		    $('#completeModifyTour').click(function(){
				$('.modified').hide();
				$('.toModify').show();
			});
		    
			$(document).on("click", "#addPostButton", function (event) {
				event.preventDefault();				
				addPostDialog.dialog("open");
			});
			
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
		
		/* var add = function() {
			$("#imagePath").val(imagePath);
			document.getElementById("addPostForm").submit();
		} */

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
		
		/* function addPost(){
			var url = '${pageContext.servletContext.contextPath}/${userId}/post/add?tourIdx=${tourIdx}';
			var name = 'addPost';
			var option = 'width=1100, height=900, scroll=yes, resizable=yes, ';
			window.open(url, name, option);
		} */
		
		</script>
</head>
	
<body data-spy="scroll" data-target="#tour_navigation" data-offset="20">

	<div id="container">
		<div id="tour_main_header_bg">
			<c:import url="/WEB-INF/views/includes/header.jsp" />
			<c:import url="/WEB-INF/views/tour/tour_main_header.jsp" />
		</div>
		<div id="wrapper">
			<c:import url="/WEB-INF/views/tour/tour_navigation.jsp" />
			<div id="content">
				<div id="addPost">
					<a id="addPostButton" style="float: right;">여행기 추가</a>
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
							<dd>${post.favorite }</dd>
						</dl>
					</div>
				</c:forEach>
				
				<div id="add-post-form" title="여행기 추가" style="display:none">
	  				<form id="addPostForm" method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/post/add">
						<div>
							location <input id="input-location" type="text" value="location" name="location"><br>
							category <input id="input-category" type="text" value="0" name="category"><br>
							price <input id="input-price" type="text" value="0" name="price"><br>
							score <input id="input-score" type="text" value="0" name="score"><br>
							content <input id="input-content" type="text" value="content" name="content"><br>
							<input type="hidden" id="imagePath" value="imagePath" name="photo"><br>
							<input id="input-tourIdx" type="hidden" name="tourIdx" value=${tourIdx }>
					
							<div id=multiImgContainer></div>
							
							<!-- Map Modal 띄우기 -->
							<!-- <input type="button" value="map" onclick=""><br><br> -->
							
							<!-- MODAL TEST -->
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
							  Modal 띄우기(MAP)
							</button>
						</div>
					</form>
					
					<!-- 다중 파일 업로더 -->
					<form id="MultifileForm">
						<input type="file" multiple="multiple" name="multiFile" id="fileUpload"><br><br>
					</form>
				</div>
				
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>

</body>
</html>







