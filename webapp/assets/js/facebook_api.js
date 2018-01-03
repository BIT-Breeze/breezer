var fb_userID
var fb_name
var fb_token
var fb_signedRequest
var fb_expiresIn
var fb_email
var fb_gender
var fb_age_range
var fb_locale
var fb_picture_url

var id;
//var checkId = false;


// init ?
window.fbAsyncInit = function() {
	FB.init({
		appId : '154137601867803',
		cookie : true, // enable cookies to allow the server to access
		// the session
		xfbml : true, // parse social plugins on this page
		version : 'v2.8' // use graph api version 2.8
	});

	// Now that we've initialized the JavaScript SDK, we call
	// FB.getLoginStatus(). This function gets the state of the
	// person visiting this page and can return one of three states to
	// the callback you provide. They can be:
	//
	// 1. Logged into your app ('connected')
	// 2. Logged into Facebook, but not your app ('not_authorized')
	// 3. Not logged into Facebook and can't tell if they are logged into
	// your app or not.
	//
	// These three cases are handled in the callback function.

};

// Load the SDK asynchronously
(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id))
		return;
	js = d.createElement(s);
	js.id = id;
	js.src = "https://connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

// This function is called when someone finishes with the Login
// Button. See the onlogin handler attached to it in the sample
// code below.
function checkLoginState() {
	console.log("===== checkLoginState =====")
	FB.getLoginStatus(function(response) {
		console.log("===== FB.getLoginStatus =====")
		statusChangeCallback(response);

		// 정보 변수에 담기
		var userInfo = response.authResponse
		fb_token = userInfo.accessToken
		fb_signedRequest = userInfo.signedRequest
		fb_expiresIn = userInfo.expiresIn
		fb_userID = userInfo.userID

	});
}

// This is called with the results from from FB.getLoginStatus().
function statusChangeCallback(response) {
	console.log('===== statusChangeCallback =====');
	console.log(response);
	// The response object is returned with a status field that lets the
	// app know the current login status of the person.
	// Full docs on the response object can be found in the documentation
	// for FB.getLoginStatus().
	if (response.status === 'connected') {
		// Logged into your app and Facebook.
		console.log("connected")
		getUserInfo();

	} else {
		// The person is not logged into your app or we are unable to tell.
		console.log("is not connected")
		// document.getElementById('status').innerHTML = 'Please log ' +
		// 'into this app.';
	}
}

// Here we run a very simple test of the Graph API after login is
// successful. See statusChangeCallback() for when this call is made.
function getUserInfo() {
	console.log("===== getUserInfo =====")
	FB.api('/me', {
		fields : 'name, email, gender, age_range, locale, picture'
	}, function(response) {
		console.log(response)

		// 추가 정보 셋팅
		fb_name = response.name
		fb_email = response.email
		fb_gender = response.gender
		fb_age_range = response.age_range.min
		fb_locale = response.locale
		fb_picture_url = response.picture.data.url

		// 정보 보기
		showUserInfo()

		// 로그인 시도
		login();
	});
}

function showUserInfo() {
	console.log("====== info ======")
	console.log("fb_userID = " + fb_userID)
	console.log("fb_name = " + fb_name)
	console.log("fb_token = " + fb_token)
	console.log("fb_signedRequest = " + fb_signedRequest)
	console.log("fb_expiresIn = " + fb_expiresIn)
	console.log("fb_email = " + fb_email)
	console.log("fb_gender = " + fb_gender)
	console.log("fb_age_range = " + fb_age_range)
	console.log("fb_locale = " + fb_locale)
	console.log("fb_picture_url = " + fb_picture_url)
}


