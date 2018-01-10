<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link	href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css"	rel="stylesheet" type="text/css">
<link	href="${pageContext.servletContext.contextPath }/assets/css/user/user_main.css"	rel="stylesheet" type="text/css">
<link	href="${pageContext.servletContext.contextPath }/assets/css/includes/basic.css"	rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<style>

</style>

<script>

var startNo = 0;
var isEnd = false;
var authUser = "${authUser.id}";
var uservo = "${uservo2.id}";
var userId;
console.log(authUser);
console.log(uservo);

if(authUser == uservo){
	userId = authUser;
} else {
	userId = uservo;
}
console.log(userId);

var messageBox = function(title, message, callback){
	$( "#dialog-message" ).attr( "title", title);
	// 클래스의 특정 속성에 값을 준다. 두번째 인자가 없으면 값을 가져온다.
	// attr() 은 속성과 관련된 작업을 한다. 
	/* 보통 세 가지 형태로 사용한다. 
	1. attr(name, value)
	2. attr(name, function(index, attr{}))
	3. attr(object)
	
	*/
	$( "#dialog-message p" ).text( message );
	$( "#dialog-message" ).dialog({
		modal:true,
		buttons:{
			"확인" : function(){
				$(this).dialog("close");
			}
	
		},
		close: callback || function(){}
	});
}





var render0 = function( tourvo, mode ){
	console.log(tourvo.idx);	
	//var id = "${authUser.id}";
	var id = userId;
	var html = 	"<div class='col-sm-4' id='tour' no='" + tourvo.idx  +   "' align='center'>"+
				tourvo.title + "<br>" + 
				"<a href='${pageContext.servletContext.contextPath }/" + id +"/tourdelete?idx=" + tourvo.idx + 
				"'> <button type='button' class='btn btn-danger' data-toggle='modal' data-target='#myModal'> 삭제 </button> </a><br>" +
				"<a href='${pageContext.servletContext.contextPath }/" + id +"/tour?idx=" + tourvo.idx + "'>"+ 						
				"<img src='${pageContext.servletContext.contextPath }/" + tourvo.mainPhoto + "' width='330px' height='160px'>"
				 + "</a><br>" +				
				"투어시작일:" + tourvo.startDate + " ~ 투어종료일: " + tourvo.endDate + "</div>" ;
	//var no = $("#tour").attr('no');

	if( mode == true ){
		$( "#list-tour" ).prepend(html);		
	} else {		
		$( "#list-tour" ).append(html);	
	}
	//render2();
}

var renderNoTour = function(){
	str = "<h4>투어가 없습니다!!!</h4>"
	$("#bottom-text").html(str);
	// .text() 로 하면 태그를 인식 못함. 
	isEnd = true;
}
/*
var render2 = function(){
	var html = 	"<div class='col-sm-12' style='text-align:center; padding-top:20px'>" +
		"더 많은 투어들을 보려면 스크롤을 아래로!" +
		"</div>";
	$( "#tour" ).last().append(html);	
}
*/

var fetchList = function(){
	if( isEnd == true){		
		return;
	}
		
	//var startNo = $("#list-tour > *").last().attr('no') || 0;
	// expr1을 true로 변환할 수 있으면 expr1을 반환하고, 그렇지 않으면 expr2를 반환합니다.
	console.log("startno is" + startNo);
	var id = userId;

	$.ajax({
		url:"/breezer/"+ id +"/tourlist?no=" + startNo,
		type:"get",
		dataType:"json",
		data:"",
		success: function( response ){
			if( response.result != "success" ){
				console.log( response.message );
				renderNoTour();
				return;				
			}

			if( response.data.length < 6){
				// JavaScript 배열에는 length라는 속성이 있다.
				// response.data는 배열로 인식된다
				isEnd = true;
				//$( "#btn-next" ).prop( "disabled", true );
			}

			$.each( response.data, function(index, tourvo){
	
				render0( tourvo, false );
				//render2();
			}); //each
		} //success
	}); //ajax	
	
	startNo += 6;
	console.log(startNo);
} // fetchList



