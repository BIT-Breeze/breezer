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

      var markers = [];
      // Listen for the event fired when the user selects a prediction and retrieve
      // more details for that place.
      searchBox.addListener('places_changed', function() {
	        var places = searchBox.getPlaces();
	        
	        console.log(places);
	
	        if (places.length == 0) {
	          return;
	        }
	        
	        var search_place = [];	        
	        for (var i = 0; i < places.length; i++) {
	        	console.log(places[i].name);
	        	search_place.push(places[i].name);
			}
	        
	        $.ajax({
				url: "/breezer/api/recommend/nearby",
				type: "post",
				dataType: "json",
				data: "location=" + search_place,
				success: function( response ) {
					if( response.result != "success" ) {
						console.log( response.message );
						return;
					}
					
					$(".scrollmenu").empty();
								
					$.each(response.data, function(index, data){
						render( index, data );
					});
				}
			});
	
	        // Clear out the old markers.
	        markers.forEach(function(marker) {
	        	marker.setMap(null);
	        });
	        
	        markers = [];
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
				markers.push(new google.maps.Marker({
					map: map,
					icon: icon,
					title: place.name,
					position: place.geometry.location
				}));
				
				// 마커 검색 장소 정보
				markers[index].addListener('click', function() {
					infowindow.setContent(place.name);
					infowindow.open(map, markers[index]);
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
	
	var render = function( index, data ) {
		var html = 
			"<div class='card'>" +
				"<img src='${pageContext.request.contextPath }/assets/images/pic" + (index + 1) + ".jpg' alt='John' style='width: 100%'>" +
				"<h2>"+ data.userId +"</h2>" +
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
	
	<br>
	<br>
	<br>
	
</body>
</html>