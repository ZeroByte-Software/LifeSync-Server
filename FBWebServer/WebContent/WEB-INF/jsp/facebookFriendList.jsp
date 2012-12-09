<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<body>
<div id="fb-root"></div>
<script>
  // Additional JS functions here
  
  var fbid = "0";
  
  window.fbAsyncInit = function() {
    FB.init({
      appId      : 114550068695482, // App ID
      channelUrl : 'http://54.245.83.84:8080/channel.html', // Channel File
      status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });

    // Additional init code here
    FB.getLoginStatus(function(response) {
    	  if (response.status === 'connected') {
    		  console.log("connected to facebook!");
    		  document.getElementById("fbwelcome").innerHTML = 
    			  "Connected to Facebook!";
    		  fbWelcome();
    		  findFriends();
    	    // connected
    	  } else if (response.status === 'not_authorized') {
    		  document.getElementById("fbwelcome").innerHTML = 
    			  "Connected to Facebook but you have not authorized the application";
    	    // not_authorized
    	  } else {
    		  document.getElementById("fbwelcome").innerHTML = 
    			  "Not connected to Facebook.";
    	    // not_logged_in
    	  }
    	 });

  };
  function login() {
	    FB.login(function(response) {
	        if (response.authResponse) {
	        	// connected
	            document.getElementById("fbwelcome").innerHTML = "Connected to Facebook!";
	            fbWelcome();
	        } else {
	            // cancelled
	            console.log("user cancelled login or did not authorize");
	        }
	    });
	}
  function fbWelcome() {
	    console.log('Welcome!  Fetching your information.... ');
	    FB.api('/me', function(response) {
	    	
	    	var xmlhttp = new XMLHttpRequest();
        	xmlhttp.open("GET","/FBWebServer/friendList/facebookFriendList/update_fbid?fb_id="+response.id,true);
    	  	xmlhttp.send();
    	  	
	        console.log('Good to see you, ' + response.name + '.  Your ID is ' + response.id);
	        document.getElementById("fblogininfo").innerHTML = 
	        	"Connected as:<br/><img src='http://graph.facebook.com/"+response.id+"/picture' />&nbsp;&nbsp;"+response.name;
	    });
	}

  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
  
  
  	function findFriends() {
  		// bainin id: 532759806
  		// ian id: 1669500110
  		var friends = new Array();
  		FB.api("me/friends?fields=id,name,installed", function(response) {
  			// find friends that use this app
  			for(var i=0;i<response.data.length;i++) {
  				if(response.data[i].installed) {
  					friends.push(response.data[i]);
  				}
  			}
  			
  			var container = document.getElementById("findFriends");
  			var friendForm = document.createElement("form");
  			friendForm.setAttribute("action", "facebookFriendList/friendAdd");
  			friendForm.setAttribute("method", "post");
  			
  			
  			var friendTable = document.createElement("table");
  			console.log("generating friend table");
  			for(var i=0;i<friends.length;i++) {
  				console.log(friends[i]);
  				var friendRow = document.createElement("tr");
  				friendRow.innerHTML = 
  					"<td><input type='checkbox' name='friends' value='" + friends[i].id + "' /></td>" +
  					"<td><img src='https://graph.facebook.com/" + friends[i].id + "/picture' />" +
  					" " + friends[i].name + "</td>";
 				friendTable.appendChild(friendRow);
  			}
  			var friendSubmit = document.createElement("input");
  			friendSubmit.type = "submit";
  			friendSubmit.value = "Add Friends";
  			
  			friendForm.appendChild(friendTable);
  			friendForm.appendChild(friendSubmit);
  			
  			if(container.firstChild != null) {
  				container.innerHTML = "";
  			}
  			
  			container.appendChild(friendForm);
  		});
  	}
  	
  	
</script>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px">Friend List</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="<c:url value="/friendList/friendAdd" />" >Add Friends</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;color: white; border-color: white;">

			
			<br/>
			<b> Facebook Friends!</b><br/><br/>
			<div id="fbwelcome"></div>
			<div id="fblogininfo"></div>
				<input type="submit" value="log in with facebook!" onclick="login()" />
				<input type="button" value="show friends!" onclick="findFriends()" />
				<div id="findFriends"></div>
		</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>


