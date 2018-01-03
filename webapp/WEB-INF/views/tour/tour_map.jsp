<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
 #map {
	width: 100%;
	height: 600px;
	background-color: grey;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
} 

#floating-panel {
	position: absolute;
	top: 7%;
	left: 6%;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
	text-align: center;
	font-family: 'Roboto', 'sans-serif';
	line-height: 30px;
	padding-left: 10px;
}

/* data 
1. ID
2. tourIdx
3. 각 장소의 정보(이미지, 위도, 경도, 설명??)
*/

</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
// 맵 관련
var map = null;

// marker icon
var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
var icons = {
        parking: {
          icon: iconBase + 'parking_lot_maps.png'
        },
        library: {
          icon: iconBase + 'library_maps.png'
        },
        info: {
          icon: iconBase + 'info-i_maps.png'
        }
      };
var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
var imagePath = '/breezetest/assets/images/pic.png';
      
// 마커 정보
var contentString = '<div id="content">'+
'<div id="siteNotice">'+
'</div>'+
'<h1 id="firstHeading" class="firstHeading">Uluru</h1>'+
'<div id="bodyContent">'+
'<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
'sandstone rock formation in the southern part of the '+
'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) '+
'south west of the nearest large town, Alice Springs; 450&#160;km '+
'(280&#160;mi) by road. Kata Tjuta and Uluru are the two major '+
'features of the Uluru - Kata Tjuta National Park. Uluru is '+
'sacred to the Pitjantjatjara and Yankunytjatjara, the '+
'Aboriginal people of the area. It has many springs, waterholes, '+
'rock caves and ancient paintings. Uluru is listed as a World '+
'Heritage Site.</p>'+
'<p>Attribution: Uluru, <a href="https://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
'https://en.wikipedia.org/w/index.php?title=Uluru</a> '+
'(last visited June 22, 2009).</p>'+
'</div>'+
'</div>';

/* 국내 아직 지원안됨.
* 양재동 내집 37.467382, 127.042824 (출발)
* 비트컴퓨터 37.495045, 127.027579
* 잠실타워 37.513093, 127.102538
* 홍대 게스트하우스 37.556161, 126.926755
* 일산역 37.682153, 126.770025
* 인사동 쌈지길 37.574971, 126.984959
* 서울숲 37.546104, 127.038418
* 북촌한옥마을 37.579203, 126.986407
* 광화문 광장 37.574323, 126.976786
* 사직공원 37.575786, 126.967613
* 신사동 가로수길 37.520847, 127.022927
* 이태원 덴마크 대사관 37.542266, 126.991894
* 서울고속버스 터미널 37.505556, 127.007078
* 여의도공원 37.531142, 126.928374
* 새빛둥둥섬 37.512735, 126.994676
* 인천국제공항 37.473245, 126.441303 (도착)
*/

/*
* 샌프란시스코 38.031350, -122.229343
* 로스앤젤레스 34.298848, -118.231447
* 라스베거스 36.261106, -115.095842
* 솔트레이크 시티 41.162476, -111.762637
* 시카고 41.878773, -87.628927
* 라피엣 40.397301, -86.853795
* 뉴캐슬 39.969984, -85.350588
* 콜럼버스 40.035443, -83.016152
* 뉴 필라델피아 40.583404, -81.439145
* 피츠버그 40.485986, -80.029161
* 워싱턴 38.977571, -77.018865
* 필라델피아 40.028393, -75.195744
* 뉴욕 40.774577, -73.980697
* 보스턴 42.435201, -71.047600
*/
	var start = [];
	var destination = [];
	var waypts = [];
	
	function initMap() {
		var directionsService = new google.maps.DirectionsService;
		var directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers: true});

		map = new google.maps.Map(document.getElementById('map'), {
			zoom : 5,
			center :  {lat: 39.750843, lng: -100.87454600000001},
			disableDefaultUI: false, // 지도 내의 UI 표시 여부
			mapTypeControl: true,
	        mapTypeControlOptions: {
	            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
	            mapTypeIds: ['roadmap', 'terrain']
	        }
		});

		// icon 이미지 크기 조절
		var myIcon = new google.maps.MarkerImage(imagePath, null, null, null, new google.maps.Size(50,50));
		var len;
		
		$.ajax({
			url: "/breezer/api/tour/location",
			type: "post",
			dataType: "json",
			success: function(response) {
				if( response.result == "fail" ) {
					console.log( response.message );
					return;
				}
				
				len = response.data.length;

				$.each(response.data, function(index, data){
					// 문자열을 정수로 변환
					var loc = {lat:  Number(data.lat), lng: Number(data.lot)};
					
					if (index == 0) {
						start.push(loc);
					} else if (index == len - 1) {
						destination.push(loc);
					}else {
						waypts.push({
				  	        location: loc,
				  	        stopover: true
				      	});
					}
					
					setTimeout(function(){
						var marker = new google.maps.Marker({
					          position: loc,
					          map: map,
					          icon: myIcon,
					          animation:google.maps.Animation.BOUNCE,
				        	  draggable:false // 드래그 가능 여부
				        });
						
						var infowindow = new google.maps.InfoWindow();
						marker.addListener('click', function() {
							infowindow.setContent(data.lat + ", " + data.lot + " - " + data.name);
							
							infowindow.open(map, marker);
						});
						
					}, index * 600);
					
					if (index == len - 1) {
						setTimeout(function(){
							calculateAndDisplayRoute(directionsService, directionsDisplay);
							
							document.getElementById('mode').addEventListener('change', function() {
							    calculateAndDisplayRoute(directionsService, directionsDisplay);
						  	});
							
							directionsDisplay.setMap(map);
						}, len * 600);	
					}
				});
				
			},
			error: function(xhr, status, e){
				console.error( status + ":" + e );
			}
		});
	}
	
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
				// console.log(directionsDisplay.map.getCenter());
			} else {
				window.alert('Directions request failed due to ' + status);
			}
		});
	}
</script>
</head>
<body>
	<h3>My Google Maps Demo</h3>
	
	<div id="floating-panel">
		<b>Mode of Travel: </b> 
		<select id="mode">
			<option value="DRIVING">Driving</option>
			<option value="WALKING">Walking</option>
			<option value="BICYCLING">Bicycling</option>
			<option value="TRANSIT">Transit</option>
		</select>
	</div>
	
	<div id="map"></div>
	<!-- 구글 맵 호출 -->
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc6s8eAHp3wLMJsJ9lPew0fD2aPANMe60&callback=initMap"></script>
</body>
</html>