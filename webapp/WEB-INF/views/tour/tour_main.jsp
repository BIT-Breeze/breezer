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
  		
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath }/assets/css/tour/tour_main.css">
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script src="/breezer/assets/js/jquery/jquery-1.9.0.js"></script>
		<script src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-ui.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-ui.min.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery.form.js" type="text/javascript"></script>
		
		<!------------------------------ datePicker ------------------------------>
		<link href="${pageContext.servletContext.contextPath }/assets/datePicker/css/datepicker.min.css" rel="stylesheet" type="text/css">
        <script src="${pageContext.servletContext.contextPath }/assets/datePicker/js/datepicker.min.js"></script>
        <!-- Include English language -->
        <script src="${pageContext.servletContext.contextPath }/assets/datePicker/js/i18n/datepicker.en.js"></script>
        <!------------------------------------------------------------------------>
        
		<script type="text/javascript">
		
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
		
		var mapDialog;
		
		$(function () {

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
			
			var addPostDialog = $("#add-post-form").dialog({
				autoOpen: false,
				maxWidth:600,
				maxHeight:800,
				minWidth:600,
				minHeight:600,
		        width: 600,
		        height: 600,
				modal: true,
				buttons: {
					"추가": function() {
						var id = '${userId}';
						var tourIdx = '${tourIdx}';
						
						console.log("추가>"+id+":"+tourIdx);
						
						$("#imagePath").val(imagePath);
						$("#input-tourIdx").val(tourIdx);
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
								
								$("#input-date").val("");
								$("#input-location").val("");
								$("#input-category").val("");
								$("#input-price").val("");
								$("#input-score").val("");
								$("#input-content").val("");
								$("#imagePath").val("");
								$("#input-tourIdx").val("");
								$('#multiImgContainer').html('');
								$("#fileUpload").val("");
								
								addPostDialog.dialog("close");
							},
							error: function (xhr, status, e) {
								console.error(status+":"+e);
							}
						});
					},
					"취소": function () {

						$("#input-date").val("");
						$("#input-location").val("");
						$("#input-category").val("");
						$("#input-price").val("");
						$("#input-score").val("");
						$("#input-content").val("");
						$("#imagePath").val("");
						$("#input-tourIdx").val("");
						$('#multiImgContainer').html('');
						$("#fileUpload").val("");
						
						$(this).dialog("close");
					}
				},
				close: function () {

					$("#input-date").val("");
					$("#input-location").val("");
					$("#input-category").val("");
					$("#input-price").val("");
					$("#input-score").val("");
					$("#input-content").val("");
					$("#imagePath").val("");
					$("#input-tourIdx").val("");
					$('#multiImgContainer').html('');
					$("#fileUpload").val("");
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
		    
			$(document).on("click", "#searchMap", function (event) {
				event.preventDefault();				
				mapDialog.dialog("open");
			});
			
			$('#fileUpload').on('change', ImgFileSelect);
		});
		
		// 파일 업로더 했을 때 실행되는 함수
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
						console.log(searchMarkers[index].title);
						console.log(searchMarkers[index].formatted_address);
						console.log('lat:'+searchMarkers[index].position.lat());
						console.log('lot:'+searchMarkers[index].position.lng());
						$('#input-location').val(searchMarkers[index].title+':'+searchMarkers[index].formatted_address);
						$('#input-lat').val(searchMarkers[index].position.lat);
						$('#input-lot').val(searchMarkers[index].position.lot);
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
							<dd>장소: ${post.placeName }</dd>
							<dd>주소: ${post.location }</dd>
							<dd>일시: ${post.tripDateTime }</dd>
							<dd>내용: ${post.content }</dd>
							<dd>이동수단: ${post.category }</dd>
							<dd>지출비용: ${post.price }</dd>
							<dd>평점: ${post.score }</dd>
							<dd>추천수: ${post.favorite }</dd>
						</dl>
					</div>
				</c:forEach>
				
				<div id="add-post-form" title="여행기 추가" style="display:none">
	  				<form id="addPostForm" method="post" action="${pageContext.servletContext.contextPath }/${ authUser.id}/post/add">
						<div>
							<table>
								<tr>
									<td>장&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
									<td><input id="input-location" type="text" value="" name="location"></td>
									<td><input id="input-lat" type="text" value="" name="lat" style="display: none;"></td>
									<td><input id="input-lot" type="text" value="" name="lot" style="display: none;"></td>
									<td><button id="searchMap">검색</button></td>
								</tr>
								<tr>
									<td>날짜/시간</td><td><input id="input-date" type="text" name="tripDateTime" class="datepicker-here" >
									<script>
										var prevDay;
										
									    $('#input-date').datepicker({
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
									<td>카테고리</td><td><input id="input-category" type="text" value="" name="category"></td>
								</tr>
								<tr>
									<td>가&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;격</td><td><input id="input-price" type="text" value="" name="price"></td>
								</tr>
								<tr>
									<td>점&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수</td><td><input id="input-score" type="text" value="" name="score"></td>
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
			<script type="text/javascript">
			
			</script>
			
		</div>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>

</body>
</html>







