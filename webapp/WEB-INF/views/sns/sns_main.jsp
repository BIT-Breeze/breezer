<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<title>Breezer</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- 이미지 슬라이더 -->
<%-- <link href="${pageContext.servletContext.contextPath }/assets/css/sns/style.css" rel="stylesheet" type="text/css" /> 
<script src="${pageContext.servletContext.contextPath }/assets/js/sns/packed.js" type="text/javascript"></script>  --%>




<!-- css -->

<link	href="${pageContext.servletContext.contextPath }/assets/css/sns/sns_main.css"	rel="stylesheet" type="text/css">
<!-- bootstrap -->
<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.min.css"	rel="stylesheet" type="text/css">
<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"	rel="stylesheet" type="text/css">

<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script> --%>
<%-- <script type="text/javascript"	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath }/assets/js/bootstrap.min.js"></script> --%>
<script type="text/javascript"	src="http://malsup.github.io/jquery.cycle2.js"></script>

<!-- side_navi css를 위해 임시로 가져옴 -> 기본적으로 navi.jsp 에 임포트 되있어야 할듯 -->
<%-- <link	href="${pageContext.servletContext.contextPath }/assets/css/user/user_main.css"	rel="stylesheet" type="text/css"> --%> 





<meta name="viewport" content="width=device-width, initial-scale=1">

</head>


<script type="text/javascript">
	
</script>

