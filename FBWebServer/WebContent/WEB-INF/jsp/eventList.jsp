<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px; color: white">My Schedule</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:80%">
Logged As:<br/>
${user}<br/><br/>
<a href= "/FBWebServer/schedules/schedule/events/event/create<%="?scheduleID=" + request.getParameter("scheduleID") %>">Create Event</a><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="javascript: history.go(-1)">Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/><br/><br/>
<c:if test = "${fn:length(friends) > 0}">
	Friends Available To Merge:
	<form action="/FBWebServer/schedules/schedule/merge" method="get">
		<c:forEach items="${friends}" var="friend">
			<input type="checkbox" name="friendToMerge" value="${friend.user_id}"/>${friend.first_name} ${friend.last_name}<br>
		</c:forEach>
		<input type="hidden" name="scheduleID" value ="<%=request.getParameter("scheduleID") %>"/>
		<input type="submit" name="submit" value="Merge" style="background-color:#4ED1B7;border-color:#26272B"/>
	</form>
</c:if >
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;overflow:auto;">
<!--<form:form method = "POST" action="/FBWebServer/schedules/schedule/view" commandName = "weekSelect" style="text-align:center;padding-top:100px;">
		Week Of: <input type="text" name="firstname">	
		<input type="submit" name="submit" value="Create" style="background-color:#4ED1B7;border-color:#26272B"/>
</form:form>-->



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
<tr>
  <th rowspan="2">0:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday1.event_id}">${Sunday1.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday1.event_id}">${Monday1.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday1.event_id}">${Tuesday1.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday1.event_id}">${Wednesday1.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday1.event_id}">${Thursday1.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday1.event_id}">${Friday1.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday1.event_id}">${Saturday1.name}</a></td>
</tr>
<tr>
  <td>${Sunday1.location}</td>
  <td>${Monday1.location}</td>
  <td>${Tuesday1.location}</td>
  <td>${Wednesday1.location}</td>
  <td>${Thursday1.location}</td>
  <td>${Friday1.location}</td>
  <td>${Saturday1.location}</td>
</tr>


<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">0:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday2.event_id}">${Sunday2.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday2.event_id}">${Monday2.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday2.event_id}">${Tuesday2.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday2.event_id}">${Wednesday2.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday2.event_id}">${Thursday2.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday2.event_id}">${Friday2.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday2.event_id}">${Saturday2.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday2.location}</td>
  <td>${Monday2.location}</td>
  <td>${Tuesday2.location}</td>
  <td>${Wednesday2.location}</td>
  <td>${Thursday2.location}</td>
  <td>${Friday2.location}</td>
  <td>${Saturday2.location}</td>
</tr>

<tr>
  <th rowspan="2">1:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday3.event_id}">${Sunday3.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday3.event_id}">${Monday3.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday3.event_id}">${Tuesday3.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday3.event_id}">${Wednesday3.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday3.event_id}">${Thursday3.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday3.event_id}">${Friday3.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday3.event_id}">${Saturday3.name}</a></td>
</tr>
<tr>
  <td>${Sunday3.location}</td>
  <td>${Monday3.location}</td>
  <td>${Tuesday3.location}</td>
  <td>${Wednesday3.location}</td>
  <td>${Thursday3.location}</td>
  <td>${Friday3.location}</td>
  <td>${Saturday3.location}</td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">1:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday4.event_id}">${Sunday4.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday4.event_id}">${Monday4.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday4.event_id}">${Tuesday4.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday4.event_id}">${Wednesday4.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday4.event_id}">${Thursday4.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday4.event_id}">${Friday4.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday4.event_id}">${Saturday4.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday4.location}</td>
  <td>${Monday4.location}</td>
  <td>${Tuesday4.location}</td>
  <td>${Wednesday4.location}</td>
  <td>${Thursday4.location}</td>
  <td>${friday4.location}</td>
  <td>${Saturday4.location}</td>
</tr>

