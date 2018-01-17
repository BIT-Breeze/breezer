<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
/* Always set the map height explicitly to define the size of the div element that contains the map. */
#map {
	height: 60%;
}

/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 50px;
	padding: 0;
}

.controls {
	background-color: #fff;
	border-radius: 2px;
	border: 1px solid transparent;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
	box-sizing: border-box;
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
	height: 29px;
	margin-left: 17px;
	margin-top: 10px;
	outline: none;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 400px;
}

.controls:focus {
	border-color: #4d90fe;
}

.title {
	font-weight: bold;
}

#infowindow-content {
	display: none;
}

#map #infowindow-content {
	display: inline;
}

div.scrollmenu {
	overflow: auto;
	white-space: nowrap;
}

div.scrollmenu a:hover {
	background-color: #777;
}

.card {
	display: inline-block;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	max-width: 300px;
	text-align: center;
	padding: 0 30px;
	text-decoration: none;
}
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
    // This example adds a search box to a map, using the Google Place Autocomplete
    // feature. People can enter geographical searches. The search box will return a
    // pick list containing a mix of places and predicted search terms.

    // This example requires the Places library. Include the libraries=places
    // parameter when you first load the API. For example:
    // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

    // Post Image
    var imageArr = [
	'/breezetest/assets/images/pic1.jpg',
	'/breezetest/assets/images/pic2.jpg',
	'/breezetest/assets/images/pic3.jpg',
	'/breezetest/assets/images/pic4.jpg',
	'/breezetest/assets/images/pic5.jpg',
	'/breezetest/assets/images/pic6.jpg',
	'/breezetest/assets/images/pic7.jpg',
	'/breezetest/assets/images/pic8.jpg',
	'/breezetest/assets/images/pic9.jpg',
	'/breezetest/assets/images/pic10.jpg',
	'/breezetest/assets/images/pic11.jpg',
	'/breezetest/assets/images/pic12.jpg',
	'/breezetest/assets/images/pic13.jpg',
	'/breezetest/assets/images/pic14.jpg',
	];
    
	function initAutocomplete() {
		var map = new google.maps.Map(document.getElementById('map'), {
			center: {lat: -33.8688, lng: 151.2195},
			zoom: 13,
			mapTypeId: 'roadmap'
		});
		
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
      var recommendMarkers = [];
      var nearbyMarkers = [];
      // Listen for the event fired when the user selects a prediction and retrieve more details for that place.
      searchBox.addListener('places_changed', function() {
	        var places = searchBox.getPlaces();
	        
	        if (places.length == 0) {
	          return;
	        } 
	        
	        var search_place = [];	        
	        for (var i = 0; i < places.length; i++) {
	        	search_place.push(places[i].formatted_address);
			}
	        
	        $(".scrollmenu").empty();
			
			// Clear out the old markers.
			recommendMarkers.forEach(function(marker) {
	        	marker.setMap(null);
	        });
			nearbyMarkers.forEach(function(marker) {
	        	marker.setMap(null);
	        });
	        
	        $.ajax({
				url: "/breezer/api/recommend",
				type: "post",
				dataType: "json",
				data: "location=" + search_place,
				success: function( response ) {
					if( response.result != "success" ) {
						console.log( response.message );
						alert("죄송합니다.\n서비스 점검중입니다.");
						return;
					}
					
					// Recommend data
					$.each(response.data, function(index, data){
						recommendMarkers[index] = new google.maps.Marker({
					          position: {lat: data.lat, lng: data.lot},
					          map: map,
				        	  draggable:false // 드래그 가능 여부
				        });
						
						render( index, data );
					});
					
					// Recommend MarkerCluster
					var recommendCluster = new MarkerClusterer(map, recommendMarkers, {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});	
				}
			});
	
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
					position: place.geometry.location
				}));
				
				// 마커 검색 장소 정보
				searchMarkers[index].addListener('click', function() {
					infowindow.setContent(place.name);
					infowindow.open(map, searchMarkers[index]);
					
					// 클릭 시 확대
					map.setZoom(15);
					map.setCenter(searchMarkers[index].getPosition());
					
					// 클릭 시 recommned 한번 클리어 하고 주변꺼만
					/* recommendMarkers.forEach(function(marker) {
			        	marker.setMap(null);
			        }); */
					
					//비동기 식의 한번 더 디비 검색...
					$.ajax({
						url: "/breezer/api/nearby",
						type: "post",
						dataType: "json",
						data: "lat=" + map.getCenter().toJSON().lat +
							  "&lot=" + map.getCenter().toJSON().lng +
							  "&address=" + place.formatted_address,
						success: function( response ) {
							if( response.result != "success" ) {
								console.log( response.message );
								return;
							}
							
							// Clear out the old markers.
							nearbyMarkers.forEach(function(marker) {
					        	marker.setMap(null);
					        });
							
							$.each(response.data, function(index, data){
								console.log(data);

								var resizeIcon = new google.maps.MarkerImage(imageArr[index], null, null, null, new google.maps.Size(50,50));
								nearbyMarkers[index] = new google.maps.Marker({
							          position: {lat: data.lat, lng: data.lot},
							          map: map,
							          icon: resizeIcon,
							          animation:google.maps.Animation.BOUNCE,
						        	  draggable:false // 드래그 가능 여부
						        });
							});
						}
					});
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
	
	// 추후 어떤 데이터를 띄울지 미정...
	var render = function( index, data ) {
		var location = data.location.split(" "); 
		
		var html = 
			"<div class='card'>" +
				"<img src='${pageContext.request.contextPath }/assets/images/pic" + (index + 1) + ".jpg' style='width: 100%'>" +
				"<h2>"+ location[location.length - 1] +"</h2>" +
				"<p class='title'>" + data.content + "</p>" +
				"<p>lat: "+ data.lat +", lot : "+ data.lot +"</p>" + 
			"</div>";
			
		$(".scrollmenu").append(html);
	}
	
	function handleLocationError(browserHasGeolocation, infoWindow, pos) {
		infoWindow.setPosition(pos);
		infoWindow.setContent(browserHasGeolocation ?
		                      'Error: The Geolocation service failed.' :
		                      'Error: Your browser doesn\'t support geolocation.');
	}

    </script>
</head>
<body>
	<input id="pac-input" class="controls" type="text" placeholder="Search Box">
	
	<div id="map"></div>
	
	<br>
	<br>
	
	<div class="scrollmenu"></div>
	
	<!-- 구글 맵 호출 -->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc6s8eAHp3wLMJsJ9lPew0fD2aPANMe60&libraries=places&callback=initAutocomplete" async defer></script>
	<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBCOZIjbRpUmHxNptiJHd5G8JRoVf_3XY&libraries=places&callback=initAutocomplete" async defer></script> -->
	
	<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	
	<br>
	<br>
	<br>
	
</body>
</html>