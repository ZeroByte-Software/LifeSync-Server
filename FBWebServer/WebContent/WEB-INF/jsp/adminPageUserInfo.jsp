<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<body>

<div id="header" style="background-color:#43474B;">
<h1 style="margin-bottom:0;height:50px;color:white " >Administration</h1></div>

<div id="menu" style="background-color:black;width:150px;height:500px;float:left;color:white;font-size:70%">
Logged As:<br/>
${user}<br/><br/>
<a href="<c:url value="/adminPage" />" >Admin Page</a><br/>
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content" style="background-color:#26272B;height:500px;float:top;color: white; border-color: white;">
			<b> USER INFO</b><br/><br/>
				User ID: <c:out value="${appUserID}"/><br/>
				First Name: <c:out value="${appUserFN}"/><br/>
				Last Name: <c:out value="${appUserLN}"/><br/>
				Role: <c:out value="${appUserRole}"/><br/>
				Email: <c:out value="${appUserEmail}"/><br/><br/>
				<button type="button" onClick="location.href='/FBWebServer/adminPage/adminEdit?userID=${appUserID}'" style="background-color:#4ED1B7;border-color:#26272B">Edit</button>
		</div>

<div id="footer" style="background-color:#43474B;height:25px;text-align:center;">
ZeroByte Software Inc.</div>

</body>
</html>