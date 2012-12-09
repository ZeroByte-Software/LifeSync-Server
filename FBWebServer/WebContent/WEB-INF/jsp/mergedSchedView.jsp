<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<!--<a href="javascript: history.go(-1)">Back</a><br/>-->
<a href="<c:url value="/schedules/schedule/view?scheduleID=${scheduleID}" />" >Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/><br/><br/>

<c:if test = "${fn:length(friends) > 0}">
	Friends Available To Merge:
	<form action="/FBWebServer/schedules/schedule/merge" method="get">
		<c:forEach items="${friends}" var="friend">
			<input type="checkbox" name="friendToMerge" value="${friend.user_id}"/>${friend.first_name} ${friend.last_name}<br/>
		</c:forEach>
		<input type="hidden" name="scheduleID" value ="<%=request.getParameter("scheduleID") %>"/><br/>
		<input type="submit" name="submit" value="Merge" style="background-color:#4ED1B7;border-color:#26272B"/><br/><br/>
	</form>
</c:if >

Legend:<br/>
<img src="<c:url value="/resources/myColor.png" />"/>My Events <br/>
<img src="<c:url value="/resources/friendColor.png" />"/>Friend's Events <br/>
<img src="<c:url value="/resources/overLapColor.png" />"/>Overlapping Events <br/>
</div>

<div id="content" style="color: black; background-color:#26272B;height:500px;float:top;">
<table  cellspacing="0" cellpadding ="9" width ="100%">

<colgroup span=8 style=background-color:white >

</colgroup>
<thead style=background-color:blue>

<tr style = "color:white">
  <th>Timeslot/Day:</th>
  <td><b>Sunday</b></td>
  <td><b>Monday</b></td>
  <td><b>Tuesday</b></td>
  <td><b>Wednesday</b></td>
  <td><b>Thursday</b></td>
  <td><b>Friday</b></td>
  <td><b>Saturday</b></td>
</tr>
</thead>
<c:forEach var ="j" begin="0" end="47">
<c:if test = "${j%2!=0}">
	<tr style=background-color:rgb(204,230,255)>
</c:if>
<c:if test ="${j%2==0 }">
	<tr>
</c:if>
<th>${mergedSchedule[j].time}</th>
	<c:forEach var = "i" begin="${j}" end="335" step="48">
		<c:if test = "${fn:length(mergedSchedule[i].users) > 1}">
			<td id="overLap">
			<c:forEach var = "k" begin="0" end="${fn:length(mergedSchedule[i].users) - 1}">
				<a href="/FBWebServer/schedules/schedule/merge/event/view?eventID=${mergedSchedule[i].events[k].event_id}">${mergedSchedule[i].users[k].first_name} - ${mergedSchedule[i].events[k].name}</a><br/>
			</c:forEach>
			</td>
		</c:if >
		<c:if test = "${fn:length(mergedSchedule[i].users) == 1}">
			<c:forEach var = "k" begin="0" end="${fn:length(mergedSchedule[i].users) - 1}">
				<c:if test = "${user == mergedSchedule[i].users[k].email}">
					<td id="noOverLapMe">
					<a href="/FBWebServer/schedules/schedule/merge/event/view?eventID=${mergedSchedule[i].events[k].event_id}">${mergedSchedule[i].users[k].first_name} - ${mergedSchedule[i].events[k].name}</a><br/>
					</td>
				</c:if>
				<c:if test = "${user != mergedSchedule[i].users[k].email}">
					<td id="noOverLapOther">
					<a href="/FBWebServer/schedules/schedule/merge/event/view?eventID=${mergedSchedule[i].events[k].event_id}">${mergedSchedule[i].users[k].first_name} - ${mergedSchedule[i].events[k].name}</a><br/>
					</td>
				</c:if>
			</c:forEach>
		</c:if >
		<c:if test = "${fn:length(mergedSchedule[i].users) < 1}">
			<td>
			</td>
		</c:if >
	</c:forEach>
</tr>
</c:forEach>

</table>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>