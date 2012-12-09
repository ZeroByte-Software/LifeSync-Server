<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<style>
body {color:#4ED1B7;background-color:#26272B;}
</style>
<script type="text/javascript">

function validateForm() {
	var regForm = document.forms["register_form"];
	var error_msg = "The form has the following errors:";
	var isValid = true;
	
	if(regForm["email"].value == null || regForm["email"].value == "" ) {
		// empty email
		error_msg = error_msg + "\n- E-mail is empty";
		isValid = false;
	}
	if(regForm["password"].value == null || regForm["password"].value == "" ) {
		// empty password
		error_msg = error_msg + "\n- Password is empty";
		isValid = false;
	}
	if(regForm["firstname"].value == null || regForm["firstname"].value == "" ) {
		// empty first name
		error_msg = error_msg + "\n- First Name is empty";
		isValid = false;
	}
	if(regForm["lastname"].value == null || regForm["lastname"].value == "" ) {
		// empty last name
		error_msg = error_msg + "\n- Last Name is empty";
		isValid = false;
	}
	if(regForm["email"].value != null) {
		if(regForm["email"].value.indexOf("@") < 0 && regForm["email"].value.indexOf(".") < 0) {
			// email does not contain @ or !
			// we can make this more fancy later
			error_msg = error_msg + "\n- E-mail is not properly formatted";
		}
	}
	if(regForm["password"].value != null && regForm["password2"].value != null) {
		if(regForm["password"].value != regForm["password2"].value) {
			// passwords do not match
			error_msg = error_msg + "\n- Passwords do not match";
			isValid = false;
		}		
	}

	if(!isValid) {
		alert(error_msg);
	}
	
	return isValid;
}

</script>
<title>LifeSync | Register</title>
</head>
	<body>
		<div style="margin:auto;width:629px;height:555px;background-image:url('http://i17.photobucket.com/albums/b70/Sakari-star/loginpagecopy2.png');">
			<form name="register_form" action="register/new" method="post" onsubmit="return validateForm()">
			<div style="text-align:center;padding-top:100px;">
			<b>REGISTER</b>
			<br/><small>all fields are required</small>
			<br/>
			<table style="border:0px;padding-left:175px;">
				<tr>
					<td style="text-align:right;">E-mail Address:</td>
					<td><input type="text" name="email"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">Password:</td>
					<td><input type="password" name="password"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">Re-enter Password:</td>
					<td><input type="password" name="password2"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">First Name:</td>
					<td><input type="text" name="firstname"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">Last Name:</td>
					<td><input type="text" name="lastname"/></td>
				</tr>
				<tr>
					<td colspan=2 style="text-align:center;"><input type="submit" name="submit" value="Register!" style="background-color:#4ED1B7;border-color:#26272B"/>&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" onClick="location.href='/FBWebServer/'" style="background-color:#4ED1B7;border-color:#26272B">Back</button></td>
				</tr>
			</table>
<!-- 				E-mail Address: <input type="text" name="email"/><br/><br/> -->
<!-- 				Password: <input type="text" name="password"/><br/><br/> -->
<!-- 				First Name: <input type="text" name="firstname"/><br/><br/> -->
<!-- 				Last Name: <input type="text" name="lastname"/><br/><br/> -->
<!-- 				<pre><input type="submit" name="submit" value="Register!" style="background-color:#4ED1B7;border-color:#26272B"/>	<button type="button" onClick="location.href='/FBWebServer/'" style="background-color:#4ED1B7;border-color:#26272B">Back</button></pre> -->
			</div>
			</form>
		</div>
	</body>
</html>