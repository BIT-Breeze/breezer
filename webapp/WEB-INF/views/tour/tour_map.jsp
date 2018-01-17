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
<title>Insert title here</title>
<!-- Font Awesome Icon Library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
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

* {
    box-sizing: border-box;
}

/* Star Rating */
/* body {
    font-family: Arial;
    margin: 0 auto; /* Center website */
    max-width: 800px; /* Max width */
    padding: 20px;
} */

.heading {
    font-size: 25px;
    margin-right: 25px;
}

.fa {
    font-size: 25px;
}

.checked {
    color: orange;
}

/* Three column layout */
.side {
    float: left;
    width: 15%;
    margin-top:10px;
}

.middle {
    margin-top:10px;
    float: left;
    width: 70%;
}

/* Place text to the right */
.right {
    text-align: right;
}

/* Clear floats after the columns */
.row:after {
    content: "";
    display: table;
    clear: both;
}

/* The bar container */
.bar-container {
    width: 100%;
    background-color: #f1f1f1;
    text-align: center;
    color: white;
}

/* Individual bars */
.bar-5 {width: 60%; height: 18px; background-color: #4CAF50;}
.bar-4 {width: 30%; height: 18px; background-color: #2196F3;}
.bar-3 {width: 10%; height: 18px; background-color: #00bcd4;}
.bar-2 {width: 4%; height: 18px; background-color: #ff9800;}
.bar-1 {width: 15%; height: 18px; background-color: #f44336;}

/* Responsive layout - make the columns stack on top of each other instead of next to each other */
@media (max-width: 400px) {
    .side, .middle {
        width: 100%;
    }
    .right {
        display: none;
    }
}

/* info css */
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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
		map = new google.maps.Map(document.getElementById('map'), {
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
		
		$.ajax({
			url: "/breezer/api/tour/location",
			type: "post",
			dataType: "json",
			success: function(response) {
				if( response.result == "fail" ) {
					console.log( response.message );
					return;
				}
				
				// Direction Service 한번만 호출하기 위해
				len = response.data.length;
				
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
							
							var tourString = data.name;
							
							// 마커 정보
							contents = 
								'<div class="card">' + 
									'<img src="/breezetest/assets/images/pic' + (index + 1) + '.jpg" style="width:100%">' + 
									'<h1>' + data.name + '</h1>' + 
									'<p class="title">Contents</p>' +
									'<p>ETC...</p>' +
									'<p><button onclick=moreInfo('+ data.name +') >More...</button></p>' + 
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
	
	// Google Chart.
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawChart);

	// Draw the chart and set the chart values
	function drawChart() {
	  var data = google.visualization.arrayToDataTable([
	  ['Task', 'Hours per Day'],
	  ['Work', 8],
	  ['Eat', 2],
	  ['TV', 4],
	  ['Gym', 2],
	  ['Sleep', 8]
	]);

	  // Optional; add a title and set the width and height of the chart
	  var options = {'title':'My Average Day', 'width':550, 'height':400};

	  // Display the chart inside the <div> element with id="piechart"
	  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	  chart.draw(data, options);
	}
</script>

</head>
<body>
	<h3>My Google Maps Demo</h3>
	
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

	<div id="map"></div>
	<!-- Google Map -->
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc6s8eAHp3wLMJsJ9lPew0fD2aPANMe60&callback=initMap"></script>

	<!-- Google Chart -->	
	<div id="piechart"></div>

	<!-- Star Rating -->
	<span class="heading">User Rating</span>
	<span class="fa fa-star checked"></span>
	<span class="fa fa-star checked"></span>
	<span class="fa fa-star checked"></span>
	<span class="fa fa-star checked"></span>
	<span class="fa fa-star"></span>
	<p>4.1 average based on 254 reviews.</p>
	<hr style="border: 3px solid #f1f1f1">

	<div class="row">
		<div class="side">
			<div>5 star</div>
		</div>
		<div class="middle">
			<div class="bar-container">
				<div class="bar-5"></div>
			</div>
		</div>
		<div class="side right">
			<div>150</div>
		</div>
		<div class="side">
			<div>4 star</div>
		</div>
		<div class="middle">
			<div class="bar-container">
				<div class="bar-4"></div>
			</div>
		</div>
		<div class="side right">
			<div>63</div>
		</div>
		<div class="side">
			<div>3 star</div>
		</div>
		<div class="middle">
			<div class="bar-container">
				<div class="bar-3"></div>
			</div>
		</div>
		<div class="side right">
			<div>15</div>
		</div>
		<div class="side">
			<div>2 star</div>
		</div>
		<div class="middle">
			<div class="bar-container">
				<div class="bar-2"></div>
			</div>
		</div>
		<div class="side right">
			<div>6</div>
		</div>
		<div class="side">
			<div>1 star</div>
		</div>
		<div class="middle">
			<div class="bar-container">
				<div class="bar-1"></div>
			</div>
		</div>
		<div class="side right">
			<div>20</div>
		</div>
	</div>
	
	<br>
	<br>
	
</body>
</html>