<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px">My Schedules</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;color:white;">
				<b>Congratulations</b><br/><br/>
				Account change was successful.<br/><br/>
				<button type="button" onClick="location.href='/FBWebServer/adminPage'" style="background-color:#4ED1B7;border-color:#26272B">Back</button>
			</div>


<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>