<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px">My Schedules</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/schedules/schedule/events/import" />" >Import Events</a><br/>
<a href="<c:url value="/schedules/schedule/events/add" />" >Add Event</a><br/>
<a href="<c:url value="/schedules/schedule/events/edit" />" >Remove Event</a><br/>
<a href="<c:url value="/schedules/schedule/events/remove" />" >Remove Event</a><br/>
<a href="<c:url value="/schedules/schedule/delete" />" >Delete Schedule</a><br/><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="javascript: history.go(-1)">Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;">
	<table style="border-collapse: collapse;color: white; border-color: white; table-layout: 500px; border:1"> 
		<tr><th style="text-align:center;border:1px solid white;padding:5px;">Schedule Id</th><th style="text-align:center;border:1px solid white;padding:5px;">Schedule Name</th><th style="text-align:center;border:1px solid white;padding:5px;">Creation Date</th><th style="text-align:center;border:1px solid white;padding:5px;">Last Modified</th></tr>
		<c:forEach items="${schedules}" var="schedule">
			<tr><td style="text-align:center;border:1px solid white;padding:5px;"><a href="FBWebServer/schedules/view?scheduleID=${schedule.schedule_id}">${schedule.schedule_id}</a></td><td style="text-align:center;border:1px solid white;padding:5px;"></td><td style="text-align:center;border:1px solid white;padding:5px;"></td><td style="text-align:center;border:1px solid white;padding:5px;"></td></tr>
		</c:forEach>
	</table>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>


