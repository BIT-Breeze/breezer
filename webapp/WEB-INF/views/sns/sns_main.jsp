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

<link
	href="${pageContext.servletContext.contextPath }/assets/css/sns/sns_main.css"
	rel="stylesheet" type="text/css">
<!-- bootstrap -->
<link
	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"
	rel="stylesheet" type="text/css">

<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script> --%>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.min.js"></script>
	
	
	

<script type="text/javascript"  src="http://malsup.github.io/jquery.cycle2.js"></script>







<meta name="viewport" content="width=device-width, initial-scale=1">

</head>


<script type="text/javascript">

</script>

<script>
	function reload_js(src) {
	    $('script[src="' + src + '"]').remove();
	    $('<script>').attr('src', src).appendTo('head');
	}
	

		

	
	
	



	var isEnd = false;
	var sliderCount = 0
	
	var slideshow 
	
	
	
	
	
	
	
	var render = function(vo, mode) {
		sliderCount+= 1;
		
		if (sliderCount > 1 ) {
			//return;
		}
		
		var photo = vo.photo;
		var photos = photo.split(',');
		for( var i in photos ) {
			//console.log(i +" : " + photos[i])
		}
		
		var html = "<div id='post' data-idx='"+vo.idx+"' style='width:780px; height: auto; background-color:#ff5555; ' >"
				+ "		<div id='post-header' style='height: 50px; width:780px; margin-top:10px; background-color: #ffff44;'> "
				+ "			<div id='header-picture' style='float: left;'>"
				+ "				<div id='image-test' style='height: 30px; width: 40px; background-color: #ff1234; margin: 10px;'><img src = '"+vo.pictureUrl+"'  > </div> "
				+ "			</div>"
				+ "			<div id='header-info' style='float: left;'>"
				+ "				<div id='header-nickname'>"
				+ "					<label>nickName : <a href='${pageContext.servletContext.contextPath }/"+vo.userId+"'>" + vo.userId
				+ "					</a></label> "
				+ "				</div>"
				+ "				<div id='header-location'>"
				+ "					<label>location : "+ vo.location
				+ " 				</label>"
				+ "				</div>"
				+ "			</div>"
				+ "		</div>"
				

				
				
				+ "		<div id='post-picture' style='height:800px; width:100%; background-color:#ccfaaa;'> 이미지"
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
				
				 
				 
				 
				 
				+ "		</div>"
				
				+ "<div id='post-info'  style='height:auto; width:100%;' >"
				+ "<div id='info-status' >"
				+ "<button type='button' > like </button><br> "
				+ "<label>좋아요 : "
				+ vo.like
				+ "</label><br> "
				+ "<label>평점 : "
				+ vo.score
				+ "</label><br> "
				+ "<label>가격 : "
				+ vo.price
				+ "</label><br>"
				+ "<label>등록일자 : "
				+ vo.postDateTime
				+ "</label><br>"
				+ "<label>여행일자 : "
				+ vo.tripDateTime
				+ "</label><br>"
				+ "</div>"
				+ "<div id='info-content' >"
				+ "<label>내용 : "
				+ vo.content
				+ " </label><br>"
				+ "<label>info : tourIdx : "
				+ vo.tourIdx
				+ ",  postIdx : "
				+ vo.postIdx
				+ ", voIdx : "
				+ vo.idx
				+ " </label>"
				
				+ "</div>" + "</div>"

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
				
				reload_js('http://malsup.github.io/jquery.cycle2.js');
				
				
				
	}

	var fetchList = function() {
		if (isEnd == true) {
			return;
		}
		var startNo = $("#list-sns #post").last().data("idx") || 0;
		$.ajax({
			url : "/breezer/api/sns/list?idx=" + startNo,
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
<!-- side_navi css를 위해 임시로 가져옴 -> 기본적으로 navi.jsp 에 임포트 되있어야 할듯 -->
<link
	href="${pageContext.servletContext.contextPath }/assets/css/user/user_main.css"
	rel="stylesheet" type="text/css">

<body>
	<!-- side_navi import -->
	<div id="side_navi">
		<c:import url="/WEB-INF/views/includes/side_navigation.jsp">
			<c:param name="menu" value="sns" />
		</c:import>
	</div>

	<!-- header -->
	<div id="header">
		<c:import url="/WEB-INF/views/includes/header.jsp">
		</c:import>
	</div>

	<div id="container">
		sns
		<!-- <div class="cycle-slideshow"   data-cycle-fx=scrollHorz    data-cycle-timeout=0    >
			   	<div class="cycle-pager"></div>
				
				<img src="/breezer/uploads/images/201801014027289.jpg">
				<img src="/breezer/uploads/images/201801013945770.png">
				
				
		</div> -->
		
		<div id="list-sns"
			style="width: 800px; background-color: #ffffcc; margin: auto;">
			
			
			
			
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







