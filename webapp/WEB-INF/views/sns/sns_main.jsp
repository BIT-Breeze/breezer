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


<!-- css -->

<link	href="${pageContext.servletContext.contextPath }/assets/css/login.css"	rel="stylesheet" type="text/css">
<!-- bootstrap -->
<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.min.css"	rel="stylesheet" type="text/css">
<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"	rel="stylesheet" type="text/css">

<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script> --%>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.min.js"></script>


<meta name="viewport" content="width=device-width, initial-scale=1">

</head>


<script>
var isEnd = false;

var render = function( vo, mode ) {
	var html = 
		"<div id='post' data-idx='"+vo.idx+"' style='width:780px; height: 700px; background-color:#ff5555; ' >" +
			"<div id='post-header' style='height: 50px; width:780px; margin-top:10px; background-color: #ffff44;'> " +
				"<div id='header-picture' style='float: left;'>" +
					"<div id='mage-test' style='height: 30px; width: 40px; background-color: #ff1234; margin: 10px;'></div> " +
				"</div>" +
				"<div id='header-info' style='float: left;'>" +
					"<div id='header-nickname'>" +
						"<label>nickName : "+vo.userId+"</label> " +
					"</div>"+
					"<div id='header-location'>" +
						"<label>location : </label>"+
					"</div>"+
				"</div>"+
			"</div>"+
			
			"<div id='post-picture' style='height:400px; width:100%; background-color:#ccfaaa;'> 이미지" +
			"</div>" +
			
			"<div id='post-info'>"+
				"<div id='info-status' >"+
					"<button type='button' > like </button><br> "+
					"<label>좋아요 : </label><br> "+
					"<label>평점 : </label><br> "+
					"<label>가격 : </label><br>"+
					"<label>등록일자 : </label><br>"+
					"<label>여행일자 : </label><br>"+
				"</div>"+
				"<div id='info-content' >"+
					"<label>내용 : tourIdx : "+vo.tourIdx+", postIdx : "+vo.postIdx+" </label><br>"+
					"<label>content : "+vo.content+", voIdx : "+vo.idx+" </label>"+
				"</div>"+
			"</div>"+
		"</div>"
	
	if( mode == true ) {
		$( "#list-sns" ).prepend( html );
	} else {
		$( "#list-sns" ).append( html );
		
	}
}


var fetchList = function(){
	if( isEnd == true ) {
		return;
	}
	var startNo = $( "#list-sns #post" ).last().data("idx") || 0;
	$.ajax({
		url: "/breezer/api/sns/list?idx=" + startNo,
		type: "get",
		dataType: "json",
		data:"",
		success: function( response ) {
			if( response.result != "success" ) {
				console.log( response.message );
				return;
			}
			
			// 끝 감지
			if( response.data.length < 5){
				isEnd = true;
				$( "#btn-next" ).prop( "disabled", true );
			}
			
			
			$.each( response.data, function(index, vo){
				
				render( vo, false );
			});
		}
	});
}

$(function(){
	$( window ).scroll( function(){
		var $window = $(this);
		var scrollTop = $window.scrollTop();
		var windowHeight = $window.height();
		var documentHeight = $( document ).height();
		
		//console.log( 
		//	scrollTop + ":" + 
		//	windowHeight + ":" + 
		//	documentHeight );
		// scollbar의 thumb가 바닥 전 30px 까지 도달 했을 때
		if( scrollTop + windowHeight + 30 > documentHeight ) {
			fetchList();
		}
	});
	
	$("#btn-next").click( function(){
		fetchList();
	});
	
	fetchList();
})

	
</script>

<body>
	

	<div id="container">
		sns
		<div id="list-sns" style=" width:800px; background-color: #ffffcc; margin: auto;">
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
		
		
		
		<form id="logout"  name="logout" method="post" action="${pageContext.servletContext.contextPath }/user/logout">	
			<button type="submit" class="join-button"> logout</button>
		</form>
		
		<!-- footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp" /> 
	</div>
</body>
</html>







