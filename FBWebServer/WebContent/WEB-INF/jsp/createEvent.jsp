<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<link REL=StyleSheet HREF="<c:url value="/resources/style.css" />" TYPE="text/css">
</head>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px">Create Event</h1></div>

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
	<form:form method = "POST" action="/FBWebServer/schedules/schedule/events/event/create" commandName = "newEvent" style="text-align:center;padding-top:100px;">
			<table>
			<tr><td>Name:</td><td><form:input type="text" path="name"/></td><td></td></tr>
			<tr><td colspan="3"><c:if test = "${nameError != null}">${nameError}</c:if ></td><td></td></tr>
			<tr><td>Start Time:</td><td><form:select path="start_day"><option value="1">SUNDAY</option><option value="2">MONDAY</option><option value="3">TUESDAY</option><option value="4">WEDNESDAY</option><option value="5">THURSDAY</option><option value="6">FRIDAY</option><option value="7">SATURDAY</option></form:select> --- <form:select path="start_hour" id="startHour" value="hh"><c:forEach var="i" begin="0" end="23"><option value="<c:out value="${i}" />"><c:out value="${i}" /></option></c:forEach></form:select> : <form:select path="start_minute" id="startMinute" value="mm"><option value="00">00</option><option value="30">30</option></form:select></td></tr>
			<tr><td colspan="3"><c:if test = "${startTimeError != null}">${startTimeError}</c:if ></td></tr>
			<tr><td>End Time:</td><td><form:select path="end_day"><option value="1">SUNDAY</option><option value="2">MONDAY</option><option value="3">TUESDAY</option><option value="4">WEDNESDAY</option><option value="5">THURSDAY</option><option value="6">FRIDAY</option><option value="7">SATURDAY</option></form:select> --- <form:select path="end_hour" id="endHour" value="hh"><c:forEach var="i" begin="0" end="23"><option value="<c:out value="${i}" />"><c:out value="${i}" /></option></c:forEach></form:select> : <form:select path="end_minute" id="endMinute" value="mm"><option value="00">00</option><option value="30">30</option></form:select></td></tr>
			<tr><td colspan="3"><c:if test = "${endTimeError != null}">${endTimeError}</c:if ></td></tr>
			<tr><td>Location:</td><td><form:input type="text" path="location"/></td></tr>
			<tr><td colspan="3"><c:if test = "${locationError != null}">${locationError}</c:if ></td></tr>
			<tr><td>Description:</td><td><form:input type="text" path="description"/></td></tr>
			<tr><td colspan="3"><c:if test = "${descriptionError != null}">${descriptionError}</c:if ></td></tr>
			<tr><td colspan="3"><form:input type="hidden" path="schedule_id" value="${scheduleID}"/></td></tr>
			<tr><td colspan="3"><input type="submit" id="button" name="submit" value="Create"/></td></tr>
			</table>
	</form:form>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>


