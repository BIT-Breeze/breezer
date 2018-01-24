<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<title>Insert title here</title>
<style>
html, body, h1, h2, h3, h4, h5, h6 {
	font-family: "Roboto", sans-serif
}

#map {
	width: 100%;
	height: 60%;
	background-color: grey;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
} 

#drive_mode{
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
	text-align: center;
	font-family: 'Roboto', 'sans-serif';
	line-height: 30px;
	padding-left: 10px;
	margin-left: 10px;
}

#zoom_box{
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
	text-align: center;
	font-family: 'Roboto', 'sans-serif';
	line-height: 30px;
	padding-left: 10px;
	margin-top: 10px;
}

/* info css */
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  margin: auto;
  text-align: center;
  font-family: arial;
  padding-top: 10px;
  padding-left: 10px;
}

.title {
  color: grey;
  font-size: 18px;
}

button {
  border: none;
  outline: 0;
  display: inline-block;
  padding: 8px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
  font-size: 18px;
}

a {
  text-decoration: none;
  font-size: 22px;
  color: black;
}

button:hover, a:hover {
  opacity: 0.7;
}
/* info css */
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<script type="text/javascript">
// 맵 관련
var map = null;

// DB에서 이미지 경로 받아서 사용
var imageArr = [
	'/breezer/assets/images/pic1.jpg',
	'/breezer/assets/images/pic2.jpg',
	'/breezer/assets/images/pic3.jpg',
	'/breezer/assets/images/pic4.jpg',
	'/breezer/assets/images/pic5.jpg',
	'/breezer/assets/images/pic6.jpg',
	'/breezer/assets/images/pic7.jpg',
	'/breezer/assets/images/pic8.jpg',
	'/breezer/assets/images/pic9.jpg',
	'/breezer/assets/images/pic10.jpg',
	'/breezer/assets/images/pic11.jpg',
	'/breezer/assets/images/pic12.jpg',
	'/breezer/assets/images/pic13.jpg',
	'/breezer/assets/images/pic14.jpg',
	];
      
    // Marker Image
	var markerImage = [];
	// Google Direction Service
	var start = [];
	var destination = [];
	var waypts = [];
	var markerArray = [];
	
	function initMap() {
		// Google Direction Service 관련
		var directionsService = new google.maps.DirectionsService;
		var directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers: true});
		
		// Google Map Style 추가
		var styledMapType = new google.maps.StyledMapType(
			[
				{elementType: 'geometry', stylers: [{color: '#ebe3cd'}]},
				{elementType: 'labels.text.fill', stylers: [{color: '#523735'}]},
				{elementType: 'labels.text.stroke', stylers: [{color: '#f5f1e6'}]},
				{
				  featureType: 'administrative',
				  elementType: 'geometry.stroke',
				  stylers: [{color: '#c9b2a6'}]
				},
				{
				  featureType: 'administrative.land_parcel',
				  elementType: 'geometry.stroke',
				  stylers: [{color: '#dcd2be'}]
				},
				{
				  featureType: 'administrative.land_parcel',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#ae9e90'}]
				},
				{
				  featureType: 'landscape.natural',
				  elementType: 'geometry',
				  stylers: [{color: '#dfd2ae'}]
				},
				{
				  featureType: 'poi',
				  elementType: 'geometry',
				  stylers: [{color: '#dfd2ae'}]
				},
				{
				  featureType: 'poi',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#93817c'}]
				},
				{
				  featureType: 'poi.park',
				  elementType: 'geometry.fill',
				  stylers: [{color: '#a5b076'}]
				},
				{
				  featureType: 'poi.park',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#447530'}]
				},
				{
				  featureType: 'road',
				  elementType: 'geometry',
				  stylers: [{color: '#f5f1e6'}]
				},
				{
				  featureType: 'road.arterial',
				  elementType: 'geometry',
				  stylers: [{color: '#fdfcf8'}]
				},
				{
				  featureType: 'road.highway',
				  elementType: 'geometry',
				  stylers: [{color: '#f8c967'}]
				},
				{
				  featureType: 'road.highway',
				  elementType: 'geometry.stroke',
				  stylers: [{color: '#e9bc62'}]
				},
				{
				  featureType: 'road.highway.controlled_access',
				  elementType: 'geometry',
				  stylers: [{color: '#e98d58'}]
				},
				{
				  featureType: 'road.highway.controlled_access',
				  elementType: 'geometry.stroke',
				  stylers: [{color: '#db8555'}]
				},
				{
				  featureType: 'road.local',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#806b63'}]
				},
				{
				  featureType: 'transit.line',
				  elementType: 'geometry',
				  stylers: [{color: '#dfd2ae'}]
				},
				{
				  featureType: 'transit.line',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#8f7d77'}]
				},
				{
				  featureType: 'transit.line',
				  elementType: 'labels.text.stroke',
				  stylers: [{color: '#ebe3cd'}]
				},
				{
				  featureType: 'transit.station',
				  elementType: 'geometry',
				  stylers: [{color: '#dfd2ae'}]
				},
				{
				  featureType: 'water',
				  elementType: 'geometry.fill',
				  stylers: [{color: '#b9d3c2'}]
				},
				{
				  featureType: 'water',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#92998d'}]
				}
			],
			{name: 'Styled Map'});
		var nightMode = new google.maps.StyledMapType(
			[
				{elementType: 'geometry', stylers: [{color: '#242f3e'}]},
				{elementType: 'labels.text.stroke', stylers: [{color: '#242f3e'}]},
				{elementType: 'labels.text.fill', stylers: [{color: '#746855'}]},
				{
				  featureType: 'administrative.locality',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#d59563'}]
				},
				{
				  featureType: 'poi',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#d59563'}]
				},
				{
				  featureType: 'poi.park',
				  elementType: 'geometry',
				  stylers: [{color: '#263c3f'}]
				},
				{
				  featureType: 'poi.park',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#6b9a76'}]
				},
				{
				  featureType: 'road',
				  elementType: 'geometry',
				  stylers: [{color: '#38414e'}]
				},
				{
				  featureType: 'road',
				  elementType: 'geometry.stroke',
				  stylers: [{color: '#212a37'}]
				},
				{
				  featureType: 'road',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#9ca5b3'}]
				},
				{
				  featureType: 'road.highway',
				  elementType: 'geometry',
				  stylers: [{color: '#746855'}]
				},
				{
				  featureType: 'road.highway',
				  elementType: 'geometry.stroke',
				  stylers: [{color: '#1f2835'}]
				},
				{
				  featureType: 'road.highway',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#f3d19c'}]
				},
				{
				  featureType: 'transit',
				  elementType: 'geometry',
				  stylers: [{color: '#2f3948'}]
				},
				{
				  featureType: 'transit.station',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#d59563'}]
				},
				{
				  featureType: 'water',
				  elementType: 'geometry',
				  stylers: [{color: '#17263c'}]
				},
				{
				  featureType: 'water',
				  elementType: 'labels.text.fill',
				  stylers: [{color: '#515c6d'}]
				},
				{
				  featureType: 'water',
				  elementType: 'labels.text.stroke',
				  stylers: [{color: '#17263c'}]
				}
			],
			{name: 'Night Mode'});

		// Create the map.
		map = new google.maps.Map(document.getElementById('googleMap'), {
			zoom : 5,
			center :  {lat: 39.750843, lng: -100.87454600000001},
			disableDefaultUI: false, // 지도 내의 UI 표시 여부
			mapTypeControl: true,
	        mapTypeControlOptions: {
	            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
	            mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain', 'styled_map', 'night_mode']
	        }
		});
		
		// Style Map Settings.
		map.mapTypes.set('styled_map', styledMapType);
 		map.mapTypes.set('night_mode', nightMode);
 		
 		// Driving mode settings.
 		var driveControl = document.getElementById('drive_mode');
	  	map.controls[google.maps.ControlPosition.LEFT_TOP].push(driveControl);
	  	
	 	// Zoom settings.
 		var zoomControl = document.getElementById('zoom_box');
	  	map.controls[google.maps.ControlPosition.TOP_CENTER].push(zoomControl);

	  	$("#zoom").append(map.getZoom());
	  	map.addListener('zoom_changed', function() {
	  		$("#zoom").empty();
	  		
			var html = map.getZoom();
			$("#zoom").append(html);
        });
 		
		var len;
		var infowindow = new google.maps.InfoWindow();
		
		/* var userId = ${list.get(0).userId };
		var tourIdx = ${list.get(0).idx }; */
		
		var userId = ${vo.userId };
		var tourIdx = ${vo.idx };
		
		// test url : "/breezer/api/tour/location 
		$.ajax({
			url: "/breezer/api/tour/getmapinfo",
			type: "post",
			data: "userId=" + userId +
				  "&tourIdx=" + tourIdx,
			dataType: "json",
			success: function(response) {
				if( response.result == "fail" ) {
					console.log( response.message );
					return;
				}
				
				// Direction Service 한번만 호출하기 위해
				len = response.data.length;
				
				console.log(response.data);
				
				$.each(response.data, function(index, data){
					if (index == 0) {
						start.push({lat: data.lat, lng: data.lot});
					} else if (index == len - 1) {
						destination.push({lat: data.lat, lng: data.lot});
					}else {
						// Way Point Settings.
						waypts.push({
				  	        location: {lat: data.lat, lng: data.lot},
				  	        stopover: true
				      	});
					}
					
					setTimeout(function(){
						// marker Icon resize & create.
						var markerIcon = new google.maps.MarkerImage(imageArr[index], null, null, null, new google.maps.Size(50,50));
						markerArray[index] = new google.maps.Marker({
					          position: {lat: data.lat, lng: data.lot},
					          map: map,
					          icon: markerIcon,
					          animation:google.maps.Animation.BOUNCE,
				        	  draggable:false // 드래그 가능 여부
				        });
						
						var contents = "";
						// Marker Click -> infowindow create.
						markerArray[index].addListener('click', function() {
							map.setZoom(8);
							map.setCenter(markerArray[index].getPosition());
							
							// 장소 상호명
							// 시카고 미술관:111 S Michigan Ave, Chicago, IL 60603 미국
							var placeName = data.location.split(":"); 
							
							// 마커 정보
							contents = 
								'<div class="card">' + 
									'<img src="/breezer/assets/images/pic' + (index + 1) + '.jpg" style="width:100%">' + 
									'<h1>' + placeName[0] + '</h1>' + 
									'<p class="title">' + data.content + '</p>' +
								'</div>';
							
							infowindow.setContent(contents);
							infowindow.open(map, markerArray[index]);
						});
					}, index * 600);
					
					// 마지막에 한번만 호출
					if (index == len - 1) {
						setTimeout(function(){
							calculateAndDisplayRoute(directionsService, directionsDisplay);
							
							directionsDisplay.setMap(map);
						}, len * 600);	
					}
				});
			},
			error: function(xhr, status, e){
				console.error( status + ":" + e );
			}
		});
		
		// Driving Mode Change.
		document.getElementById('mode').addEventListener('change', function() {
		    calculateAndDisplayRoute(directionsService, directionsDisplay);
	  	});
	}

	// Google Map Direction Service.
	function calculateAndDisplayRoute(directionsService, directionsDisplay) {
		var selectedMode = document.getElementById('mode').value;
		
	  	directionsService.route({
			origin : start[0],
			destination : destination[0],
			waypoints: waypts,
		    optimizeWaypoints: true,
			travelMode : google.maps.TravelMode[selectedMode]
		}, function(response, status) {
			if (status === 'OK') {
				directionsDisplay.setDirections(response)
			} else {
				window.alert('Directions request failed due to ' + status);
			}
		});
	}