<tr>
  <th rowspan="2">2:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday5.event_id}">${Sunday5.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday5.event_id}">${Monday5.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday5.event_id}">${Tuesday5.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday5.event_id}">${Wednesday5.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday5.event_id}">${Thursday5.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday5.event_id}">${Friday5.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday5.event_id}">${Saturday5.name}</a></td>
</tr>
<tr>
  <td>${Sunday5.location}</td>
  <td>${Monday5.location}</td>
  <td>${Tuesday5.location}</td>
  <td>${Wednesday5.location}</td>
  <td>${Thursday5.location}</td>
  <td>${Friday5.location}</td>
  <td>${Saturday5.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">2:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday6.event_id}">${Sunday6.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday6.event_id}">${Monday6.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday6.event_id}">${Tuesday6.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday6.event_id}">${Wednesday6.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday6.event_id}">${Thursday6.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday6.event_id}">${Friday6.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday6.event_id}">${Saturday6.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday6.location}</td>
  <td>${Monday6.location}</td>
  <td>${Tuesday6.location}</td>
  <td>${Wednesday6.location}</td>
  <td>${Thursday6.location}</td>
  <td>${Friday6.location}</td>
  <td>${Saturday6.location}</td>
</tr>

<tr>
  <th rowspan="2">3:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday7.event_id}">${Sunday7.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday7.event_id}">${Monday7.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday7.event_id}">${Tuesday7.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday7.event_id}">${Wednesday7.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday7.event_id}">${Thursday7.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday7.event_id}">${Friday7.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday7.event_id}">${Saturday7.name}</a></td>
</tr>
<tr>
  <td>${Sunday7.location}</td>
  <td>${Monday7.location}</td>
  <td>${Tuesday7.location}</td>
  <td>${Wednesday7.location}</td>
  <td>${Thursday7.location}</td>
  <td>${Friday7.location}</td>
  <td>${Saturday7.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">3:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday8.event_id}">${Sunday8.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday8.event_id}">${Monday8.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday8.event_id}">${Tuesday8.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday8.event_id}">${Wednesday8.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday8.event_id}">${Thursday8.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday8.event_id}">${Friday8.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday8.event_id}">${Saturday8.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday8.location}</td>
  <td>${Monday8.location}</td>
  <td>${Tuesday8.location}</td>
  <td>${Wednesday8.location}</td>
  <td>${Thursday8.location}</td>
  <td>${Friday8.location}</td>
  <td>${Saturday8.location}</td>
</tr>

<tr>
  <th rowspan="2">4:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday9.event_id}">${Sunday9.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday9.event_id}">${Monday9.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday9.event_id}">${Tuesday9.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday9.event_id}">${Wednesday9.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday9.event_id}">${Thursday9.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday9.event_id}">${Friday9.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday9.event_id}">${Saturday9.name}</a></td>
</tr>
<tr>
  <td>${Sunday9.location}</td>
  <td>${Monday9.location}</td>
  <td>${Tuesday9.location}</td>
  <td>${Wednesday9.location}</td>
  <td>${Thursday9.location}</td>
  <td>${Friday9.location}</td>
  <td>${Saturday9.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">4:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday10.event_id}">${Sunday10.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday10.event_id}">${Monday10.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday10.event_id}">${Tuesday10.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday10.event_id}">${Wednesday10.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday10.event_id}">${Thursday10.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday10.event_id}">${Friday10.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday10.event_id}">${Saturday10.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday10.location}</td>
  <td>${Monday10.location}</td>
  <td>${Tuesday10.location}</td>
  <td>${Wednesday10.location}</td>
  <td>${Thursday10.location}</td>
  <td>${Friday10.location}</td>
  <td>${Saturday10.location}</td>
</tr>

<tr>
  <th rowspan="2">5:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday11.event_id}">${Sunday11.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday11.event_id}">${Monday11.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday11.event_id}">${Tuesday11.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday11.event_id}">${Wednesday11.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday11.event_id}">${Thursday11.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday11.event_id}">${Friday11.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday11.event_id}">${Saturday11.name}</a></td>
