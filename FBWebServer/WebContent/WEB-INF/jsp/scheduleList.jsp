<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px; color:white">My Schedules</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="<c:url value="/schedules/schedule/create" />" >Create Schedule</a><br/>
<a href="javascript: history.go(-1)">Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;">
	<table> 
        <colgroup span=6 style=background-color:rgb(204,255,204)>
        <thead style=background-color:rgb(204,230,255)>
        	<tr><td><b>Active</b></td>
			<td><b>Schedule Id</b></td>
			<td><b>Remove</b></td></tr>   
		</thead>
		<c:forEach items="${schedules}" var="schedule">
			<tr>
				<c:if test = "${schedule.active == '1'}">
					<td>Active</td>
				</c:if>
				<c:if test = "${schedule.active != '1'}">
					<td><a href="/FBWebServer/schedules/schedule/setActive?scheduleID=${schedule.schedule_id}">Set To Active</a></td>
				</c:if>
				<td style="text-align:center"><a href="/FBWebServer/schedules/schedule/view?scheduleID=${schedule.schedule_id}"> ${schedule.schedule_id}</a></td>
				<td style="text-align:center"><a href="/FBWebServer/schedules/schedule/delete?scheduleID=${schedule.schedule_id}" onclick="return confirmDelete()">delete</a></td>
			</tr>
		</c:forEach>
	</table>
</div>
<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>

<script type="text/javascript">
function confirmDelete()
{
	var result = confirm("Are you sure you want to delete this schedule?");
	
	return result;
}
</script>