</script>

</head>
<body class="w3-light-grey">
	<!-- Page Container -->
	<div class="w3-content w3-margin-top" style="max-width: 1400px;">

		<!-- Map Column -->
		<div class="w3-row-padding">
			<div id="drive_mode">
				<b>Mode of Travel : </b> 
				<select id="mode">
					<option value="DRIVING">Driving</option>
					<option value="WALKING">Walking</option>
					<option value="BICYCLING">Bicycling</option>
					<option value="TRANSIT">Transit</option>
				</select>
			</div>
			
			<div id="zoom_box">
				<b>Camera Zoom</b>
				<div id="zoom"></div>
			</div>
		
			<!-- <div id="map"></div> -->
			<div id="googleMap" style="width: 100%; height: 600px;"></div>
			<!-- Google Map -->
			<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc6s8eAHp3wLMJsJ9lPew0fD2aPANMe60&callback=initMap"></script>
		</div>
		
		<hr>
	
		<!-- Info Column -->
		<div class="w3-row-padding">
	
			<div class="w3-white w3-text-grey w3-card-4">
	
				<div class="w3-cell-row">
					<div class="w3-container w3-cell w3-third">
						<div class="w3-display-container w3-padding-16">
							<img src="/breezetest/assets/images/pic10.jpg" style="width: 100%; height: 400px">
						</div>
						
						<div class="w3-container w3-padding-16">
							<p><i class="fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-teal"></i>id</p>
							<p><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>title</p>
							<p><i class="fa fa-envelope fa-fw w3-margin-right w3-large w3-text-teal"></i>date</p>
							<p><i class="fa fa-phone fa-fw w3-margin-right w3-large w3-text-teal"></i>score</p>
						</div>
					</div>
					
					<div class="w3-container w3-cell w3-twothird">
						<p class="w3-large"><b><i class="fa fa-asterisk fa-fw w3-margin-right w3-text-teal"></i>Skills</b></p>
						<p>Adobe Photoshop</p>
						
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-teal" style="width: 90%">90%</div>
						</div>
						
						<p>Photography</p>
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-teal" style="width: 80%">
								<div class="w3-center w3-text-white">80%</div>
							</div>
						</div>
						
						<p>Illustrator</p>
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-teal" style="width: 75%">75%</div>
						</div>
						
						<p>Media</p>
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-teal" style="width: 50%">50%</div>
						</div>
						
						<hr>
						
						<p class="w3-large w3-text-theme"><b><i class="fa fa-globe fa-fw w3-margin-right w3-text-teal"></i>Languages</b></p>
						
						<p>English</p>
						<div class="w3-light-grey w3-round-xlarge">
							<div class="w3-round-xlarge w3-teal" style="height: 24px; width: 100%"></div>
						</div>
						
						<p>Spanish</p>
						<div class="w3-light-grey w3-round-xlarge">
							<div class="w3-round-xlarge w3-teal" style="height: 24px; width: 55%"></div>
						</div>
						
						<p>German</p>
						<div class="w3-light-grey w3-round-xlarge">
							<div class="w3-round-xlarge w3-teal" style="height: 24px; width: 25%"></div>
						</div>
						
					</div>

				</div>
	
			</div>
	
			<!-- End Left Column -->
		</div>

		<!-- End Page Container -->
	</div>

	<footer class="w3-container w3-teal w3-center w3-margin-top">
		<p>Find me on social media.</p>
		<i class="fa fa-facebook-official w3-hover-opacity"></i>
		<i class="fa fa-instagram w3-hover-opacity"></i>
		<i class="fa fa-snapchat w3-hover-opacity"></i>
		<i class="fa fa-pinterest-p w3-hover-opacity"></i>
		<i class="fa fa-twitter w3-hover-opacity"></i>
		<i class="fa fa-linkedin w3-hover-opacity"></i>
		
		<p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
	</footer>

	
</body>
</html>