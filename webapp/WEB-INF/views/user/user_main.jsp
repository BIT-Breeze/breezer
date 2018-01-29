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
<link   rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>

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

var render0 = function( tourvo, mode ){
	// 자기 투어를 그려주는 렌더링 함수
	var id = userId;
	console.log(tourvo)	
	
	var html = "<div class='col-sm-3' id='tour' no='" + tourvo.idx + "'>" + 
					"<div class='panel panel-info'>" + 
						"<div class='panel-heading'>" + "<div class='row'>" + 
							"<div class='col-sm-10'><h5>" + tourvo.title + "</h5></div>" +
							"<div class='col-sm-2'>" + 
								"<button class='btn btn-danger' data-toggle='modal' data-target='#myModal' data-no='" + tourvo.idx + "'>x</button></div>" + 
								"</div> start: " + tourvo.startDate + " ~ end: " + tourvo.endDate + 
								"<br>좋아요: " + tourvo.favorite + " &nbsp포스트: " + tourvo.postCount + " &nbsp공개여부: " + 
								tourvo.secret  + " 평점: " + tourvo.score +"</div>" +
						"<div class='panel-body' align='left'>" +				
							"<a href='${pageContext.servletContext.contextPath }/" + id + "/tour?idx=" + tourvo.idx + "'>" +
							"<img src='${pageContext.servletContext.contextPath }/" + tourvo.mainPhoto + "' width='270px' height='180px'></a><br>" +
					"</div>"+
				"</div>"
	/*	다른 썸네일 형식으로 렌더링 하기 
		var html = 
	*/
	
	if( mode == true ){
		$( "#list-tour" ).prepend(html);		
	} else {		
		$( "#list-tour" ).append(html);	
	}
}
	
var render2 = function( tourvo, mode ){
		//타인 페이지에서 투어를 그려주는 렌더링 함수, 삭제 버튼, 공개여부가 없음 	
		var id = userId;
		console.log(id)
		console.log(tourvo.idx)
		
		var html = "<div class='col-sm-3' id='tour' no='" + tourvo.idx + "'>" + 
						"<div class='panel panel-info'>" + 
							"<div class='panel-heading'>" + 
								"<h5>" + tourvo.title + "</h5>" +								
								"start: " + tourvo.startDate + " ~ end: " + tourvo.endDate + 
								"<br>좋아요: " + tourvo.favorite + " &nbsp포스트: " + tourvo.postCount + " &nbsp평점: " + tourvo.score + "</div>" + 
							"<div class='panel-body' align='left'>" +				
								"<a href='${pageContext.servletContext.contextPath }/" + id + "/tour?idx=" + tourvo.idx + "'>" +
								"<img src='${pageContext.servletContext.contextPath }/" + tourvo.mainPhoto + "' width='270px' height='180px'></a><br>" +
						"</div>"+
					"</div>"

		if( mode == true ){
			$( "#list-tour" ).prepend(html);		
		} else {		
			$( "#list-tour" ).append(html);	
		}
}

var renderNoTour = function(){
	str = "<h4>투어가 없습니다!!!</h4>"
	$("#bottom-text").html(str);

	isEnd = true;
}

var getCount = function(){
	
	console.log("========getCount========");
	console.log(uservo);
	$.ajax({
		url:"/breezer/"+ uservo + "/count",
		type:"get",
		data:"",
		
		success: function( response ){
			if( response.result != "success" ){
				console.log( response.message );
				return;		
			}
			console.log(response.data+" getCount 함수에서 가져온  투어 수");
			$("#counting").text(response.data + "개의 여행을 하셨습니다.");
		} // success
	}) //ajax
	
}

var fetchList = function(){
	if( isEnd == true){		
		return;
	}
		
	console.log("startno is" + startNo);

			$.ajax({
				url:"/breezer/"+ userId +"/tourlist?no=" + startNo,
				type:"get",
				dataType:"json",
				data:"",
				//response data
				success: function( response ){
					if( response.result != "success" ){
						console.log( response.message );
						renderNoTour();
						return;				
					}
		
					if( response.data.length < 8){

						isEnd = true;
					}
		
					$.each( response.data, function(index, tourvo){
						if(userId == authUser){
							render0( tourvo, false );
						
						//자기 투어 가져오는 렌더링 함수, 
						} else {
							render2( tourvo, false );
						//다른사람 투어 가져오는 렌더링 함수, 삭제버튼이 없음 
						}
					}); //each
					

				} //success
			}); //ajax			
	
	startNo += 8;
	console.log(startNo + "투어리스트 가져오는 요청 보낼때  Request param 넘버");
	} // fetchList