</tr>
<tr>
  <td>${Sunday11.location}</td>
  <td>${Monday11.location}</td>
  <td>${Tuesday11.location}</td>
  <td>${Wednesday11.location}</td>
  <td>${Thursday11.location}</td>
  <td>${Friday11.location}</td>
  <td>${Saturday11.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">5:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday12.event_id}">${Sunday12.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday12.event_id}">${Monday12.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday12.event_id}">${Tuesday12.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday12.event_id}">${Wednesday12.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday12.event_id}">${Thursday12.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday12.event_id}">${Friday12.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday12.event_id}">${Saturday12.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday12.location}</td>
  <td>${Monday12.location}</td>
  <td>${Tuesday12.location}</td>
  <td>${Wednesday12.location}</td>
  <td>${Thursday12.location}</td>
  <td>${Friday12.location}</td>
  <td>${Saturday12.location}</td>
</tr>

<tr>
  <th rowspan="2">6:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday13.event_id}">${Sunday13.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday13.event_id}">${Monday13.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday13.event_id}">${Tuesday13.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday13.event_id}">${Wednesday13.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday13.event_id}">${Thursday13.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday13.event_id}">${Friday13.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday13.event_id}">${Saturday13.name}</a></td>
</tr>
<tr>
  <td>${Sunday13.location}</td>
  <td>${Monday13.location}</td>
  <td>${Tuesday13.location}</td>
  <td>${Wednesday13.location}</td>
  <td>${Thursday13.location}</td>
  <td>${Friday13.location}</td>
  <td>${Saturday13.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">6:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday14.event_id}">${Sunday14.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday14.event_id}">${Monday14.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday14.event_id}">${Tuesday14.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday14.event_id}">${Wednesday14.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday14.event_id}">${Thursday14.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday14.event_id}">${Friday14.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday14.event_id}">${Saturday14.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday14.location}</td>
  <td>${Monday14.location}</td>
  <td>${Tuesday14.location}</td>
  <td>${Wednesday14.location}</td>
  <td>${Thursday11.location}</td>
  <td>${Friday14.location}</td>
  <td>${Saturday14.location}</td>
</tr>

<tr>
  <th rowspan="2">7:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday15.event_id}">${Sunday15.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday15.event_id}">${Monday15.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday15.event_id}">${Tuesday15.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday15.event_id}">${Wednesday15.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday15.event_id}">${Thursday15.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday15.event_id}">${Friday15.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday15.event_id}">${Saturday15.name}</a></td>
</tr>
<tr>
  <td>${Sunday15.location}</td>
  <td>${Monday15.location}</td>
  <td>${Tuesday15.location}</td>
  <td>${Wednesday15.location}</td>
  <td>${Thursday15.location}</td>
  <td>${Friday15.location}</td>
  <td>${Saturday15.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">7:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday16.event_id}">${Sunday16.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday16.event_id}">${Monday16.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday16.event_id}">${Tuesday16.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday16.event_id}">${Wednesday16.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday16.event_id}">${Thursday16.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday16.event_id}">${Friday16.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday16.event_id}">${Saturday16.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday16.location}</td>
  <td>${Monday16.location}</td>
  <td>${Tuesday16.location}</td>
  <td>${Wednesday16.location}</td>
  <td>${Thursday16.location}</td>
  <td>${Friday16.location}</td>
  <td>${Saturday16.location}</td>
</tr>

<tr>
  <th rowspan="2">8:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday17.event_id}">${Sunday17.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday17.event_id}">${Monday17.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday17.event_id}">${Tuesday17.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday17.event_id}">${Wednesday17.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday17.event_id}">${Thursday17.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday17.event_id}">${Friday17.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday17.event_id}">${Saturday17.name}</a></td>
