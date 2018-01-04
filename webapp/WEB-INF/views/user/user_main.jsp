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
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>
<style>

</style>

<script>

var startNo = 0;
var isEnd = false;
var authUser = "${authUser.id}";
var uservo = "${uservo2.id}"
//여기 바뀌어야 함. 
console.log(authUser);
console.log(uservo);

var userId;

if(authUser == uservo){
	userId = authUser;
} else {
	userId = uservo;
}

console.log(userId);




var render0 = function( tourvo, mode ){
	console.log(tourvo.idx);	
	//var id = "${authUser.id}";
	var id = userId;
	var html = 	"<div class='col-sm-4' id='tour' no='" + tourvo.idx  + "' align='center'>"+
				tourvo.title + "<br>" + tourvo.idx + "<br>" +
				"<a href='${pageContext.servletContext.contextPath }/" + id +"/tour?idx='" + tourvo.idx + "'>"+ 
				tourvo.mainPhoto + "</a><br>" +				
				tourvo.startDate + "</div>" ;
	//var no = $("#tour").attr('no');

	if( mode == true ){
		$( "#list-tour" ).prepend(html);		
	} else {		
		$( "#list-tour" ).append(html);	
	}
}

var fetchList = function(){
	if( isEnd == true){		
		return;
	}
		
	//var startNo = $("#list-tour > *").last().attr('no') || 0;
	// expr1을 true로 변환할 수 있으면 expr1을 반환하고, 그렇지 않으면 expr2를 반환합니다.
	console.log("startno is" + startNo);
	var id = userId;
	console.log("이 사람의 투어를 가져온다:"+id);
	$.ajax({
		url:"/breezer/"+ id +"/tourlist?no=" + startNo,
		type:"get",
		dataType:"json",
		data:"",
		success: function( response ){
			if( response.result != "success" ){
				console.log( response.message );
				return;				
			}
			// 끝감지
			if( response.data.length < 6){
				isEnd = true;
				$( "#btn-next" ).prop( "disabled", true );
			}
			// 강사님 코드에서는 버튼 클릭할 때 5개씩 가져오고 5개 미만이면 disabled
			$.each( response.data, function(index, tourvo){
				//console.log(index);				
				render0( tourvo, false );					
			}); //each
		} //success
	}); //ajax	
	
	startNo += 6;
	console.log(startNo);
} // fetchList




$(function(){
	// 1. 스크롤 함수 
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
  <div class="row content">
	<c:import url="/WEB-INF/views/includes/side_navigation.jsp">
		<c:param name="menu" value="login" />
	</c:import>

    <div class="col-sm-9">
		<div class="row" id="firstrow">
			<div class="col-sm-3" id="userprofile" align="center">
			
			<img src="${uservo2.pictureUrl}" 
				 width="150px" height="150px" class="img-circle">
			
			</div> 
			
			<div class="col-sm-6" id="firstrow" align="center">

			<h4>${uservo2.id }님은</h4><br>
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
			 
			<div style="text-align:center; padding-top:20px">
				더 많은 투어를 보려면 스크롤을 아래로
			</div>
						
			</div> <!-- sm-12 -->
		</div>
			
			<div class="row" align="center" id="thirdrow">
				
			</div><!-- third row -->
			
    </div>	<!-- col sm-9 -->
  </div>	<!-- row content -->    
</div>	<!-- container -->

<!-- <c:import url="/WEB-INF/views/includes/footer.jsp" />  -->  

</body>
</html>