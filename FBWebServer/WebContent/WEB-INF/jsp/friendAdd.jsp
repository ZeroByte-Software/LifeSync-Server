<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px;color: white">Add Friends</h1></div>

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
			<form action="friendAdd/new" method="get">
			<b> Add Friend</b><br/><br/>
				<!--Email<sup>required</sup>: <input type="text" name="email"/><br/><br/>-->
				<!--Current Password*: <input type="password" name="password"/><br/><br/><br/>-->
				
				<table style= "color: white">
				<tr>
			      <td align="right">Friend's Email:</td>
			      <td align="left"><input type="text" name="addFriendEM"/></td>
			    </tr>
			  </table>
				<pre><input type="submit" name="submit" value="Submit" style="background-color:#4ED1B7;border-color:#26272B"/><button type="button" onClick="location.href='/FBWebServer/friendList'" style="background-color:#4ED1B7;border-color:#26272B">Back</button></pre>
			</form>
		</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>
