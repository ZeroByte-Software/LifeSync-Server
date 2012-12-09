<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<body>
<script>
function confirming()
{
	var result = confirm("This may result in changes. Click 'OK' to proceed.");
	
	return result;
}
</script>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px;color: white">Edit Accounts</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="javascript: history.go(-1)">Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;color: white; border-color: white;">
			<form action="accChange/new" method="post" onsubmit="return confirming()">
			<b> EDIT USER ACCOUNT</b><br/><br/>
				<!--Email<sup>required</sup>: <input type="text" name="email"/><br/><br/>-->
				<!--Current Password*: <input type="password" name="password"/><br/><br/><br/>-->
				
				<table style= "color: white">
				<tr>
			      <td align="left">Password*:</td>
			      <td align="left"><input type="password" name="password"/></td>
			    </tr>
			    <tr>
			      <td align="left">First Name:</td>
			      <td align="left"><input type="text" name="changeFN"/></td>
			    </tr>
			    <tr>
			      <td align="left">Last Name:</td>
			      <td align="left"><input type="text" name="changeLN"/></td>
			    </tr>
			    <tr>
			      <td align="left">Email:</td>
			      <td align="left"><input type="text" name="changeEM"/></td>
			    </tr>
			    <tr>
			      <td align="left">New Password:</td>
			      <td align="left"><input type="password" name="changePW"/></td>
			    </tr>
			  </table>
			  				
				<b> * : Required</b><br/><br/>
				<pre><input type="submit" name="submit" value="Change!" style="background-color:#4ED1B7;border-color:#26272B"/><button type="button" onClick="location.href='/FBWebServer/userAcc'" style="background-color:#4ED1B7;border-color:#26272B">Back</button></pre>
			</form>
		</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>


