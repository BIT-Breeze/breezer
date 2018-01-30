<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- bootstrap -->
<link href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css" rel="stylesheet" type="text/css">

<title>Insert title here</title>
<style>
html, body, h1, h2, h3, h4, h5, h6 {
	font-family: "Roboto", sans-serif
}

/* 맵관련 */
#map {
	height: 60%;
}

html, body {
	height: 100%;
	margin: 0;
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
	width: 100%;
	height: 40px;
	outline: none;
	padding: 0 11px 0 13px;
	margin-bottom: 10px;
	text-overflow: ellipsis;
}

.controls:focus {
	border-color: #4d90fe;
}
/*******/

/* info 관련 */
#infowindow-content {
	display: none;
}

#map #infowindow-content {
	display: inline;
}

/* post 관련 */
#title {
	margin-top: 10px;
	font-weight: bold;
}

#card {
	display: inline-block;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	max-width: 300px;
	padding: 0 30px;
	text-decoration: none;
	margin-top: 10px;
}

div #scrollmenu {
	max-width: 1370px;
	height: 350px;
	overflow: auto;
	white-space: nowrap;
}

div #scrollmenu a:hover {
	background-color: #777;
}

</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
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
		var map = new google.maps.Map(document.getElementById('googleMap'), {
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
	        	alert("검색 결과가 없습니다.");
				return;
	        } 
	        
	        var search_place = [];	        
	        for (var i = 0; i < places.length; i++) {
	        	search_place.push(places[i].formatted_address);
			}
	        
	        $("#scrollmenu").empty();
			
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
					
					if (response.data.length == 0) {
						renderNoData();
					}
					
					// Recommend data
					$.each(response.data, function(index, data){
						recommendMarkers[index] = new google.maps.Marker({
					          position: {lat: data.lat, lng: data.lot},
					          map: map,
				        	  draggable:false // 드래그 가능 여부
			        	});
						
						renderData( index, data );
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
	
	var renderData = function( index, data ) {
		var location = data.location.split(" "); 
		var html = 
			"<div id='card'>" +
				"<img src='${pageContext.request.contextPath }/assets/images/pic" + (index + 1) + ".jpg' style='width: 100%'>" +
				"<p id='title' class='w3-xlarge w3-center'>"+ location[location.length - 1] +"</p>" +
				"<p> <i class='fa fa-comment w3-large w3-text-teal' aria-hidden='true'></i> " + data.content + "</p>" +
				"<p> <i class='fa fa-thumbs-o-up w3-large w3-text-teal'></i> " + data.favorite + "개</p>" + 
			"</div>";

		$("#scrollmenu").append(html);	
	}

	var renderNoData = function() {
		var html = "<p class='w3-xlarge w3-center'><i class='fa fa-exclamation-triangle w3-xlarge w3-text-teal' aria-hidden='true'></i> 검색된 데이터가 없습니다.</p>";
		$("#scrollmenu").append(html);	
	}
	
	function handleLocationError(browserHasGeolocation, infoWindow, pos) {
		infoWindow.setPosition(pos);
		infoWindow.setContent(browserHasGeolocation ?
		                      'Error: The Geolocation service failed.' :
		                      'Error: Your browser doesn\'t support geolocation.');
	}

    </script>
</head>
<body class="w3-light-grey">
	<!-- Header -->
	<div>
		<header class="w3-center w3-margin-bottom">
			<c:import url="/WEB-INF/views/includes/header.jsp" />
			<c:import url="/WEB-INF/views/includes/side_navigation.jsp" />
		</header>
	</div>
	
	<!-- Page Container -->
	<div class="w3-content w3-margin-top w3-card-4 w3-round-large" style="max-width: 1400px;">

		<!-- Map Column -->
		<div class="w3-row-padding w3-padding-16">
			<input id="pac-input" class="controls" type="text" placeholder="Search...">
	
			<div id="googleMap" style="width: 100%; height: 600px;"></div>
			<!-- Google Map -->
			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc6s8eAHp3wLMJsJ9lPew0fD2aPANMe60&libraries=places&callback=initAutocomplete" async defer></script>
			<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBCOZIjbRpUmHxNptiJHd5G8JRoVf_3XY&libraries=places&callback=initAutocomplete" async defer></script> -->
			<!-- Google Marker Cluster -->
			<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
		</div>
		
		<hr>
	
		<!-- Info Column -->
		<div class="w3-row-padding">
	
			<div class="w3-white w3-text-grey">
	
				<div class="w3-cell-row">
					<div id="scrollmenu" class="w3-container w3-padding-16">
						<p class="w3-xlarge w3-center"><i class="fa fa-search w3-xlarge w3-text-teal" aria-hidden="true"></i> 원하는 장소를 검색 해주세요.</p>
					</div>
				</div>
				
			</div>
			
		</div>
		
	</div>
	
	<br>
	<br>

	<footer class="w3-container w3-teal w3-center w3-margin-top">
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</footer>
	
</body>
</html>