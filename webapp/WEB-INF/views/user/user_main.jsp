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

var render0 = function( tourvo, mode ){
	
	var id = "${authUser.id}";
	var html = 
				"<div class='col-sm-4' id='tour' no='" + tourvo.idx  + "'align='center'>"+
				tourvo.title + "<br>" +
				"<a href='${pageContext.servletContext.contextPath }/" + id +"/tour?idx='" + tourvo.idx + "'>"+ 
				tourvo.mainPhoto + "</a><br>" +				
				tourvo.startDate + "</div>" ;
	
	if( mode == true ){
		$( "#list-tour" ).prepend(html);
		
	} else {
		
		$( "#list-tour" ).append(html);
		// 여기서 투어를 15개만 보여준다
		// 버튼을 만들어서 클릭시 다음 15개를 보여준다
		
	}
}

var fetchList = function(){
	
	var startNo = $( "#list-tour div" ).last().data("no") || 0;
	//console.log(startNo);
	var id = "${authUser.id}";
	console.log(id);
	$.ajax({
		url:"/breezer/"+id+"/tourlist",
		type:"get",
		dataType:"json",
		data:"",
		success: function( response ){
			if( response.result != "success" ){
				console.log( response.message );
				return;
				
			}
			
			$.each( response.data, function(index, tourvo){
				console.log(index);
				
				render0( tourvo, false );
					
			}); //each
		} //success
	}); //ajax	
} // fetchList





fetchList();




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
			
			<img src="${pageContext.servletContext.contextPath }/assets/image/anna.jpg" 
				 width="150px" height="150px" class="img-circle">
			
			</div> 
			
			<div class="col-sm-6" id="firstrow" align="center">

			<h4>${uservo.nickName }님은</h4><br>
			${uservo.tours }개의 여행을 하셨습니다.<br>
			
			</div>
			
			<div class="col-sm-3" id="firstrow" align="right">
			
      			<a href="${pageContext.servletContext.contextPath }/${ authUser.id}/tour/add" class="btn btn-info" role="button">NEW TOUR</a>
			
			</div>
		
		</div>	<!-- 윗줄, 사진, 닉네임, 새 투어 -->
		
		<div class="row" align="center" id="secondrow">
		
			<div class="col-sm-12" id="tourframe">
			
			<div id="list-tour">
			
			</div>
						
			</div> <!-- sm-12 -->
			
			
			
			
			<div class="row" align="center" id="thirdrow">
				<ul class="pagination">
					<li><a href="#">«</a></li>
				    <li><a href="#">1</a></li>
				    <li><a href="#">2</a></li>
				    <li><a href="#">3</a></li>
				    <li><a href="#">4</a></li>
				    <li><a href="#">5</a></li>
				    <li><a href="#">6</a></li>
				    <li><a href="#">7</a></li>
				    <li><a href="#">8</a></li>
				    <li><a href="#">9</a></li>
				    <li><a href="#">10</a></li>
				    <li><a href="#">»</a></li>			
				</ul>
			
			</div><!-- third row -->
			
      </div> <!-- album -->      
    </div>	<!-- col sm-9 -->
  </div>	<!-- row content -->    
</div>	<!-- container -->

  <c:import url="/WEB-INF/views/includes/footer.jsp" />

</body>
</html>