function btnFunctionInit() {
	console.log("====== btn FunctionInit() ======")


	var checkId = false;
	
	var FormValidator = {
		$inputId : null,
		$message : null,
		$buttonSaveId : null,

		init : function() {
			this.$inputId = $("#input-id");
			this.$buttonSaveId = $("#btn-save");
			this.$message = $("#check-message"); 

			this.$inputId.each(this.onInputIdChanged.bind(this));
			this.$buttonSaveId.click(this.onButtonSaveIdClicked.bind(this));
		},
		// id 값 변경시 
		onInputIdChanged : function() {
			console.log("====== onInputIdChanged ======")
			var elem = this.$inputId;
		
			elem.data('oldVal', elem.val());
			elem.bind("propertychange change click keyup input paste", function(event){
				if(elem.data('oldVal') != elem.val()) {
					console.log("====== changed ID value ======")
					
					elem.data('oldVal', elem.val());
					checkId = false;
					
					//빈칸체크 
					var id = elem.val();
					if (id == "") {
						$("#check-message").html("ID는 4자 이상 20자 이하입니다.")
						return;
					}

					//id 유효성 체크 (많이해야되..특수문자체크도해야되...한글도..?)
					var elemLen = (elem.val()).length
					if (  (elemLen > 20) || (elemLen < 4) ) {
						$("#check-message").html("ID는 4자 이상 20자 이하입니다.")
						return;
					} 

					//ajax 통신
					$.ajax({
						url : "/breezer/api/user/checkid?id=" + id,
						type : "post",
						dataType : "json",
						data : "",
						success : function(response) {
							//성공이 아닐경우
							if (response.result != "success") {
								console.log(response.message);
								return;
							}

							// 이미 ID사용중
							if (response.data != true) {
								$("#check-message").html("이미 사용중인 ID입니다.")
								return;
							}
							
							// 사용가능한 ID
							$("#check-message").html("사용가능한 ID입니다.")
							console.log("id is not exist. you can use now (response = true)")
							checkId = true;
						},
						error : function(xhr, status, e) {
							console.error(status + ":" + e);
						}
					});
				}
			})
			
		},
		// 저장버튼 클릭시 
		onButtonSaveIdClicked : function() {
			console.log("====== onButtonSaveIdClicked ======")
			if ( checkId == true ) {
				// id 가 빈값일 경우 
				var id = this.$inputId.val();
				if (id == "") {
					alert("id를 입력하세요");
					return;
				}
				
				//ajax 통신
				$.ajax({
					url : "/breezer/api/user/setid" ,
					type : "post",
					dataType : "json",
					data : "id=" + id,
					success : function(response) {
						if (response.result != "success") {
							console.log("response.result = fail")
							return;
						}
						// 로그인 성공시 mytour 페이지로 이동한다
						// window.location.href = "/breezer/tour/mytour"
						window.location.href = "/breezer/" + response.data
					},
					error : function(xhr, status, e) {
						console.error(status + ":" + e);
					}
				});
			} else {
				// checkId 가 false 일 경우 
				alert("올바른 ID를 입력하세요.");
			}
		}
	}

	FormValidator.init();

}

// 로그인 성공 & ID가 저장되있지 않는 경우 아이디 입력창 생성 
function loginFormRender() {
	console.log("====== loginFormRender() ======")

	var html = ' <label class="block-label" for="id">ID</label> '
			+ '  <input class="input-id" id="input-id" name="id" type="text" value="" placeholder="아이디를 입력하세요"><br> '
			
			+ '  <label class="message-label" for="message" id="check-message"> id를 입력하세요 </label>'
			+ '  <input type="button" id="btn-save" class="btn btn-info" style="margin-left: 0px; width: 250px;" value="save id">';		

	
	$("#status").empty();
	$("#id-input").empty();
	$("#id-input").append(html);

	btnFunctionInit()
}


function login() {
	console.log("====== login ======")
	$.ajax({
		url : "/breezer/user/login",
		type : "post",
		dataType : "json",
		data : "fbId=" + fb_userID + "&nickName=" + fb_name + "&token="
				+ fb_token + "&signedRequest=" + fb_signedRequest
				+ "&expiresIn=" + fb_expiresIn + "&email=" + fb_email
				+ "&gender=" + fb_gender + "&ageRange=" + fb_age_range
				+ "&locale=" + fb_locale + "&pictureUrl=" + fb_picture_url,
		success : function(response) {
			if (response.result == "fail") {
				console.log("response.result = fail")
				if (response.message == "login-id-null") {
					console.log("response.message = login-id-null")
					loginFormRender();
				} else {
					console.log(response.message);
				}

				return;
			}

			console.log("response.result = success")
			console.log("response.data = " + response.data)

			// 로그인 성공시 mytour 페이지로 이동한다
			// window.location.href = "/breezer/tour/mytour"
			window.location.href = "/breezer/" + response.data

		},
		error : function(xhr, status, e) {
			console.error(status + ":" + e);
		}
	});
}