<script>
	var userid
	var isEnd = false;
	var sliderCount = 0

	var slideshow
	var sliderObjects = [];

	/*
	// page의 link된 라이브러리를 다시 초기화 할때 쓰는 함수 
	function reload_js(src) {
	    $('script[src="' + src + '"]').remove();
	    $('<script>').attr('src', src).appendTo('head');
	}
	 */

	// 이미지 크기를 조절하기 위한 함수.. 대기중 
	function resizeimg() {

	}

	 
	 //좋아요
	function likeup(voidx, tour, post, favoCnt) {
		console.log(voidx + ", " + tour + ", " + post + ", " + favoCnt )
		
		// postIdx가 0이면 tour,  아니면 post 
		if (post == 0) {
			console.log("this is tour")
			//TB_FAVORITE 에 insert (tourIdx, null)
			doLikeUpDown('up', 'tour', tour)
		} else {
			console.log("this is post")
			doLikeUpDown('up', 'post', post)
		}

		++favoCnt
		$("#favoidx"+voidx).html(favoCnt);
		
		//버튼 이름이랑 함수 바꿔줘야지 																														// 색칠한거 
		var html = "" + "<button id='btnFavo" + voidx + "' type='button' onclick='likedown(" + voidx + ", " + tour + ", " + post + ", "+ favoCnt +")'>&#10084; </button> "
					+ "<label>좋아요  </label>"
					+ "<label id='favoidx"+voidx+"' style='margin-left:10px'>  "+ favoCnt +"</label> <br>"
		$("#likebtn" + voidx).empty();
		$("#likebtn" + voidx).append(html);
	}

	 //좋아요 취소 
	function likedown(voidx, tour, post, favoCnt) {
		console.log(voidx + ", " + tour + ", " + post+ ", " + favoCnt)
		// postIdx가 0이면 tour,  아니면 post 
		if (post == 0) {
			//console.log("this is tour")
			//TB_FAVORITE 에 delete 9 id, tourIdx, null)
			doLikeUpDown('down', 'tour', tour)
		} else {
			//console.log("this is post")
			doLikeUpDown('down', 'post', post)
		}

		//출력되는 좋아요 수 변경 
		--favoCnt
		$("#favoidx"+voidx).html(favoCnt);
		
		//버튼 이름이랑 함수 바꿔줘야지 
		var html = "" + "<button id='btnFavo" + voidx + "' type='button' onclick='likeup(" + voidx + ", " + tour + ", " + post + ", "+ favoCnt +")'> &#9825; </button> "
					  + "<label>좋아요  </label>"
					  + "<label id='favoidx"+voidx+"' style='margin-left:10px'>  "+ favoCnt +"</label> <br>"
		$("#likebtn" + voidx).empty();
		$("#likebtn" + voidx).append(html);
	}

	 
	 // 좋아요/취소 버튼 동작 요청 
	function doLikeUpDown(flag, type, idx, favoCnt) {
		var id = "${userid }"
		//console.log("id : "+id+", flag : "+flag+", type : "+type+", idx : "+idx)

		$.ajax({
			url : "/breezer/api/sns/dolike",
			type : "post",
			dataType : "json",
			data : "id=" + id + "&flag=" + flag + "&type=" + type + "&idx="	+ idx,
			success : function(response) {
				console.log("dolike success")
			},
			error : function(xhr, status, e) {
				console.error(status + ":" + e);
			}
		});

	}

	 
	 //아래로 3개의 함수는 각 slider 마다 이미지를 보여주기 위한 함수.. 분석 필요 
	function plusDivs(obj, n) {
		var parentDiv = $(obj).parent();
		var matchedDiv;
		$.each(sliderObjects, function(i, item) {
			if ($(parentDiv[0]).attr('id') == $(item).attr('id')) {
				matchedDiv = item;
				return false;
			}
		});
		matchedDiv.slideIndex = matchedDiv.slideIndex + n;
		showDivs(matchedDiv, matchedDiv.slideIndex);
	}

	function createSliderObjects() {
		var sliderDivs = $('.slider');
		$.each(sliderDivs, function(i, item) {
			var obj = {};
			obj.id = $(item).attr('id');
			obj.divContent = item;
			obj.slideIndex = 1;
			obj.slideContents = $(item).find('.mySlides');
			showDivs(obj, 1);
			sliderObjects.push(obj);
		});
	}

	function showDivs(divObject, n) {
		// debugger;
		var i;
		if (n > divObject.slideContents.length) {
			divObject.slideIndex = 1
		}
		if (n < 1) {
			divObject.slideIndex = divObject.slideContents.length
		}
		for (i = 0; i < divObject.slideContents.length; i++) {
			divObject.slideContents[i].style.display = "none";
		}
		divObject.slideContents[divObject.slideIndex - 1].style.display = "block";
	}
	
	
	
	
	
	// snsvo를 가져올때 html 을 추가하는 함수 
	var render = function(vo, mode) {
		sliderCount += 1;

		if (sliderCount > 1) {
			//return;
		}
		
		//날짜 초 지우기 		
		vo.tripDateTime = vo.tripDateTime.substring(0,16);
		
		
		var photo = vo.photo;
		var photos = photo.split(',');
		for ( var i in photos) {
			//console.log(i +" : " + photos[i])
		}

		var html = "<div id='post' data-idx='"+vo.idx+"' style='width:800px; height: auto; background-color:#ffffff; border: 1px solid gray; border-radius: 10px;'  >"
				+ "		<div id='post-header' style='height: 40px; width:780px; margin-top:10px; margin-left:10px; background-color: #ffffff;'> "
				+ "			<div id='header-picture' style='float: left;'>"
				+ "				<div id='image-test' style='height: 40px; width: 40px; background-color: #ffffff; margin: 0px;'><img src = '"+vo.pictureUrl+"' style='height: 40px; width: 40px; border-radius: 20px;' > </div> "
				+ "			</div>"
				+ "			<div id='header-info' style='height: 40px; float: left; margin-left: 15px;  '>"
				+ "				<div id='header-nickname' style='height:auto; vertical-align: middle; position: relative;top: 50%;transform: translateY(-50%);'>"
				+ "					<label><a href='${pageContext.servletContext.contextPath }/"+vo.userId+"'>" + vo.userId + "(" + vo.nickName + ")" + "</a></label> "
				
				if( vo.location != null) {
					html = html + "					<br><label>" + vo.location + "</label>"
				}
				
				html = html
				+ "				</div>"
				//+ "				<div id='header-location'>"
				//+ "				</div>"
				+ "			</div>"
				+ "		</div>"

				+ "		<div id='post-picture' style='height:620px; width:780px; margin: auto; margin-top:10px; margin-bottom:10px; background-color:#ffffff;'> "
				//+ 	"<img id='sns-img'src=${pageContext.request.contextPath }"+ vo.photo + " style='width:100%; height: auto;'>"
				/* + '			<div id="wrapper" style="height:auto; width:100%;" >'
				+ '             <div class="sliderbutton"><img src="${pageContext.servletContext.contextPath }/assets/css/sns/left.gif" width="32" height="38" alt="Previous" onclick="slideshow.move(-1)" /></div> '
				+ '				<div id="slider" >'
				+ '					<ul> '	 */

				/* 		// 사진 갯수만큼 img 태그 만들기 
						for( var i in photos ) {
							html = html + " <li><img src=${pageContext.request.contextPath }"+photos[i] +" style='width:100%; height: auto;'   /></li>" 
						}
						+ '					</ul> '
						html = html 
						+ '				</div>'
						+ '             <div class="sliderbutton"><img src="${pageContext.servletContext.contextPath }/assets/css/sns/right.gif" width="32" height="38" alt="Previous" onclick="slideshow.move(1)" /></div> '
						+ ' 			<ul id="pagination" class="pagination"> '
						
						for( var i in photos ) {
							html = html + " <li onclick='slideshow.pos("+i+")'>"+(++i)+"</li>" 
						}

						html = html 
						+ ' 			</ul>' */

				// test2 
				/* 
				+ '  		<div class="cycle-slideshow"  data-cycle-timeout=0    data-cycle-prev="#prev'+sliderCount+' "        data-cycle-next="#next'+sliderCount+'"  data-index='+sliderCount+'>'
				//+ '             <div class="cycle-pager"></div>'
				+ '				<div class=center>'
				+ '			    	<span id="prev'+sliderCount+'" class="prevControl"> <<Prev </span>'
				+ '			    	<span id="next'+sliderCount+'" class="nextControl"> Next>> </span>'
				+ '				</div> '
				
				for( var i in photos ) {
					html = html + " <img src=${pageContext.request.contextPath }"+photos[i] +"  style='width:100%; height: auto;'  >" 
				}
				
				
				html = html
				+ "			</div>"
				 */

				/*  test3 - 그냥 스크롤로 나옴...
				+ '	<div class=swipe> '
				for( var i in photos ) {
					html = html + " <img src=${pageContext.request.contextPath }"+photos[i] +"  style='width:100%; height: auto;'  >" 
				}
					
				html = html 
				+ '	</div>'
				 */

				// test 4 only css html
				/*
				+ '<div class="slider-holder"> '
				
				for( var i in photos ) {
				html = html + '<span id="slider-image-'+(++i)+'"></span>' 
				}
				
				
				html = html
				+ '   <div id="ih'+sliderCount+'" class="image-holder"> '
				
				for( var i in photos ) {
					html = html + '       <img src="${pageContext.request.contextPath }'+photos[i]+'" class="slider-image"  /> '
				}
				
				html = html
				+ '   </div> '
				+ '   <div class="button-holder"> '
				
				for( var i in photos ) {
					html = html +  '       <a href="#slider-image-'+(++i)+'" class="slider-change"  ></a> '
				}
				

				+ '   </div> '
				+ ' </div> '
				 */

				// test 5  link : https://stackoverflow.com/questions/41541559/multiple-slideshows-on-one-page-makes-the-first-one-not-work-anymore
				+ '   		<div class="w3-content w3-display-container slider" id="div'+sliderCount+'"  style="height:100%; width:100%"> '

		for ( var i in photos) {
			html = html
					+ '       <img src="${pageContext.request.contextPath }'	+ photos[i]		+ '" class="mySlides"  style="width:100%; height: 600px; border-radius: 20px; " onload="resizeimg(this)" /> '
		}

		html = html
				+ '   				<label class="slidermove" onclick="plusDivs(this,-1)" style="margin-left:320px;   background-color:#ffffff" > < 이전  </label> '
				+ '  	 			<label class="slidermove" onclick="plusDivs(this,1)"  style="margin-left:50px;    background-color:#ffffff" > 다음 >  </label> '
				//+ '  	 			<a class="w3-btn-floating w3-display-right" onclick="plusDivs(this,1)" style="width:390px; background-color:#ffffff" >&#10095;</a  '
				+ '   		</div>' 

				+ "	</div>"

				+ "<div id='post-info'  style='height:auto; width:780px; margin-left:10px;' >"
				+ "	  	<div id='info-status' >"
				// postIdx가 0이면 tour,  아니면 post 
				+ "			<div id='likebtn"+vo.idx+"' style='width: 120px; height: 27px; float:left'> "
		// 1 좋아요
		if (vo.favoCount == 0) {
			//좋아요
			html = html + 	"	<button id='btnFavo" + vo.idx + "' type='button' onclick='likeup(" + vo.idx + ", " + vo.tourIdx + ", " + vo.postIdx + ", "+ vo.favorite +")'> &#9825; </button> "
		} else {
			html = html + 	"	<button id='btnFavo" + vo.idx + "' type='button' onclick='likedown(" + vo.idx + ", " + vo.tourIdx + ", " + vo.postIdx+ ", "+ vo.favorite +")'> &#10084; </button> "
		}

		html = html + 		"	<label>좋아요  </label>"
					+ 		"	<label id='favoidx"+vo.idx+"' style='margin-left:10px'>  "+ vo.favorite +"</label> "
				+ "			</div>  " 
				+ "     	<div id='info-etc' style='margin-top:3px; height: 27px; float: left'>"
		//+ "<button id='btnFavo"+vo.idx+"' type='button' onclick='clicklike("+vo.idx+", "+vo.tourIdx+", "+vo.postIdx+")'> "+didFavo+" </button><br> "
				 + "			<label style='margin-left:40px;'> &#x2637; 여행일자 : " + vo.tripDateTime	+ "</label>"
		 		 + "			<label style='margin-left:40px;'>&#10030;평점 : "+ vo.score + "</label> " 
		 		 + "			<label style='margin-left:40px;'>&#x24; 비용 : " + vo.price	+  "</label>"
		 		 
		if (vo.postIdx == 0) {
			
			html = html +  " 	<label style='margin-left:40px;'>P포스트 수 : " + vo.postCount	+  "</label>"
		} 		 
		 		 
		 		 
		 		 html = html
		 		 + " 		</div> "
		 		 //+ "	<label>등록일자 : " + vo.postDateTime	+ "</label><br>" 
		 		 
		 		 + "		<div id='info-content' style='width:780px;' >"
				+ "				<label style='width:100%; height:100px; margin-top:10px;'> " + vo.content + " </label><br>"
				//+ "				<label>info : tourIdx : " + vo.tourIdx + ",  postIdx : "	+ vo.postIdx + ", voIdx : " + vo.idx + " </label>"
				+ "			</div>" 
				+ "		</div>" 
				+ "	</div>" 
				+ "	</div>" 
				+ "<br>"

		if (mode == true) {
			$("#list-sns").prepend(html).trigger("create");
		} else {
			$("#list-sns").append(html).trigger("create");

		}
		/* 
		slideshow = new TINY.slider.slide('slideshow',{
		id:'slider',
		auto:3,
		resume:true,
		vertical:false,
		navid:'pagination',
		activeclass:'current',
		position:0
		});	
		 */

		// reload_js('http://malsup.github.io/jquery.cycle2.js');
		createSliderObjects();

	}

	// snsvo 를 요청하는 곳 
	var fetchList = function() {
		if (isEnd == true) {
			return;
		}
		var startNo = $("#list-sns #post").last().data("idx") || 0;
		$
				.ajax({
					url : "/breezer/api/sns/list?idx=" + startNo
							+ "&userid=${userid }",
					type : "get",
					dataType : "json",
					data : "",
					success : function(response) {
						if (response.result != "success") {
							console.log(response.message);
							return;
						}

						// 끝 감지
						if (response.data.length < 5) {
							isEnd = true;
							$("#btn-next").prop("disabled", true);
						}

						$.each(response.data, function(index, vo) {
							render(vo, false);
						});
					}
				});
	}

	
	// 스크롤 시 fetchList를 요청(sns데이터요청)
	$(function() {
		$(window).scroll(function() {
			var $window = $(this);
			var scrollTop = $window.scrollTop();
			var windowHeight = $window.height();
			var documentHeight = $(document).height();

			//console.log( 
			//	scrollTop + ":" + 
			//	windowHeight + ":" + 
			//	documentHeight );
			// scollbar의 thumb가 바닥 전 30px 까지 도달 했을 때
			if (scrollTop + windowHeight + 30 > documentHeight) {
				fetchList();
			}
		});

		$("#btn-next").click(function() {
			fetchList();
		});

		fetchList();
	})
