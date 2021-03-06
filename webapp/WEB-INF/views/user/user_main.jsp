<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="${pageContext.servletContext.contextPath }/assets/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${pageContext.servletContext.contextPath }/assets/css/user/user_main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- w3 css -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
	body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}

    .row.content {
    	height: 100%;
    	flex-direction:row;
    	display:flex;
    }

    #th_buttons{    
		padding-right:15px;
    }

    #bottom-text {     
      color: black;  
      height: 50px; 
	  background-color: #F1F1F1;
    }

    #firstrow {
      padding: 30px; 
      padding-bottom: 30px;
      margin-top: 80px;
      background-color: #F1F1F1;    
    }
    
    #secondrow {     
      color: black;
      padding: 15px;    
      height: 750px; 
	  padding-bottom: 20px;
	  margin-top: 20px;
	  background-color: #F1F1F1;
    }
    
    #footer p {
      color:#F7F7F7;
      text-align:center;   
    }
    

    
    .checked {
    	color: orange;
	}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/bootstrap.js"></script>

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

	var html = 
	"<div class='col-sm-3' id='tour' no='" + tourvo.idx + "'>" +
		"<div class='thumbnail'>" +
			"<span id='showdelete' data-toggle='modal' data-target='#myModal' data-no='" + tourvo.idx + "' class='glyphicon glyphicon-remove' style='color:red; cursor:pointer; margin-left:95%;'></span>" +
			"<a href='${pageContext.servletContext.contextPath }/" + id + "/tour?idx=" + tourvo.idx + "'>" +
			"<img src='${pageContext.servletContext.contextPath }/" + tourvo.mainPhoto + "'style='width: 100%; height: 160px'>" + "</a><br>" +
			
			"<div class='caption'>" + 
			
				"<div class='row'>" + 
					"<p class='col-sm-12' align='center'><a href='${pageContext.servletContext.contextPath }/" + id + "/tour?idx=" + tourvo.idx + "'>" + tourvo.title + "</a></p>" +
				"</div>" +	
				
				"<div class='w3-row'>" +
					"<div class='w3-container'>" + 
						"<p><i class='fa fa-calendar' aria-hidden='true'></i> " + tourvo.startDate + " ~ " + tourvo.endDate + "</p>" +
					"</div>" +
				"</div>" + 
				
				"<div class='w3-row' >" +
					"<div class='w3-container w3-half'>" + 
						"<p><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> " + tourvo.favorite + "</p>" +
					"</div>" +
					
					"<div class='w3-container w3-half'>" + 
						"<p><i class='fa fa-list-ul' aria-hidden='true'></i> " + tourvo.postCount + "</p>" +
					"</div>" +
				"</div>" + 
				
				"<p style='margin-left:12px;'>";
				
				for (var i = 0; i < 5; i++) {
					if (i < Math.round(tourvo.score)) {
						html += "<i class='fa fa-star checked' aria-hidden='true'></i>";
					} else{
						html += "<i class='fa fa-star' aria-hidden='true'></i>";
					}
				}
	if(tourvo.secret == 0){
		console.log(tourvo.secret)	
		html += "</p>"+
		
				"<div class='w3-container'>" + 
	
					"<p class='w3-right'><i class='fa fa-unlock' aria-hidden='true'></i></p>" +
	
				"</div>" +
				
				"</div>"+ // caption
					"</div>"+ // 썹네일
				"</div>"; // col-sm-3
	}else{
		console.log(tourvo.secret)	
		html += "</p>"+
	
		"<div class='w3-container'>" + 

			"<p class='w3-right'><i class='fa fa-lock' aria-hidden='true'></i></p>" +

		"</div>" +
		
		"</div>"+ // caption
			"</div>"+ // 썹네일
		"</div>"; // col-sm-3		
	}
			

	if( mode == true ){
		$( "#list-tour" ).prepend(html);		
	} else {		
		$( "#list-tour" ).append(html);	
	}
}
	
var render2 = function( tourvo, mode ){
		//타인 페이지에서 투어를 그려주는 렌더링 함수, 삭제 버튼, 공개여부가 없음 	
		var id = userId;
		
		var html = 
			"<div class='col-sm-3' id='tour' no='" + tourvo.idx + "'>" +
				"<div class='thumbnail'>" +
					"<a href='${pageContext.servletContext.contextPath }/" + id + "/tour?idx=" + tourvo.idx + "'>" +
					"<img src='${pageContext.servletContext.contextPath }/" + tourvo.mainPhoto + "'style='width: 100%; height: 160px'>" + "</a><br>" +
					
					"<div class='caption'>" + 
					
						"<div class='row'>" + 
							"<p class='col-sm-12' align='center'>" + tourvo.title + "</p>" +
						"</div>" +	
						
						"<div class='w3-row'>" +
							"<div class='w3-container w3-threequarter'>" + 
								"<p><i class='fa fa-calendar' aria-hidden='true'></i> " + tourvo.startDate + " ~ " + tourvo.endDate + "</p>" +
							"</div>" +
							
							"<div class='w3-container w3-quarter'>" + 
							"</div>" +
						"</div>" + 
						
						"<div class='w3-row'>" +
							"<div class='w3-container w3-half'>" + 
								"<p><i class='fa fa-thumbs-o-up' aria-hidden='true'></i> " + tourvo.favorite + "</p>" +
							"</div>" +
							
							"<div class='w3-container w3-half'>" + 
								"<p><i class='fa fa-list-ul' aria-hidden='true'></i> " + tourvo.postCount + "</p>" +
							"</div>" +
						"</div>" + 
						
						"<p style='margin-left:12px;'>";
						
						for (var i = 0; i < 5; i++) {
							if (i < Math.round(tourvo.score)) {
								html += "<i class='fa fa-star checked' aria-hidden='true'></i>";
							} else{
								html += "<i class='fa fa-star' aria-hidden='true'></i>";
							}
						}
						
		html += "</p>"+
						"</div>"+ // caption
					"</div>"+ // 썹네일
				"</div>" // col-sm-3
				;

		if( mode == true ){
			$( "#list-tour" ).prepend(html);		
		} else {		
			$( "#list-tour" ).append(html);	
		}
}

