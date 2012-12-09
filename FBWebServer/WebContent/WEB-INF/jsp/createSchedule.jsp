<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<a href="javascript: history.go(-1)">Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;color:white;">
	<form:form method = "POST" action="/FBWebServer/schedules/schedule/create" commandName = "newSchedule" style="text-align:center;padding-top:100px;" onsubmit="return confirming()">
			<b>Create Schedule</b><br/><br/>
			<pre><input type="submit" name="submit" value="Create" style="background-color:#4ED1B7;border-color:#26272B"/>	</pre>
	</form:form>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>

<script type="text/javascript">
function confirming()
{	
	var result = confirm("Are you sure you want to create a schedule?");
	
	if(!result)
		return result;
}
</script>