$(function(){
	var deleteDialog = $("#dialog-delete-form").dialog({
		autoOpen: false,
		modal: true,
		buttons: {
			"삭제": function(){

				console.log( "삭제:  no "  );
				
				//ajax 통신
				$.ajax({
					url: "/mysite3/" + userId + "/deleteTour",
					type: "post",
					dataType: "json",
					data: "no=" + no,
					success: function( response ) {
						if( response.result == "fail" ) {
							console.log( response.message );
							return;
						}
						
						if( response.data == -1 ) {
							$( ".validateTips.normal" ).hide();
							$( ".validateTips.error" ).show();
							$( "#password-delete" ).val( "" );
							return;
						}
						
						$( "#list-guestbook li[data-no=" + response.data + "]" ).remove();
						deleteDialog.dialog( "close" );
					},
					error: function( xhr, status, e){
						console.error( status + ":" + e );
					}
				});

			},
			"취소": function(){
				$(this).dialog("close");
			}
		},
		close: function(){
			$("#password-delete").val( "" );
			$("#hidden-no").val( "" );
		}
	});
	
	
	
	
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
	// 2. 버튼 클릭할 때 패치
	$("#btn-next").click( function(){
		fetchList();
	});
	// 3. 최초 패치 
	fetchList();
	//$('#tour').css('color','red');
	//selector 작동 안 함. 
})

</script>

<title>Breezer Main</title>

</head>


<body>

<div class="container-fluid">
  
  
  	<div class="row" id="container">
	  	<div class="col-sm-12">
		  	<c:import url="/WEB-INF/views/includes/header.jsp">
		
			</c:import>
		</div>
  	</div>
  	
  	<div class="row content">
  
	<c:import url="/WEB-INF/views/includes/side_navigation.jsp">
		<c:param name="menu" value="login" />
	</c:import>

    <div class="col-sm-9">
		<div class="row" id="firstrow">
			<div class="col-sm-3" id="userprofile" align="center">
			
			<img src="${ uservo2.pictureUrl}" 
				 width="150px" height="150px" class="img-circle">
			
			</div> 
			
			<div class="col-sm-6" id="firstrow" align="center">

			<h4>${uservo2.nickName }님은</h4><br>
			${uservo2.tours }개의 여행을 하셨습니다.<br>
			
			</div>
			
			<div class="col-sm-3" id="firstrow" align="right">
			<c:choose>
				<c:when test="${authUser.id == uservo2.id}">
      			<a href="${pageContext.servletContext.contextPath }/${ authUser.id }/tour/add" class="btn btn-info" role="button" id="btn-next">새 투어</a>
      			</c:when>
      			
      			<c:otherwise>
      				
      			</c:otherwise>
			</c:choose>
			</div>
		
		</div>	<!-- 윗줄, 사진, 닉네임, 새 투어 -->
		
		<div class="row" align="center" id="secondrow">
			
			<div class="col-sm-12">
			
			<div id="list-tour">

			</div>
			
			<div id="dialog-delete-form" title="tour delete" style="display:none">
			<p class="validateTips normal"> 정말로 삭제하시겠습니까? </p>
			
			</div>
			
			<div id="dialog-message" title="" style="display:none">
  				<p></p>
			</div>
			
			
			<div class="col-sm-12" id="bottom-text" style="text-align:center; padding-top:20px">
				<h4>투어를 더 보려면 아래로 스크롤 하세요!!</h4>
			</div>



			</div> <!-- sm-12 -->
		</div>
			
			
    </div>	<!-- col sm-9 -->
  </div>	<!-- row content -->    
</div>	<!-- container -->

<!-- <c:import url="/WEB-INF/views/includes/footer.jsp" />  -->  

</body>
</html>