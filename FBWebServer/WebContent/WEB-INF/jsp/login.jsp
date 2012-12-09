<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<style>
body {color:#4ED1B7;background-color:#26272B;}
</style>
<script type="text/javascript">

function validateLoginForm() {
	var regForm = document.forms["f"];
	var error_msg = "The Login form has the following errors:";
	var isValid = true;
	
	if(regForm["j_username"].value == null || regForm["j_username"].value == "" ) {
		// empty email
		error_msg = error_msg + "\n- E-mail is empty";
		isValid = false;
	}
	if(regForm["j_password"].value == null || regForm["j_password"].value == "" ) {
		// empty password
		error_msg = error_msg + "\n- Password is empty";
		isValid = false;
	}
	if(regForm["j_username"].value != null) {
		if(regForm["j_username"].value.indexOf("@") < 0 && regForm["j_username"].value.indexOf(".") < 0) {
			// email does not contain @ or !
			// we can make this more fancy later
			error_msg = error_msg + "\n- E-mail is not properly formatted";
			isValid = false;
		}
	}

	if(!isValid) {
		alert(error_msg);
	}
	
	return isValid;
}

</script>
<title>LifeSync | Login</title>
</head>
	<body onload='document.f.j_username.focus();'>
	
	<div style="margin:auto;width:629px;height:555px;background-image:url('http://i17.photobucket.com/albums/b70/Sakari-star/loginpagecopy.png');">
		
	<c:if test="${not empty error}">
		<div class="errorblock">
			Your login attempt was not successful, try again.<br /> 
		</div>
	</c:if>
 
	<form name='f' action="<c:url value='j_spring_security_check' />" method='POST' onsubmit="return validateLoginForm()" style="text-align:center;padding-top:225px;padding-left:200px;">
		<table>
			<tr>
				<td>Email:</td>
				<td><input type='text' name='j_username' value=''>
				</td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type='password' name='j_password' />
				</td>
			</tr>
			<tr>
				<td colspan='2'><pre><input name="submit" type="submit"
					value="Submit" style="background-color:#4ED1B7;border-color:#26272B" />		<button type="button" onClick="location.href='register'" style="background-color:#4ED1B7;border-color:#26272B">Register</button></pre>
				</td>
			</tr>
		</table>
	</form>
	</div>	
	</body>
</html>