</script>


<body>
	

	<!-- header -->
	<div id="header"
		style="background-color: #ABABAB; width: 100%; top: 0px; position: fixed;  z-index:10 ">
		<c:import url="/WEB-INF/views/includes/header.jsp">
		</c:import>
	</div>


	<div id="container" style="background-color: #d6d4d4; height: 100%;  ">
		
		<!-- side_navi import -->
		<div id="side_navi" class="row content" style="margin-left: 10px; position: fixed; top: 100px; " align="center" >
			<c:import url="/WEB-INF/views/includes/side_navigation.jsp">
				<c:param name="menu" value="sns" />
			</c:import>
		</div>

		<!-- <div class="cycle-slideshow"   data-cycle-fx=scrollHorz    data-cycle-timeout=0    >
			   	<div class="cycle-pager"></div>
				
				<img src="/breezer/uploads/images/201801014027289.jpg">
				<img src="/breezer/uploads/images/201801013945770.png">
				
				
		</div> -->

		<div id="list-sns"	style="width: 780px; background-color: #d6d4d4;  margin: auto;">
			<br> <br> <br> <br> <br>



			<!-- 각각의 포스트  -->
			<!-- <div id="post" data-idx="123" style="width:780px; height: 400px; background-color:#ff5555; " >
				헤더부분 : 이미지, 닉네임, 위치
				<div id="post-header" style="height: 50px; width:780px; margin-top:10px; background-color: #ffff44;">
					사진
					<div id="header-picture" style="float: left;">
						<div id="image-test" style="height: 30px; width: 40px; background-color: #ff1234; margin: 10px;"></div>
					</div>
					닉네임, 위치
					<div id="header-info" style="float: left;">
						닉네임
						<div id="header-nickname">
							<label>nickName : </label>
						</div>
						위치
						<div id="header-location">
							<label>location : </label>
						</div>
					</div>
				</div>
				
				사진
				<div id="post-picture" style="height:400px; width:100%; background-color:#ccfaaa;">
				</div>
				
				포스트정보 : 내용 , 좋아요, 평점,수단,가격
				<div id="post-info">
					좋아요, 평점, 수단, 가격
					<div id="info-status" >
						<button type="button" > like </button><br>
						<label>좋아요 : </label><br>
						<label>평점 : </label><br>
						<label>가격 : </label><br>
						<label>등록일자 : </label><br>
						<label>여행일자 : </label><br>
					</div>
					내용
					<div id="info-content" >
						<label>내용 : </label>
					</div>
				</div>
				
				
			</div> -->
		</div>



		<form id="logout" name="logout" method="post"
			action="${pageContext.servletContext.contextPath }/user/logout">
			<button type="submit" class="join-button">logout</button>
		</form>

		<!-- footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>