</tr>
<tr>
  <td>${Sunday17.location}</td>
  <td>${Monday17.location}</td>
  <td>${Tuesday17.location}</td>
  <td>${Wednesday17.location}</td>
  <td>${Thursday17.location}</td>
  <td>${Friday17.location}</td>
  <td>${Saturday17.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">8:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday18.event_id}">${Sunday18.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday18.event_id}">${Monday18.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday18.event_id}">${Tuesday18.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday18.event_id}">${Wednesday18.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday18.event_id}">${Thursday18.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday18.event_id}">${Friday18.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday18.event_id}">${Saturday18.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday18.location}</td>
  <td>${Monday18.location}</td>
  <td>${Tuesday18.location}</td>
  <td>${Wednesday18.location}</td>
  <td>${Thursday18.location}</td>
  <td>${Friday18.location}</td>
  <td>${Saturday18.location}</td>
</tr>

<tr>
  <th rowspan="2">9:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday19.event_id}">${Sunday19.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday19.event_id}">${Monday19.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday19.event_id}">${Tuesday19.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday19.event_id}">${Wednesday19.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday19.event_id}">${Thursday19.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday19.event_id}">${Friday19.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday19.event_id}">${Saturday19.name}</a></td>
</tr>
<tr>
  <td>${Sunday19.location}</td>
  <td>${Monday19.location}</td>
  <td>${Tuesday19.location}</td>
  <td>${Wednesday19.location}</td>
  <td>${Thursday19.location}</td>
  <td>${Friday19.location}</td>
  <td>${Saturday19.location}</td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">9:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday20.event_id}">${Sunday20.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday20.event_id}">${Monday20.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday20.event_id}">${Tuesday20.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday20.event_id}">${Wednesday20.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday20.event_id}">${Thursday20.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday20.event_id}">${Friday20.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday20.event_id}">${Saturday20.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday20.location}</td>
  <td>${Monday20.location}</td>
  <td>${Tuesday20.location}</td>
  <td>${Wednesday20.location}</td>
  <td>${Thursday20.location}</td>
  <td>${Friday20.location}</td>
  <td>${Saturday20.location}</td>
</tr>

<tr>
  <th rowspan="2">10:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday21.event_id}">${Sunday21.name}</a></td> 
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday21.event_id}">${Monday21.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday21.event_id}">${Tuesday21.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday21.event_id}">${Wednesday21.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday21.event_id}">${Thursday21.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday21.event_id}">${Friday21.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday21.event_id}">${Saturday21.name}</a></td>
</tr>
<tr>
  <td>${Sunday21.location}</td>
  <td>${Monday21.location}</td>
  <td>${Tuesday21.location}</td>
  <td>${Wednesday21.location}</td>
  <td>${Thursday21.location}</td>
  <td>${Friday21.location}</td>
  <td>${Saturday21.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">10:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday22.event_id}">${Sunday22.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday22.event_id}">${Monday22.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday22.event_id}">${Tuesday22.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday22.event_id}">${Wednesday22.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday22.event_id}">${Thursday22.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday22.event_id}">${Friday22.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday22.event_id}">${Saturday22.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday22.location}</td>
  <td>${Monday22.location}</td>
  <td>${Tuesday22.location}</td>
  <td>${Wednesday22.location}</td>
  <td>${Thursday22.location}</td>
  <td>${Friday22.location}</td>
  <td>${Saturday22.location}</td>
</tr>

<tr>
  <th rowspan="2">11:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday23.event_id}">${Sunday23.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday23.event_id}">${Monday23.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday23.event_id}">${Tuesday23.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday23.event_id}">${Wednesday23.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday23.event_id}">${Thursday23.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday23.event_id}">${Friday23.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday23.event_id}">${Saturday23.name}</a></td>
