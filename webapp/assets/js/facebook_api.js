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

	/*
	 * $("btn-check").on( "click", function(){ idCheck();} )
	 * $("btn-save").on("click", function(){ idSave()} )
	 */
	var checkId = false;
	var FormValidator = {
		$inputId : null,
		$buttonCheckId : null,
		$buttonSaveId : null,

		init : function() {
			this.$inputId = $("#input-id");
			this.$buttonCheckId = $("#btn-check");
			this.$buttonSaveId = $("#btn-save");

			this.$inputId.change(this.onInputIdChanged.bind(this));
			this.$buttonCheckId.click(this.onButtonCheckIdClicked.bind(this));
			this.$buttonSaveId.click(this.onButtonSaveIdClicked.bind(this));
			
			//$("#id-input").submit(this.onInputIdFormSubmit.bind(this));
		},
		onInputIdChanged : function() {
			console.log("====== onInputIdChanged ======")
			checkId = false;
		},
		onButtonCheckIdClicked : function() {
			console.log("====== onButtonCheckIdClicked ======")

			var id = this.$inputId.val();
			if (id == "") {
				alert("id를 입력하세요");
				return;
			}

			console.log("id is not empty")



			//ajax 통신
			$.ajax({
				url : "/breezer/api/user/checkid?id=" + id,
				type : "post",
				dataType : "json",
				data : "",
				success : this.onCheckIdAjaxSuccess.bind(this),
				error : this.onCheckIdAjaxError
			});
		},
		onCheckIdAjaxSuccess : function(response) {
			if (response.result != "success") {
				console.log(response.message);
				return;
			}

			if (response.data != true) {
				alert("이미 사용하고 있는 Id입니다.");
				this.$inputId.val("").focus();
				return;
			}
			console.log("id is not exist. you can use now (response = true)")
			checkId = true;
		},
		onCheckIdAjaxError : function(xhr, status, e) {
			console.error(status + ":" + e);
		},
		onButtonSaveIdClicked : function() {
			console.log("====== onButtonSaveIdClicked ======")
			if ( checkId == true ) {
				console.log("checkId is true")
				
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
				
			} else {
				alert("Id 중복체크 하세요.");
			}
		}

	}

	FormValidator.init();

}

function loginFormRender() {
	console.log("====== loginFormRender() ======")

	var html = ' <label class="block-label" for="id">ID</label> '
			+ '  <input class="input-id" id="input-id" name="id" type="text" value=""><br> '
			+ '  <input type="button" id="btn-check" class="btn btn-info" style="margin-left: 25x; width: 250px;" value="check id"> <br> '
			+ '  <input type="button" id="btn-save" class="btn btn-info" style="margin-left: 0px; width: 250px;" value="save id">';		
			
			
			
			/*+ ' <button id="btn-check" style="margin-left: 25x; width: 250px;">checkid</button> <br> '
			+ ' <button type="submit" id="btn-save" style="margin-left: 0px; width: 250px;">save</button>';*/

	
	
	
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