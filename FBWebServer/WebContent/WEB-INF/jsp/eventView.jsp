<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px">My Schedules</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/schedules/schedule/view?scheduleID=${scheduleID}"/>">Back</a><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="javascript: history.go(-1)">Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;">
	<form:form method = "POST" action="/FBWebServer/schedules/schedule/events/event/edit" commandName = "editEvent" style="text-align:center;padding-top:100px;" onsubmit="return confirming()">
			<table>
			<tr><td>Name:</td><td><form:input type="text" path="name" value="${origEvent.name}"/></td><td></td></tr>
			<tr><td>Start Time:</td><td>
			<form:select path="start_day" value="${origEvent.start_day}">
			<c:if test = "${origEvent.start_day == 1}">
				<option selected value="1" selected>SUNDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day != 1}">
				<option value="1">SUNDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day == 2}">
				<option selected value="2">MONDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day != 2}">
				<option value="2">MONDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day == 3}">
				<option selected value="3">TUESDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day != 3}">
				<option value="3">TUESDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day == 4}">
				<option selected value="4">WEDNESDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day != 4}">
				<option value="4">WEDNESDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day == 5}">
				<option selected value="5">THURSDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day != 5}">
				<option value="5">THURSDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day == 6}">
				<option selected value="6">FRIDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day != 6}">
				<option value="6">FRIDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day == 7}">
				<option selected value="7">SATURDAY</option>
			</c:if>
			<c:if test = "${origEvent.start_day != 7}">
				<option value="7">SATURDAY</option>
			</c:if>
			</form:select> --- 
			<form:select path="start_hour" id="startHour" value="${origEvent.start_hour}">
			<c:forEach var="i" begin="0" end="23">
				<c:if test = "${origEvent.start_hour == i}">
				<option selected value="<c:out value="${i}" />"><c:out value="${i}" /></option>
				</c:if>
				<c:if test = "${origEvent.start_hour != i}">
				<option value="<c:out value="${i}" />"><c:out value="${i}" /></option>
				</c:if>
			</c:forEach>
			</form:select> : 
			<form:select path="start_minute" id="startMinute" value="${origEvent.start_minute}">
				<c:if test = "${origEvent.start_minute == 0}">
					<option selected value="00">00</option>
				</c:if>
				<c:if test = "${origEvent.start_minute != 0}">
					<option value="00">00</option>
				</c:if>
				<c:if test = "${origEvent.start_minute == 30}">
					<option selected value="30">30</option>
				</c:if>
				<c:if test = "${origEvent.start_minute != 30}">
					<option value="30">30</option>
				</c:if>
			</form:select></td></tr>
			<tr><td>End Time:</td><td>
			<form:select path="end_day" value="${origEvent.end_day}">
				<c:if test = "${origEvent.end_day == 1}">
					<option selected value="1" selected>SUNDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day != 1}">
					<option value="1">SUNDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day == 2}">
					<option selected value="2">MONDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day != 2}">
					<option value="2">MONDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day == 3}">
					<option selected value="3">TUESDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day != 3}">
					<option value="3">TUESDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day == 4}">
					<option selected value="4">WEDNESDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day != 4}">
					<option value="4">WEDNESDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day == 5}">
					<option selected value="5">THURSDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day != 5}">
					<option value="5">THURSDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day == 6}">
					<option selected value="6">FRIDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day != 6}">
					<option value="6">FRIDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day == 7}">
					<option selected value="7">SATURDAY</option>
				</c:if>
				<c:if test = "${origEvent.end_day != 7}">
					<option value="7">SATURDAY</option>
				</c:if>			
			</form:select> --- 
			<form:select path="end_hour" id="endHour" value="${origEvent.end_hour}">
			<c:forEach var="i" begin="0" end="23">
				<c:if test = "${origEvent.end_hour == i}">
					<option selected value="<c:out value="${i}" />"><c:out value="${i}" /></option>
				</c:if>
				<c:if test = "${origEvent.end_hour != i}">
					<option value="<c:out value="${i}" />"><c:out value="${i}" /></option>
				</c:if>			
			</c:forEach>
			</form:select> : 
			<form:select path="end_minute" id="endMinute" value="${origEvent.end_minute}">
				<c:if test = "${origEvent.end_minute == 0}">
					<option selected value="00">00</option>
				</c:if>
				<c:if test = "${origEvent.end_minute != 0}">
					<option value="00">00</option>
				</c:if>
				<c:if test = "${origEvent.end_minute == 30}">
					<option selected value="30">30</option>
				</c:if>
				<c:if test = "${origEvent.end_minute != 30}">
					<option value="30">30</option>
				</c:if>
			</form:select></td></tr>
			<tr><td>Location:</td><td><form:input type="text" path="location" value="${origEvent.location}"/></td></tr>
			<tr><td>Description:</td><td><form:input type="text" path="description" value="${origEvent.description}"/></td></tr>
			<tr><td colspan="3"><form:input type="hidden" path="schedule_id" value="${scheduleID}"/></td></tr>
			<tr><td colspan="3"><form:input type="hidden" path="event_id" value="${origEvent.event_id}"/></td></tr>
			<tr><td colspan="3"><input type="submit" id="button" name="submit" value="Make Changes"/>	<a href="/FBWebServer/schedules/schedule/events/event/delete?eventID=${origEvent.event_id}" onclick="return confirmDelete()">Delete Event</a></td></tr>
			</table>
	</form:form>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>

<script type="text/javascript">
function confirming()
{	
	var result = confirm("Are you sure you want to edit the event?");
	
	if(!result)
		return result;
}

function confirmDelete()
{
	var result = confirm("Are you sure you want to delete this event?");
	
	return result;
}
</script>