</tr>
<tr>
  <td>${Sunday23.location}</td>
  <td>${Monday23.location}</td>
  <td>${Tuesday23.location}</td>
  <td>${Wednesday23.location}</td>
  <td>${Thursday23.location}</td>
  <td>${Friday23.location}</td>
  <td>${Saturday23.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">11:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday24.event_id}">${Sunday24.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday24.event_id}">${Monday24.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday24.event_id}">${Tuesday24.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday24.event_id}">${Wednesday24.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday24.event_id}">${Thursday24.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday24.event_id}">${Friday24.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday24.event_id}">${Saturday24.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday24.location}</td>
  <td>${Monday24.location}</td>
  <td>${Tuesday24.location}</td>
  <td>${Wednesday24.location}</td>
  <td>${Thursday24.location}</td>
  <td>${Friday24.location}</td>
  <td>${Saturday24.location}</td>
</tr>

<tr>
  <th rowspan="2">12:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday25.event_id}">${Sunday25.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday25.event_id}">${Monday25.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday25.event_id}">${Tuesday25.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday25.event_id}">${Wednesday25.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday25.event_id}">${Thursday25.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday25.event_id}">${Friday25.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday25.event_id}">${Saturday25.name}</a></td>
</tr>
<tr>
  <td>${Sunday25.location}</td>
  <td>${Monday25.location}</td>
  <td>${Tuesday25.location}</td>
  <td>${Wednesday25.location}</td>
  <td>${Thursday25.location}</td>
  <td>${Friday25.location}</td>
  <td>${Saturday25.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">12:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday26.event_id}">${Sunday26.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday26.event_id}">${Monday26.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday26.event_id}">${Tuesday26.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday26.event_id}">${Wednesday26.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday26.event_id}">${Thursday26.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday26.event_id}">${Friday26.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday26.event_id}">${Saturday26.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday26.location}</td>
  <td>${Monday26.location}</td>
  <td>${Tuesday26.location}</td>
  <td>${Wednesday26.location}</td>
  <td>${Thursday26.location}</td>
  <td>${Friday26.location}</td>
  <td>${Saturday26.location}</td>
</tr>

<tr>
  <th rowspan="2">13:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday27.event_id}">${Sunday27.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday27.event_id}">${Monday27.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday27.event_id}">${Tuesday27.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday27.event_id}">${Wednesday27.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday27.event_id}">${Thursday27.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday27.event_id}">${Friday27.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday27.event_id}">${Saturday27.name}</a></td>
</tr>
<tr>
  <td>${Sunday27.location}</td>
  <td>${Monday27.location}</td>
  <td>${Tuesday27.location}</td>
  <td>${Wednesday27.location}</td>
  <td>${Thursday27.location}</td>
  <td>${Friday27.location}</td>
  <td>${Saturday27.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">13:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday28.event_id}">${Sunday28.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday28.event_id}">${Monday28.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday28.event_id}">${Tuesday28.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday28.event_id}">${Wednesday28.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday28.event_id}">${Thursday28.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday28.event_id}">${Friday28.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday28.event_id}">${Saturday28.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday28.location}</td>
  <td>${Monday28.location}</td>
  <td>${Tuesday28.location}</td>
  <td>${Wednesday28.location}</td>
  <td>${Thursday28.location}</td>
  <td>${Friday28.location}</td>
  <td>${Saturday28.location}</td>
</tr>

<tr>
  <th rowspan="2">14:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday29.event_id}">${Sunday29.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday29.event_id}">${Monday29.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday29.event_id}">${Tuesday29.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday29.event_id}">${Wednesday29.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday29.event_id}">${Thursday29.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday29.event_id}">${Friday29.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday29.event_id}">${Saturday29.name}</a></td>
