<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<body>
<script>
function confirmDelete()
{
	var result = confirm("Are you sure you want to delete this user?");
	
	return result;
}

</script>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px; color:white">Administration</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%;overflow:auto;">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;overflow:auto;">
	<b style="color: white;">Users</b><br/><br/>
	<!--<table style="border-collapse: collapse;color: white; border-color: white; table-layout: 500px; border:1"> -->
	<table>
	 	<colgroup span=3 style=background-color:rgb(204,255,204)>
        <thead style=background-color:rgb(204,230,255)>
		<tr><th style="text-align:center;">User ID</th><th style="text-align:center;">User Name</th><th style="text-align:center;">Actions</th></tr>
		</thead>
		<c:forEach items="${allUsers}" var="allUsers">
			<tr><td style="text-align:center;">${allUsers.user_id}</td><td style="text-align:center;">${allUsers.first_name} ${allUsers.last_name}</td><td style="text-align:center;"> <a href="/FBWebServer/adminPage/userInfo?userID=${allUsers.user_id}">Info</a> <a href="/FBWebServer/adminPage/userDelete?userID=${allUsers.user_id}" onclick="return confirmDelete()">delete</a></td></tr>
		</c:forEach>
	</table>
</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>