$(function(){
	fetchList();
	getCount();
	$( document ).on( "click", "#list-tour div button", function(){
			//event.preventDefault();	
		 	//$('#myModal').modal("show");	

		 	$('#myModal').modal({
		 			keyboard: true			
		 	});
		 		
		 	var no = $(this).attr("data-no");

		 	$( '#delete-no' ).val( no );
		 	//$('#myModal').modal("show");	
		 	});	// 이벤트를 하나씩 연결?? 
			
			
	// 확인 버튼 누르면 ajax 통신으로 글 삭제하는 이벤트 
	$( document ).on("click", "#deleteConfirm" ,function(){		
		//$('#myModal').modal("hide");
		//event.preventDefault();
		var no = $( '#delete-no' ).val();
		
 		if(userId == authUser){
 			$.ajax({
 				url:"/breezer/" + userId + "/tourdelete?idx=" + no,
 				type: "get",
 				dataType: 'json',
 				success: function( response ){
 					if( response.result == "fail" ) {
						console.log( response.message );
 						return;		
 					}
 					if( response.data == -1 ) {
						console.log("response.data == -1");
						return;
 					}

 				    	$( "#list-tour div[no=" + response.data + "]" ).remove();
 						$('#myModal').modal("hide");
 						getCount();
 						fetchList();
 						console.log("삭제 성공!! 새로운 카운팅!!")
 						//$("#myModal .close").click()
 				},
				error: function( xhr, status, e){
					 		console.error( status + ":" + e );
		 				}						
 			});// ajax 
 	 		//$('#myModal').attr('aria-hidden','true');

 		} else {
 			$('.modal-body').html("다른사람의 투어는 삭제할 수 없습니다."); 			
 		}	
		});
		
	$( window ).scroll( function(){
		var $window = $(this);
		var scrollTop = $window.scrollTop();
		var windowHeight = $window.height();
		var documentHeight = $( document ).height();
		
		if( scrollTop + windowHeight + 30 > documentHeight ) {
			fetchList();
		}
	}); // window scroll


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

    <div class="col-sm-8">
		<div class="row" id="firstrow">
			<div class="col-sm-3" id="userprofile" align="center">
			
			<img src="${ uservo2.pictureUrl}" 
				 width="150px" height="150px" class="img-circle">
			
			</div> 
			
			<div class="col-sm-6" id="firstrow" align="center">

			<h4>${uservo2.nickName }님은</h4>
			<h4 id="counting"></h4>

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
		
		<div class="row"  id="secondrow">			
			<div class="col-sm-12">			
			<div id="list-tour">
			</div>						
			<div class="modal" id="myModal" tabindex="-1" role="dialog" 
	   			 aria-labelledby="myModalLabel" aria-hidden="true">
					   <div class="modal-dialog">
					      <div class="modal-content">
					         <div class="modal-header">
					            <button type="button" class="close" data-dismiss="modal" 
					               aria-hidden="true">×
					            </button>
					            <h4 class="modal-title" id="myModalLabel">
					               		해당 투어를 삭제하시겠습니까?
					            </h4>
					         </div>
					         <div class="modal-body">
					            	확인 버튼을 누르세요			        	
					         <form>
					         	<input type="hidden" id="delete-no" name="voNo" value=""/>					         
					         </form>
					         
					         </div>
					         <div class="modal-footer">
					            <button type="button" class="btn btn-default" 
					               data-dismiss="modal">취소
					            </button>
					            <!-- 이 버튼에 속성을 줘서 클릭시 날아가게끔? -->
					            <button type="button" class="btn btn-primary" id="deleteConfirm">
					               	확인
					            </button>
					         </div>
					      </div><!-- /.modal-content -->
					   </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->					
			<div class="col-sm-12" id="bottom-text" style="text-align:center; padding-top:20px">
				<h4>투어를 더 보려면 아래로 스크롤 하세요!! </h4>
				<!--  <a href="#header"> 맨 위로 </a> -->
			</div>			
			</div> <!-- sm-12 -->
		</div>						
    </div>	<!-- col sm-8 -->
    <div class="col-sm-2">
    </div>
    
  </div>	<!-- row content -->    
</div>	<!-- container -->

<!-- <c:import url="/WEB-INF/views/includes/footer.jsp" />  -->  

</body>
</html>