</tr>
<tr>
  <td>${Sunday29.location}</td>
  <td>${Monday29.location}</td>
  <td>${Tuesday29.location}</td>
  <td>${Wednesday29.location}</td>
  <td>${Thursday29.location}</td>
  <td>${Friday29.location}</td>
  <td>${Saturday29.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">14:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday30.event_id}">${Sunday30.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday30.event_id}">${Monday30.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday30.event_id}">${Tuesday30.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday30.event_id}">${Wednesday30.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday30.event_id}">${Thursday30.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday30.event_id}">${Friday30.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday30.event_id}">${Saturday30.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday30.location}</td>
  <td>${Monday30.location}</td>
  <td>${Tuesday30.location}</td>
  <td>${Wednesday30.location}</td>
  <td>${Thursday30.location}</td>
  <td>${Friday30.location}</td>
  <td>${Saturday30.location}</td>
</tr>

<tr>
  <th rowspan="2">15:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday31.event_id}">${Sunday31.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday31.event_id}">${Monday31.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday31.event_id}">${Tuesday31.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday31.event_id}">${Wednesday31.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday31.event_id}">${Thursday31.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday31.event_id}">${Friday31.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday31.event_id}">${Saturday31.name}</a></td>
</tr>
<tr>
  <td>${Sunday31.location}</td>
  <td>${Monday31.location}</td>
  <td>${Tuesday31.location}</td>
  <td>${Wednesday31.location}</td>
  <td>${Thursday31.location}</td>
  <td>${Friday31.location}</td>
  <td>${Saturday31.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">15:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday32.event_id}">${Sunday32.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday32.event_id}">${Monday32.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday32.event_id}">${Tuesday32.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday32.event_id}">${Wednesday32.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday32.event_id}">${Thursday32.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday32.event_id}">${Friday32.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday32.event_id}">${Saturday32.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday32.location}</td>
  <td>${Monday32.location}</td>
  <td>${Tuesday32.location}</td>
  <td>${Wednesday32.location}</td>
  <td>${Thursday32.location}</td>
  <td>${Friday32.location}</td>
  <td>${Saturday32.location}</td>
</tr>

<tr>
  <th rowspan="2">16:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday33.event_id}">${Sunday33.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday33.event_id}">${Monday33.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday33.event_id}">${Tuesday33.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday33.event_id}">${Wednesday33.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday33.event_id}">${Thursday33.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday33.event_id}">${Friday33.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday33.event_id}">${Saturday33.name}</a></td>
</tr>
<tr>
  <td>${Sunday33.location}</td>
  <td>${Monday33.location}</td>
  <td>${Tuesday33.location}</td>
  <td>${Wednesday33.location}</td>
  <td>${Thursday33.location}</td>
  <td>${Friday33.location}</td>
  <td>${Saturday33.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">16:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday34.event_id}">${Sunday34.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday34.event_id}">${Monday34.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday34.event_id}">${Tuesday34.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday34.event_id}">${Wednesday34.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday34.event_id}">${Thursday34.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday34.event_id}">${Friday34.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday34.event_id}">${Saturday34.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday34.location}</td>
  <td>${Monday34.location}</td>
  <td>${Tuesday34.location}</td>
  <td>${Wednesday34.location}</td>
  <td>${Thursday34.location}</td>
  <td>${Friday34.location}</td>
  <td>${Saturday34.location}</td>
</tr>

<tr>
  <th rowspan="2">17:00</th>	
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday35.event_id}">${Sunday35.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday35.event_id}">${Monday35.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday35.event_id}">${Tuesday35.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday35.event_id}">${Wednesday35.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday35.event_id}">${Thursday35.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday35.event_id}">${Friday35.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday35.event_id}">${Saturday35.name}</a></td>
</tr>
<tr>
  <td>${Sunday35.location}</td>
  <td>${Monday35.location}</td>
  <td>${Tuesday35.location}</td>
  <td>${Wednesday35.location}</td>
  <td>${Thursday35.location}</td>
  <td>${Friday35.location}</td>
  <td>${Saturday35.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">17:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday36.event_id}">${Sunday36.name}</a></td>	
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday36.event_id}">${Monday36.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday36.event_id}">${Tuesday36.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday36.event_id}">${Wednesday36.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday36.event_id}">${Thursday36.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday36.event_id}">${Friday36.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday36.event_id}">${Saturday36.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday36.location}</td>
  <td>${Monday36.location}</td>
  <td>${Tuesday36.location}</td>
  <td>${Wednesday36.location}</td>
  <td>${Thursday36.location}</td>
  <td>${Friday36.location}</td>
  <td>${Saturday36.location}</td>
