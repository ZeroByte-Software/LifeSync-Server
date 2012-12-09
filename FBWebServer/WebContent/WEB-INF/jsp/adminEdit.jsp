<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<body>

<script>
function confirming()
{
	/*var regForm = document.forms["adminEdit/new"];
	var error_msg = "The form has the following errors:";
	var isValid = true;
	if(regForm["changeEM"].value != null) {
		if(regForm["changeEM"].value.indexOf("@") < 0 && regForm["changeEM"].value.indexOf(".") < 0) {
			// email does not contain @ or !
			// we can make this more fancy later
			error_msg = error_msg + "\n- E-mail is not properly formatted";
			isValid = false;
		}
	}
	if(!isValid) {
		alert(error_msg);
	}
	
	if(!isValid)
		return isValid;*/
	
	var result = confirm("This may result in changes. Click 'OK' to proceed.");
	
	if(!result)
		return result;
}


</script>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px;color:white">Administration</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/adminPage" />" >Admin Page</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;color: white; border-color: white;">
			<form action="adminEdit/new" method="post" onsubmit="return confirming()" >
			<b> EDIT USER ACCOUNT</b><br/><br/>
				<!--Email<sup>required</sup>: <input type="text" name="email"/><br/><br/>-->
				<!--Current Password*: <input type="password" name="password"/><br/><br/><br/>-->
				
				<table style= "color: white">
				<tr>
			      <td align="right">User ID:</td>
			      <td align="left"><input value="${appUserID}" type="hidden" type="text" name="changeID"/></td>
			    </tr>
			    <tr>
			      <td align="right">First Name:</td>
			      <td align="left"><input value="${appUserFN}" type="text" name="changeFN"/></td>
			    </tr>
			    <tr>
			      <td align="right">Last Name:</td>
			      <td align="left"><input value="${appUserLN}" type="text" name="changeLN"/></td>
			    </tr>
			    <tr>
			      <td align="right">Email:</td>
			      <td align="left"><input value="${appUserEmail}" type="text" name="changeEM"/></td>
			    </tr>
			    <tr>
			      <td align="right">New Password:</td>
			      <td align="left"><input value="${appUserPW}" type="password" name="changePW"/></td>
			    </tr>
			    <tr>
			      <td align="right">Change Role:</td>
			      <td align="left"><input type="radio" name="changeRole" value="ROLE_USER" checked>Normal User<input type="radio" name="changeRole" value="ROLE_ADMIN">Admin</td>
			    </tr>
			  </table>
			  			
				<pre><input type="submit" name="submit" value="Change!"  style="background-color:#4ED1B7;border-color:#26272B"/><button type="button" onClick="location.href='/FBWebServer/adminPage'" style="background-color:#4ED1B7;border-color:#26272B">Back</button></pre>
			</form>
		</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>


