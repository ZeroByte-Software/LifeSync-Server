<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<body>

<script>
function confirmDelete()
{
	var result = confirm("Are you sure you want to delete this friend?");
	
	return result;
}

function confirmApprove()
{
	var result = confirm("Are you sure you want to approve this friend?");
	
	return result;
}
</script>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px; color: white">My Friends List</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>

<a href="<c:url value="/friendList/friendAdd" />" >Add Friends</a><br/>
<a href="<c:url value="/friendList/facebookFriendList" />" >Add Facebook Friends</a><br/><br/>
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
<a href="javascript: history.go(-1)">Back</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;">
	<b style="color: white;">Friends</b><br/><br/>
	<table>
	 	<colgroup span=2 style=background-color:rgb(204,255,204)>
        <thead style=background-color:rgb(204,230,255)> 
		<tr><th style="text-align:center">Friend Name</th><th style="text-align:center">Action</th></tr>
		</thead> 
		<c:forEach items="${friendUserApp}" var="friendUserApp">
			<tr><td style="text-align:center">${friendUserApp.first_name}</td><td style="text-align:center"><a href="/FBWebServer/friendList/friendView?friendID=${friendUserApp.user_id}" >Friend Info</a> <a href="/FBWebServer/friendList/friendDelete?friendID=${friendUserApp.user_id}" onclick="return confirmDelete()" >delete</a></td></tr>
		</c:forEach>
	</table>
	<br/><br/><b style="color: white;">Pending Friends</b><br/><br/>
	<table>
	    <colgroup span=2 style=background-color:rgb(204,255,204)>
        <thead style=background-color:rgb(204,230,255)>
		<tr><th style="text-align:center">Friend Name</th><th style="text-align:center">Action</th></tr>
		</thead> 
		<c:forEach items="${friendUserPend}" var="friendUserPend">
			<tr><td style="text-align:center">${friendUserPend.first_name}</td><td style="text-align:center"><a href="/FBWebServer/friendList/friendApprove?friendID=${friendUserPend.user_id}" onclick="return confirmApprove()">Approve</a></td></tr>
		</c:forEach>
	</table>
	<br/><br/><b style="color: white;">Awaiting Response</b><br/><br/>
	<table>
	    <colgroup span=2 style=background-color:rgb(204,255,204)>
        <thead style=background-color:rgb(204,230,255)>
		<tr><th style="text-align:center">Friend Name</th><th style="text-align:center">Action</th></tr>
		</thead> 
		<c:forEach items="${friendUserAR}" var="friendUserAR">
			<tr><td style="text-align:center"><a href="/FBWebServer/friendList/friendView?friendID=${friendUserAR.user_id}">${friendUserAR.first_name}</a></td><td style="text-align:center"><a href="/FBWebServer/friendList/friendDelete?friendID=${friendUserAR.user_id}" onclick="return confirmDelete()">delete</a></td></tr>
		</c:forEach>
	</table>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>


