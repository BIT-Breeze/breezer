<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Breezer</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  		<meta name="viewport" content="width=device-width, initial-scale=1">
  		
  		<!------------------------------------------------------------------------------------------------------------------->
  		<!---------------------------------------------------- CSS 시작 ----------------------------------------------------->
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main.css">
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  		<!---------------------------------------------------- CSS 끝 ------------------------------------------------------->
	  		<!------------------------------------------------------------------------------------------------------------------->
  		
  		<!------------------------------------------------------------------------------------------------------------------->
  		<!----------------------------------------------------- JS 시작 ----------------------------------------------------->  		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery.form.js" type="text/javascript"></script>
	  		<!---------------------------------------------------- JS 끝 ------------------------------------------------------->
	  		<!------------------------------------------------------------------------------------------------------------------>
		
		<!---------------------------------------------------------------------------->
		<!------------------------------ datePicker 시작 ----------------------------->
		<link href="${pageContext.servletContext.contextPath }/assets/datePicker/css/datepicker.min.css" rel="stylesheet" type="text/css">
        <script src="${pageContext.servletContext.contextPath }/assets/datePicker/js/datepicker.min.js"></script>
        <!-- Include English language -->
        <script src="${pageContext.servletContext.contextPath }/assets/datePicker/js/i18n/datepicker.en.js"></script>
	        <!------------------------------ datePicker 끝 ------------------------------->
			<!---------------------------------------------------------------------------->
        
		<script type="text/javascript">
		
		var datepicker;
		
		var clearDialog = function () {

			$("#input-location").val("");
			$("#input-lat").val("");
			$("#input-lot").val("");
			$("#input-locale").val("");
			$("#input-date").val("");
			$("#input-content").val("");
			$("#input-category").val("01");
			$("#input-price").val("");
			$("#input-score").val("");
			$("#imagePath").val("");
			$("#input-tourIdx").val("");
			$("#fileUpload").val("");
			$('#multiImgContainer').html('');
			
			var $star = $(".input-score"),
		    $result = $star.find("output>b");
			$result.text("0");
			var $checked = $star.find(":checked");
			$checked.prop('checked', false);
		}

		/* --------------------------------------------------------------------------- */
		/* ---------------------------- messageBox 시작 ------------------------------ */
		var messageBox = function (message, callback) {
			$("#dialog-message p").text(message);
			$("#dialog-message").dialog({
				modal: true,
				buttons: {
					"확인": function () {
						$(this).dialog("close");
					}
				},
				close: callback || function () {
					
				}
			}); 
		}
			/* ------------------------------------------------------------------------- */
			/* ---------------------------- messageBox 끝 ------------------------------ */

		/* --------------------------------------------------------------------------------------------- */
		/* ---------------------------- Post & Tour Navi 렌더링 함수 시작 ------------------------------ */
		var render = function (index, post) {
			var postHtml = "<div>", naviHtml;
			if(post.dateGap != 0){
				postHtml += "<li id='dateGap'>"+post.dateGap+"일차</li>";
				naviHtml = "<li><p>"+post.dateGap+"일차</p></li>";
			} else {
				postHtml = "";
				naviHtml = "";
			}
			postHtml += 
				"<li class='post' id='post-"+post.idx+"'>" +
					"<div class='transbox'>" +
						"<p><strong>장소:</strong> "+(post.placeName || "").replace("\n", "<br>")+"</p><br>"+
						"<p><strong>주소:</strong> "+(post.location || "").replace("\n", "<br>")+"</p><br>"+
						"<p><strong>일시:</strong> "+(post.tripDateTime || "").replace("\n", "<br>")+"</p><br>"+
						"<p><strong>내용:</strong> "+(post.content || "").replace("\n", "<br>")+"</p><br>"+
						"<p><strong>이동수단:</strong> "+(post.category || "").replace("\n", "<br>")+"</p><br>"+
						"<p><strong>지출비용:</strong> "+post.price+"</p><br>"+
						"<p><strong>평점:</strong> "+post.score+"</p><br>"+
						"<p><strong>추천수:</strong> "+post.favorite+"</p><br>"+
						"<c:if test='${userId eq authUser.id}'>"+
							"<a id='post-delete-"+post.idx+"' href='' data-no='"+post.idx+"'>삭제</a>"+
							"<a id='post-modify-"+post.idx+"' href='' data-no='"+post.idx+"'>수정</a>"+
						"</c:if>"+
					"</div>" +
				"</li></div>";
			if(index === 0){
				naviHtml +=
					"<li><a class='active' href='#post-"+post.idx+"'>"+post.placeName+"</a></li>";
			} else {
				naviHtml +=
					"<li><a href='#post-"+post.idx+"'>"+post.placeName+"</a></li>";
			}
			
			$("#PostBox").append(postHtml);
			$("#tour_navigation ul").append(naviHtml);
			
			
		}
			/* ---------------------------- Post & Tour Navi 렌더링 함수 끝 ------------------------------ */
			/* ------------------------------------------------------------------------------------------- */

		var fetchAllPost = function(){
			
			$("#PostBox").remove();
			$("#tour_navigation ul").remove();
			
			$("#PostList").append("<ul id='PostBox'></ul>");
			$("#tour_navigation").append("<ul></ul>");
			
			$.ajax({
				url: "${pageContext.servletContext.contextPath }/${userId}/api/tour?idx=${tourIdx}",
				type: "get",
				dataType: "json",
				data: "",
				success: function (response) {
					if(response.result != "success"){
						console.log(response);
						return;
					}
					
					$.each(response.data, function (index, vo) {
						render(index, vo);
					});
				}
			});
		}
		
		/* ----------------------------------------------------------------------------- */
		/* ----------------- 파일업로드 위한 변수 선언 & 포맷 제한 시작 ---------------- */
		var imagePath = ""; // 이미지 경로 저장 변수
		var file = $('[name="file"]');
		var sel_files = []; // 파일 저장되는 변수 [배열]
		var fileTypes = [
			  'image/jpeg',
			  'image/pjpeg',
			  'image/jpg',
			  'image/png'
		];
		
		function validFileType(file) {
			console.log(file.type);
			for(var i = 0; i < fileTypes.length; i++) {
				if(file.type === fileTypes[i]) {
					return true;
				}
			}
			return false;
		};
			/* ----------------- 파일업로드 위한 변수 선언 & 포맷 제한 끝 ---------------- */
			/* --------------------------------------------------------------------------- */
		
		var mapDialog;
		
		$(function () {

			/* ------------------------------------------------------------------ */
			/* ------------------------ star rating 시작 ------------------------ */
			var starRatingPost = function(){
				var $star = $(".input-score"),
					$result = $star.find("output>b");
				$(document)
					.on("focusin", ".input-score>.input", function(){
						$(this).addClass("focus");
					})
			        .on("focusout", ".input-score>.input", function(){
						var $this = $(this);
						setTimeout(function(){
							if($this.find(":focus").length === 0){
								$this.removeClass("focus");
							}
						}, 100);
					})
			        .on("change", ".input-score :radio", function(){
						$result.text($(this).next().text());
					})
			        .on("mouseover", ".input-score label", function(){
						$result.text($(this).text());
					})
			        .on("mouseleave", ".input-score>.input", function(){
						var $checked = $star.find(":checked");
						if($checked.length === 0){
							$result.text("0");
						} else {
							$result.text($checked.next().text());
						}
					});
			};
			starRatingPost();
				/* ------------------------ star rating 끝 ------------------------ */
				/* ---------------------------------------------------------------- */
		    
		    /* $("#PostList li a").click(function(event){
				event.preventDefault();

				var no = $(this).data("no");
				alert(no);
		    }); */
		    
		    /*---------------------------------------------------------------------*/
			/*------------------------- 삭제 event 시작 ---------------------------*/
			$(document).on("click", "[id^='post-delete-']", function (event) {
				event.preventDefault();
				
				var removeYN = confirm("정말 삭제하시겠습니까?");
				
				if(removeYN === true){
					var idx = $(this).data("no");

					$.ajax({
						url: "/breezer/${userId}/api/tour/remove/post",
						type: "post",
						dataType: "json",
						data: "idx="+idx+"&tourIdx=${tourIdx}",
						success: function (response) {
							if(response.result == "fail"){
								console.log(response.message);
								return;
							}
							
							if(response.data == -1){
								return;
							}
							
							fetchAllPost();
						},
						error: function (xhr, status, e) {
							console.error(status+":"+e);
						}
					});
				} else {
					return;
				}
			});
			    /*-------------------------------------------------------------------*/
				/*------------------------- 삭제 event 끝 ---------------------------*/

		    /* --------------------------------------------------------------------- */
		    /* ------------------ Post 클릭 시, opacity 이벤트 시작 ---------------- */
		    $('[id^="post-"]').click(function(){
		    	console.log('11');
		    	$(this).animate({opacity: 0.6}, 500);
		    });
			    /* ------------------ Post 클릭 시, opacity 이벤트 끝 ------------------ */
			    /* --------------------------------------------------------------------- */

			/* --------------------------------------------------------------------- */
			/* ------------------------ 장소 검색 모달 시작 ------------------------ */
			mapDialog = $("#searchMap-form").dialog({
				autoOpen: false,
				maxWidth:"100%",
				maxHeight:"100%",
				minWidth:1000,
				minHeight:800,
		        width: 1000,
		        height: 800,
				modal: true,
				buttons: {
				},
				close: function () {
				}
			});

			$(document).on("click", "#searchMap", function (event) {
				event.preventDefault();				
				mapDialog.dialog("open");
			});
				/* ------------------------ 장소 검색 모달 끝 ------------------------ */
				/* ------------------------------------------------------------------- */
		    
		    /*---------------------------------------------------------------------*/
			/*------------------------- 수정 event 시작 ---------------------------*/
			$(document).on("click", "[id^='post-modify-']", function (event) {
				event.preventDefault();	
				addModifyPostDialog.dialog("option", "title", "여행기 수정");
				$("#addDialogButton").hide();
				$("#modifyDialogButton").show();
				
				var idx = $(this).data("no");
				
				$.ajax({
					url: "/breezer/${userId}/api/post/select",
					type: "post",
					dataType: "json",
					data: "idx="+idx+"&tourIdx=${tourIdx}",
					success: function(response) {
						if(response.result != "success"){
							console.log(response);
							return;
						}
						
						var vo = response.data;
						$("#input-location").val(vo.location);
						$("#input-lat").val(vo.lat);
						$("#input-lot").val(vo.lot);
						
						var locale = vo.locale;
						if(locale === 'US'){
							$("#input-locale").val("미국");
						} else if(locale === 'KR'){
							$("#input-locale").val("대한민국");
						} else if(locale === 'JP'){
							$("#input-locale").val("일본");
						}
						
						var tripDateTimeArray = vo.tripDateTime.split(" ");
						var YMD = tripDateTimeArray[0];
						var HMS = tripDateTimeArray[1];
						var YMDArray = YMD.split("-");
						var HMSArray = HMS.split(":");
						
						var start = new Date();
						start.setYear(YMDArray[0]);
						start.setMonth(YMDArray[1]);
						start.setDate(YMDArray[2]);
						start.setHours(HMSArray[0]);
						start.setMinutes(HMSArray[1]);
						
						$("#input-date").val(tripDateTimeArray[0]+" "+(HMSArray[0]>12 ? HMSArray[0]-12 : HMSArray[0])
									+":"+HMSArray[1]+" "+(HMSArray[0]>11 ? "pm" : "am"));
						
						$("#input-content").val(vo.content);
						$("#input-category").val(vo.category);
						$("#input-price").val(vo.price);
						
						var $star = $(".input-score"),
					    $result = $star.find("output>b");
						$result.text(vo.score);
						
						$("input:radio[name='score'][value='"+vo.score+"']").prop("checked", true);
						
						$("#input-tourIdx").val("${tourIdx}");
						$("#imagePath").val("");
						$("#fileUpload").val("");
						$('#multiImgContainer').html('');
					},
					error: function (xhr, status, e) {
						console.error(status+":"+e);
					}
				});
				
				addModifyPostDialog.dialog("open");
			});
			    /*-------------------------------------------------------------------*/
				/*------------------------- 수정 event 끝 ---------------------------*/
			
			/* --------------------------------------------------------------------- */
			/* ------------------------ Post 추가 모달 시작 ------------------------ */
			var addModifyPostDialog = $("#addModify-post-form").dialog({
				autoOpen: false,
				maxWidth:600,
				maxHeight:800,
				minWidth:600,
				minHeight:600,
		        width: 600,
		        height: 600,
				modal: true,
				buttons: [
					{ text: "수정",
					  id: "modifyDialogButton",
					  click: function() {
						  
						if($("#input-location").val() === ''){
							messageBox(
									"장소를 선택해주세요.",
									function () {
										$("#searchMap").focus();
									});
							return;
						}
						if($("#input-date").val() === ''){
							messageBox(
									"날짜/시간을 선택해주세요.",
									function () {
										$("#input-date").focus();
									});
							return;
						}
						if($("#input-content").val() === ''){
							messageBox(
									"내용을 입력해주세요.",
									function () {
										$("#input-content").focus();
									});
							return;
						}
						
						if($("#input-price").val() === ''){
							$("#input-price").val(0);
						}
						if($("#input-score").val() === ''){
							$("#input-score").val(0);
						}
						if($("#fileUpload").val() === ''){
							$("#fileUpload").val('');
						}
						
						var id = '${userId}';
						var tourIdx = '${tourIdx}';
						
						console.log("수정>"+id+":"+tourIdx);
						
						$("#imagePath").val(imagePath);
						$("#input-tourIdx").val(tourIdx);
						var modifyPostForm = $("#addModifyPostForm").serialize();
						
						$.ajax({
							url: "/breezer/${userId}/api/post/modify",
							type: "post",
							dataType: "json",
							data: modifyPostForm,
							success: function(response) {
								if(response.result != "success"){
									console.log(response);
									return;
								}

								clearDialog();
								
								fetchAllPost();
								
								addModifyPostDialog.dialog("close");
							},
							error: function (xhr, status, e) {
								console.error(status+":"+e);
							}
						});
					  }
					},
					{ text: "추가",
					  id: "addDialogButton",
					  click: function() {
						  
						if($("#input-location").val() === ''){
							messageBox(
									"장소를 선택해주세요.",
									function () {
										$("#searchMap").focus();
									});
							return;
						}
						if($("#input-date").val() === ''){
							messageBox(
									"날짜/시간을 선택해주세요.",
									function () {
										$("#input-date").focus();
									});
							return;
						}
						if($("#input-content").val() === ''){
							messageBox(
									"내용을 입력해주세요.",
									function () {
										$("#input-content").focus();
									});
							return;
						}
						
						if($("#input-price").val() === ''){
							$("#input-price").val(0);
						}
						if($("#input-score").val() === ''){
							$("#input-score").val(0);
						}
						if($("#fileUpload").val() === ''){
							$("#fileUpload").val('');
						}
						
						var id = '${userId}';
						var tourIdx = '${tourIdx}';
						
						console.log("추가>"+id+":"+tourIdx);
						
						$("#imagePath").val(imagePath);
						$("#input-tourIdx").val(tourIdx);
						var addPostForm = $("#addModifyPostForm").serialize();
						
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
								
								clearDialog();
								
								fetchAllPost();
								
								addModifyPostDialog.dialog("close");
							},
							error: function (xhr, status, e) {
								console.error(status+":"+e);
							}
						});
					  }
					},
					{ text: "취소",
					  id: "cancelDialogButton",
					  click: function () {
						clearDialog();
						$(this).dialog("close");
					  }
					}
				],
				close: function () {
					clearDialog();
				}
			});
		    
			$(document).on("click", "#addPostButton", function (event) {
				event.preventDefault();		
				addModifyPostDialog.dialog("option", "title", "여행기 추가");
				$("#addDialogButton").show();
				$("#modifyDialogButton").hide();
				addModifyPostDialog.dialog("open");
			});
				/* ------------------------ Post 추가 모달 끝 ------------------------ */
				/* ------------------------------------------------------------------- */
			
			/* ------------------------------------------------------------------------------------- */
			/* ------------------------ Scroll 반응 Side Navigation #1 시작 ------------------------ */
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
				/* ------------------------ Scroll 반응 Side Navigation #1 끝 ------------------------- */
				/* ------------------------------------------------------------------------------------ */
			
			$('#fileUpload').on('change', ImgFileSelect);
			
			fetchAllPost();
		});

		/* ----------------------------------------------------------------- */
		/* ------------------------ 파일업로드 시작 ------------------------ */
		function ImgFileSelect(e) {
			console.log("====== ImgFileSelect ======");
			var files = e.target.files; // 넘어 오는 파일들을 files에 담고
			var filesArr = Array.prototype.slice.call(files); // 제목을 분할하여 filesArr에 저장
			
			var index = 0; // 순서를 위해 index를 선언
			var isValidFileType = true;
			filesArr.forEach(function(f) { // 반복문으로
				if(validFileType(f)){
					index++; // 인덱스를 한순차씩 올려주며
					sel_files.push(f); // 배열로 선언했던 파일저장변수에 하나씩 push
					console.log(f); // 로그 출력
				} else {
					isValidFileType = false;
					return;
				};
			});
			if(isValidFileType === false){
				alert("올바른 파일('.jpg', '.jpeg', '.pjpeg', '.png')을 선택해주세요.");
				$('#multiImgContainer').html('');
				$("#fileUpload").val("");
				return;
			}
			
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
			/* ------------------------ 파일업로드 끝 ------------------------ */
			/* --------------------------------------------------------------- */
		
		/* ------------------------------------------------------------------------------------- */
		/* ------------------------ Scroll 반응 Side Navigation #2 시작 ------------------------ */
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
			/* ------------------------ Scroll 반응 Side Navigation #2 끝 -------------------------- */
			/* ------------------------------------------------------------------------------------- */

		/* --------------------------------------------------------------------- */
		/* ---------------------------- map 시작 ------------------------------- */
		function initAutocomplete() {
			var map = new google.maps.Map(document.getElementById('map'), {
				center: {lat: -33.8688, lng: 151.2195},
				zoom: 13,
				mapTypeId: 'roadmap'
			});
			
			google.maps.event.trigger(map, 'resize');
			
			var infoWindow2 = new google.maps.InfoWindow({map: map});
			// Try HTML5 geolocation.
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(position) {
				var pos = {
					lat: position.coords.latitude,
					lng: position.coords.longitude
				};
				
				infoWindow2.setPosition(pos);
				infoWindow2.setContent('Here!!!');
				
				map.setCenter(pos);
				}, function() {
					handleLocationError(true, infoWindow2, map.getCenter());
				});
			} else {
				// Browser doesn't support Geolocation
				handleLocationError(false, infoWindow2, map.getCenter());
			}

	      // Create the search box and link it to the UI element.
	      var input = document.getElementById('pac-input');
	      var searchBox = new google.maps.places.SearchBox(input);
	      map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	      
	      // Bias the SearchBox results towards current map's viewport.
	      map.addListener('bounds_changed', function() {
	      	searchBox.setBounds(map.getBounds());	
	      });

	      var searchMarkers = [];
	      // Listen for the event fired when the user selects a prediction and retrieve more details for that place.
	      searchBox.addListener('places_changed', function() {
		        var places = searchBox.getPlaces();
		        
		        console.log(places);
		        
		        if (places.length == 0) {
		          return;
		        } 
		        
		        var search_place = [];	        
		        for (var i = 0; i < places.length; i++) {
		        	search_place.push(places[i].formatted_address);
				}
		
		        // Clear out the old markers.
		        searchMarkers.forEach(function(marker) {
		        	marker.setMap(null);
		        });
		        searchMarkers = [];

		        var infowindow = new google.maps.InfoWindow();
		        
		        // For each place, get the icon, name and location.
		        var bounds = new google.maps.LatLngBounds();
		        
		        // forEach callBack함수 파라미터(value, index, array)
				places.forEach(function(place, index, array) {
					if (!place.geometry) {
						console.log("Returned place contains no geometry");
						return;
					}
					var icon = {
						url: place.icon,
						size: new google.maps.Size(71, 71),
						origin: new google.maps.Point(0, 0),
						anchor: new google.maps.Point(17, 34),
						scaledSize: new google.maps.Size(25, 25)
					};
		
					// Create a marker for each place.
					searchMarkers.push(new google.maps.Marker({
						map: map,
						icon: icon,
						title: place.name,
						position: place.geometry.location,
						formatted_address: place.formatted_address
					}));
					
					// 마커 검색 장소 정보
					searchMarkers[index].addListener('click', function() {
						var title = searchMarkers[index].title,
							formatted_address = searchMarkers[index].formatted_address,
							fa_array = formatted_address.split(" "),
							lat = searchMarkers[index].position.lat(),
							lot = searchMarkers[index].position.lng(),
							locale;
						$('#input-location').val(title+':'+formatted_address);
						$('#input-lat').val(lat);
						$('#input-lot').val(lot);
						if(fa_array[0] === '대한민국' || fa_array[fa_array.length-1] === '대한민국'){
							$('#input-locale').val('대한민국');
							locale = '대한민국';
						} else if(fa_array[0] === '일본' || fa_array[fa_array.length-1] === '일본'){
							$('#input-locale').val('일본');
							locale = '일본';
						} else if(fa_array[0] === '미국' || fa_array[fa_array.length-1] === '미국'){
							$('#input-locale').val('미국');
							locale = '미국';
						}
						
						console.log('location> '+title+":"+formatted_address);
						console.log('lat> '+lat);
						console.log('lot> '+lot);
						console.log('locale> '+locale);
						
						mapDialog.dialog("close");
						return;
						infowindow.setContent(place.name);
						infowindow.open(map, searchMarkers[index]);
						
						// 클릭 시 확대
						map.setZoom(15);
						map.setCenter(searchMarkers[index].getPosition());
						
					});
		
					if (place.geometry.viewport) {
						// Only geocodes have viewport.
						bounds.union(place.geometry.viewport);
					} else {
						bounds.extend(place.geometry.location);
					}
				});
				
				map.fitBounds(bounds);
			});
		}
		
		function handleLocationError(browserHasGeolocation, infoWindow, pos) {
			infoWindow.setPosition(pos);
			infoWindow.setContent(browserHasGeolocation ?
			                      'Error: The Geolocation service failed.' :
			                      'Error: Your browser doesn\'t support geolocation.');
		}
			/* ---------------------------- map 끝 ------------------------------- */
			/* --------------------------------------------------------------------- */
		
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
				<c:if test="${userId eq authUser.id}">
					<div id="addPost">
						<a id="addPostButton" style="float: right;">여행기 추가</a>
					</div>
				</c:if>
				<div id="PostList">
					<ul id="PostBox">
					<%-- <c:forEach var="post" items="${postList }">
						<c:if test="${post.dateGap != 0}">
						<li id="dateGap">${post.dateGap}일차</li>
						</c:if>
						<li class="post" id="post-${post.idx}">
							<strong>장소:</strong><p>${post.placeName }</p><br>
							<strong>주소:</strong><p>${post.location }</p><br>
							<strong>일시:</strong><p>${post.tripDateTime }</p><br>
							<strong>내용:</strong><p>${post.content }</p><br>
							<strong>이동수단:</strong><p>${post.category }</p><br>
							<strong>지출비용:</strong><p>${post.price }</p><br>
							<strong>평점:</strong><p>${post.score }</p><br>
							<strong>추천수:</strong><p>${post.favorite }</p><br>
							<a href="" data-no="${post.idx}">삭제</a>
						</li>
					</c:forEach> --%>
					</ul>
				</div>
				
				<!-------------------------------------------------------------------------------------------->
				<!-------------------------------- 여행기 추가&수정 양식 시작 -------------------------------->
				<div id="addModify-post-form" title="" style="display:none">
	  				<form id="addModifyPostForm" method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/post/add">
						<div>
							<table>
								<tr>
									<td>장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
									<td><input id="input-location" type="text" value="" name="location"></td>
									<td><input id="input-lat" type="text" value="" name="lat" style="display: none;"></td>
									<td><input id="input-lot" type="text" value="" name="lot" style="display: none;"></td>
									<td><input id="input-locale" type="text" value="" name="locale" style="display: none;"></td>
									<td><button id="searchMap">검색</button></td>
								</tr>
								<tr>
									<td>날짜/시간</td><td><input id="input-date" type="text" name="tripDateTime" class="datepicker-here" >
									<script>
										var prevDay;
										
										datepicker = $('#input-date').datepicker({
									    	autoClose: true,
									        timepicker: true,
									        language: 'en',
										   	dateFormat: 'yyyy-mm-dd',
										   	/* timeFormat: 'hh:ii', */
										   	todayButton: true,
										   	clearButton: true,
									        onSelect: function (fd, d, picker) {
									            // Do nothing if selection was cleared
									            if (!d) return;
									
									            var day = d.getDay();
									
									            // Trigger only if date is changed
									            if (prevDay != undefined && prevDay == day) return;
									            prevDay = day;
									        }
									    });
									</script></td>
								</tr>
								<tr>
									<td>내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</td><td><input id="input-content" type="text" value="" name="content"></td>
								</tr>
								<tr>
									<td>이동수단</td><td><select id="input-category" name="category" style="width: 158px;">
															<option value="01" selected>자동차</option>
															<option value="02">택시</option>
															<option value="03">기차</option>
															<option value="04">트램</option>
															<option value="05">버스</option>
															<option value="06">지하철</option>
															<option value="07">비행기</option>
															<option value="08">배</option>
															<option value="09">도보</option>
															<option value="10">자전거</option>
															<option value="11">오토바이</option>
															<option value="12">기타</option>
														</select></td>
								</tr>
								<tr>
									<td>지출비용</td><td><input id="input-price" type="text" value="" name="price"></td>
								</tr>
								<tr>
									<td>점&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수</td><td>	<span id="input-score" class="input-score">
																											<span class="input">
																												<input type="radio" name="score" id="p1" value="0.5"><label for="p1">0.5</label>
																												<input type="radio" name="score" id="p2" value="1"><label for="p2">1</label>
																												<input type="radio" name="score" id="p3" value="1.5"><label for="p3">1.5</label>
																												<input type="radio" name="score" id="p4" value="2"><label for="p4">2</label>
																												<input type="radio" name="score" id="p5" value="2.5"><label for="p5">2.5</label>
																												<input type="radio" name="score" id="p6" value="3"><label for="p6">3</label>
																												<input type="radio" name="score" id="p7" value="3.5"><label for="p7">3.5</label>
																												<input type="radio" name="score" id="p8" value="4"><label for="p8">4</label>
																												<input type="radio" name="score" id="p9" value="4.5"><label for="p9">4.5</label>
																												<input type="radio" name="score" id="p10" value="5"><label for="p10">5</label>
																											</span>
																											<output for="input-score"><b>0</b>점</output>
																										</span></td>
								</tr>
							</table>
							<input id="imagePath" type="hidden" name="photo" value="imagePath" ><br>
							<input id="input-tourIdx" type="hidden" name="tourIdx" value="">
						</div>
					</form>
					
					<!-- 다중 파일 업로더 -->
					<form id="MultifileForm">
						<div>
							<table>
								<tr>
									<td>사진</td>
								</tr>
								<tr>
									<td><input type="file" multiple="multiple" name="multiFile" id="fileUpload" accept="image/*"></td>
								</tr>
							</table>
							<div id=multiImgContainer></div>
						</div>
					</form>
					
				</div>
				<!----------------------------------------------------------------------------------------->
				<!-------------------------------- 여행기 추가&수정 양식 끝-------------------------------->
			
				<div id="dialog-message" title="" style="display:none">
	  				<p></p>
				</div>
			</div>
			
			<!-- Map Test -->
			<div id="searchMap-form" title="여행지 검색" style="display:none">
				<input id="pac-input" class="controls" type="text" placeholder="Search Box">
				
				<div id="map"></div>
				
				<!-- 구글 맵 호출 -->
				<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAzThJYOAvyAEWJryfDhAtIN2MkjVk58Gg&libraries=places&callback=initAutocomplete" async defer></script>
				<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBCOZIjbRpUmHxNptiJHd5G8JRoVf_3XY&libraries=places&callback=initAutocomplete" async defer></script> -->
				
				<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>

</body>
</html>