</tr>

<tr >
  <th rowspan="2">18:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday37.event_id}">${Sunday37.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday37.event_id}">${Monday37.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday37.event_id}">${Tuesday37.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday37.event_id}">${Wednesday37.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday37.event_id}">${Thursday37.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday37.event_id}">${Friday37.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday37.event_id}">${Saturday37.name}</a></td>
</tr>
<tr>
  <td>${Sunday37.location}</td>
  <td>${Monday37.location}</td>
  <td>${Tuesday37.location}</td>
  <td>${Wednesday37.location}</td>
  <td>${Thursday37.location}</td>
  <td>${Friday37.location}</td>
  <td>${Saturday37.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">18:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday38.event_id}">${Sunday38.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday38.event_id}">${Monday38.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday38.event_id}">${Tuesday38.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday38.event_id}">${Wednesday38.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday38.event_id}">${Thursday38.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday38.event_id}">${Friday38.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday38.event_id}">${Saturday38.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday38.location}</td>
  <td>${Monday38.location}</td>
  <td>${Tuesday38.location}</td>
  <td>${Wednesday38.location}</td>
  <td>${Thursday38.location}</td>
  <td>${Friday38.location}</td>
  <td>${Saturday38.location}</td>
</tr>

<tr>
  <th rowspan="2">19:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday39.event_id}">${Sunday39.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday39.event_id}">${Monday39.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday39.event_id}">${Tuesday39.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday39.event_id}">${Wednesday39.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday39.event_id}">${Thursday39.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday39.event_id}">${Friday39.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday39.event_id}">${Saturday39.name}</a></td>
</tr>
<tr>
  <td>${Sunday39.location}</td>
  <td>${Monday39.location}</td>
  <td>${Tuesday39.location}</td>
  <td>${Wednesday39.location}</td>
  <td>${Thursday39.location}</td>
  <td>${Friday39.location}</td>
  <td>${Saturday39.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">19:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday40.event_id}">${Sunday40.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday40.event_id}">${Monday40.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday40.event_id}">${Tuesday40.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday40.event_id}">${Wednesday40.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday40.event_id}">${Thursday40.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday40.event_id}">${Friday40.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday40.event_id}">${Saturday40.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday40.location}</td>
  <td>${Monday40.location}</td>
  <td>${Tuesday40.location}</td>
  <td>${Wednesday40.location}</td>
  <td>${Thursday40.location}</td>
  <td>${Friday40.location}</td>
  <td>${Saturday40.location}</td>
</tr>
<tr>
  <th rowspan="2">20:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday41.event_id}">${Sunday41.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday41.event_id}">${Monday41.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday41.event_id}">${Tuesday41.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday41.event_id}">${Wednesday41.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday41.event_id}">${Thursday41.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday41.event_id}">${Friday41.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday41.event_id}">${Saturday41.name}</a></td>
</tr>
<tr>
  <td>${Sunday41.location}</td>
  <td>${Monday41.location}</td>
  <td>${Tuesday41.location}</td>
  <td>${Wednesday41.location}</td>
  <td>${Thursday41.location}</td>
  <td>${Friday41.location}</td>
  <td>${Saturday41.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">20:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday42.event_id}">${Sunday42.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday42.event_id}">${Monday42.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday42.event_id}">${Tuesday42.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday42.event_id}">${Wednesday42.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday42.event_id}">${Thursday42.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday42.event_id}">${Friday42.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday42.event_id}">${Saturday42.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday42.location}</td>
  <td>${Monday42.location}</td>
  <td>${Tuesday42.location}</td>
  <td>${Wednesday42.location}</td>
  <td>${Thursday42.location}</td>
  <td>${Friday42.location}</td>
  <td>${Saturday42.location}</td>
</tr>

<tr>
  <th rowspan="2">21:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday43.event_id}">${Sunday43.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday43.event_id}">${Monday43.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday43.event_id}">${Tuesday43.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday43.event_id}">${Wednesday43.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday43.event_id}">${Thursday43.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday43.event_id}">${Friday43.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday43.event_id}">${Saturday43.name}</a></td>
