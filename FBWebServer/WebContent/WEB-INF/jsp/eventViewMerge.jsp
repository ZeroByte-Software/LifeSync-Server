<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<link REL=StyleSheet HREF="<c:url value="/resources/style.css" />" TYPE="text/css">
</head>
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

<div id="content" style="background-color:#26272B;height:500px;float:top;">
			Name: ${origEvent.name} <br/>
			Start Time: 
			<c:if test = "${origEvent.start_day == 1}">SUNDAY</c:if>
			<c:if test = "${origEvent.start_day == 2}">MONDAY</c:if>
			<c:if test = "${origEvent.start_day == 3}">TUESDAY</c:if>
			<c:if test = "${origEvent.start_day == 4}">WEDNESDAY</c:if>
			<c:if test = "${origEvent.start_day == 5}">THURSDAY</c:if>
			<c:if test = "${origEvent.start_day == 6}">FRIDAY</c:if>
			<c:if test = "${origEvent.start_day == 7}">SATURDAY</c:if>---${origEvent.start_hour}:${origEvent.start_minute}
			<br/>
			End Time:  
			<c:if test = "${origEvent.end_day == 1}">SUNDAY</c:if>
			<c:if test = "${origEvent.end_day == 2}">MONDAY</c:if>
			<c:if test = "${origEvent.end_day == 3}">TUESDAY</c:if>
			<c:if test = "${origEvent.end_day == 4}">WEDNESDAY</c:if>
			<c:if test = "${origEvent.end_day == 5}">THURSDAY</c:if>
			<c:if test = "${origEvent.end_day == 6}">FRIDAY</c:if>
			<c:if test = "${origEvent.end_day == 7}">SATURDAY</c:if>---${origEvent.end_hour}:${origEvent.end_minute}
			<br/>
			Location: ${origEvent.location} <br/> 
			Description: ${origEvent.description} <br/>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>