var renderNoTour = function(){
	str = "<h4>투어가 없습니다!!!</h4>"
	$("#bottom-text h4").html(str);

	isEnd = true;
}

var getCount = function(){
	
	console.log("========getCount========");
	console.log(uservo);
	$.ajax({
		url:"/breezer/"+ userId + "/count",
		type:"get",
		data:"",
		
		success: function( response ){
			if( response.result != "success" ){
				console.log( response.message );
				return;		
			}
			console.log(response.data+" getCount 함수에서 가져온  투어 수");
			$("#counting").html("<h4> 지금까지 총 " + response.data + "곳을 여행 하셨습니다.  <i class='fa fa-plane w3-text-blue' aria-hidden='true'></i></h4> ");
			if(userId == authUser){
				$("#tourlist").html("<h4>투어수 : " + response.data + "</h4>")
				
			}
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
						$("#bottom-text").html("더 이상 투어가 없습니다.");
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
	$( document ).on( "click", "#showdelete", function(){
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

<title>Breezer</title>
</head>

<body>
<div class="container-fluid">

    <div class="row" id="container">
	  	<div class="col-sm-12" style= "z-index: 100; background-color: #ABABAB; width: 100%;">	  	
		  	<c:import url="/WEB-INF/views/includes/header.jsp">		
			</c:import>		
		</div>				
  	</div>

  	<div class="row content" style="background-color: #F1F1F1;">

	<c:import url="/WEB-INF/views/includes/side_navigation.jsp">
		<c:param name="menu" value="login" />
	</c:import>
				
    <div class="col-sm-8">
		<div class="row" id="firstrow" style="postion:relative;">
			<div class="col-sm-3" id="userprofile" align="center">
				<img src="${ uservo2.pictureUrl}" width="240px" height="240px" class="img-circle">
			</div> 
			
			<div class="col-sm-6" align="center" style="margin-top: 20px;">
				<h2>환영합니다~ ${uservo2.nickName }님!</h2>
				<br><br><br><br>
				<div id="counting"></div>
			</div>
			
			<div class="col-sm-3" align="right">
				<c:if test="${authUser.id == uservo2.id}">
					<a href="${pageContext.servletContext.contextPath }/${ authUser.id }/tour/add" class="btn btn-info" role="button" id="btn-next">새 투어</a>				
				</c:if>
				
				<%-- <c:choose>
					<c:when test="${authUser.id == uservo2.id}">
	      				<a href="${pageContext.servletContext.contextPath }/${ authUser.id }/tour/add" class="btn btn-info" role="button" id="btn-next">새 투어</a>
	      			</c:when>
	      			
	      			<c:otherwise>
	      				
	      			</c:otherwise>
				</c:choose> --%>
			</div>
		
		</div>	<!-- 윗줄, 사진, 닉네임, 새 투어 -->
		
		<hr>
		
		<div class="row"  id="secondrow">			
			<div class="col-sm-12">			
			<div id="list-tour">
			</div>						
			<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
			<div class='row'>				
				<div class="col-sm-10" id="bottom-text" style="text-align:center; padding-top:20px">
					<h4>투어를 더 보려면 아래로 스크롤 하세요!! </h4>

					<!--  <a href="#header"> 맨 위로 </a> -->
				</div>
				<div class="col-sm-2" align='right'>
					<a href="#firstrow">
						<button type="button" class="btn btn-default btn-lg btn-primary">						
							<span class='glyphicon glyphicon-chevron-up' id=to_top> </span>							
						</button>
					</a>
				</div>			
			</div> <!-- sm-12 -->

			</div>	
		</div>						
    </div>	<!-- col sm-8 -->
    <!--  -->
    <div class="col-sm-2" style="background-color: #F1F1F1;">
    </div>
    
  </div>	<!-- row content --> 
  
</div>	<!-- container -->
  <div class='row' style="background-color: #383838;">
  	<c:import url="/WEB-INF/views/includes/footer.jsp" />  
  </div> 

</body>
</html>