</tr>
<tr>
  <td>${Sunday43.location}</td>
  <td>${Monday43.location}</td>
  <td>${Tuesday43.location}</td>
  <td>${Wednesday43.location}</td>
  <td>${Thursday43.location}</td>
  <td>${Friday43.location}</td>
  <td>${Saturday43.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">21:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday44.event_id}">${Sunday44.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday44.event_id}">${Monday44.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday44.event_id}">${Tuesday44.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday44.event_id}">${Wednesday44.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday44.event_id}">${Thursday44.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday44.event_id}">${Friday44.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday44.event_id}">${Saturday44.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday44.location}</td>
  <td>${Monday44.location}</td>
  <td>${Tuesday44.location}</td>
  <td>${Wednesday44.location}</td>
  <td>${Thursday44.location}</td>
  <td>${Friday44.location}</td>
  <td>${Saturday44.location}</td>
</tr>

<tr>
  <th rowspan="2">22:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday45.event_id}">${Sunday45.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday45.event_id}">${Monday45.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday45.event_id}">${Tuesday45.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday45.event_id}">${Wednesday45.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday45.event_id}">${Thursday45.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday45.event_id}">${Friday45.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday45.event_id}">${Saturday45.name}</a></td>
</tr>
<tr>
  <td>${Sunday45.location}</td>
  <td>${Monday45.location}</td>
  <td>${Tuesday45.location}</td>
  <td>${Wednesday45.location}</td>
  <td>${Thursday45.location}</td>
  <td>${Friday45.location}</td>
  <td>${Saturday45.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">22:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday46.event_id}">${Sunday46.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday46.event_id}">${Monday46.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday46.event_id}">${Tuesday46.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday46.event_id}">${Wednesday46.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday46.event_id}">${Thursday46.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday46.event_id}">${Friday46.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday46.event_id}">${Saturday46.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday46.location}</td>
  <td>${Monday46.location}</td>
  <td>${Tuesday46.location}</td>
  <td>${Wednesday46.location}</td>
  <td>${Thursday46.location}</td>
  <td>${Friday46.location}</td>
  <td>${Saturday46.location}</td>
</tr>

<tr>
  <th rowspan="2">23:00</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday47.event_id}">${Sunday47.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday47.event_id}">${Monday47.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday47.event_id}">${Tuesday47.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday47.event_id}">${Wednesday47.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday47.event_id}">${Thursday47.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday47.event_id}">${Friday47.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday47.event_id}">${Saturday47.name}</a></td>
</tr>
<tr>
  <td>${Sunday47.location}</td>
  <td>${Monday47.location}</td>
  <td>${Tuesday47.location}</td>
  <td>${Wednesday47.location}</td>
  <td>${Thursday47.location}</td>
  <td>${Friday47.location}</td>
  <td>${Saturday47.location}</td>
</tr>

<tr style=background-color:rgb(204,230,255)>
  <th rowspan="2">23:30</th>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Sunday48.event_id}">${Sunday48.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Monday48.event_id}">${Monday48.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Tuesday48.event_id}">${Tuesday48.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Wednesday48.event_id}">${Wednesday48.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Thursday48.event_id}">${Thursday48.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Friday48.event_id}">${Friday48.name}</a></td>
  <td><a href="/FBWebServer/schedules/schedule/events/event/edit?eventID=${Saturday48.event_id}">${Saturday48.name}</a></td>
</tr>
<tr style=background-color:rgb(204,230,255)>
  <td>${Sunday48.location}</td>
  <td>${Monday48.location}</td>
  <td>${Tuesday48.location}</td>
  <td>${Wednesday48.location}</td>
  <td>${Thursday48.location}</td>
  <td>${Friday48.location}</td>
  <td>${Saturday48.location}</td>
</tr>

</table>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>




