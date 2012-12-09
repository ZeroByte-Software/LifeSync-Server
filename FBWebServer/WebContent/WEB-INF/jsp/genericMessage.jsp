<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<link REL=StyleSheet HREF="<c:url value="/resources/style.css" />" TYPE="text/css">
</head>
<body>

<div id="header">
<h1>${pageTitle}</h1></div>

<div id="menu">
<c:if test = "${user != null}">
Logged As:<br/>
${user}<br/><br/>
</c:if>
<c:if test = "${userRole == null && user != null}">
<a href="<c:url value="/userAcc" />" >User Account</a><br/>
<a href="<c:url value="/schedules" />" >Schedules</a><br/>
<a href="<c:url value="/friendList" />" >Friends List</a><br/>
</c:if>
<a href="javascript: history.go(-1)">Back</a><br/>
<c:if test = "${user != null}">
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</c:if>
</div>

<div id="content">
	${message}<br/>
	<c:if test = "${newLink != null}">
	<button type="button" onClick="location.href='${newLink}'" style="background-color:#4ED1B7;border-color:#26272B">Continue</button>
	</c:if>
</div>

<div id="footer">
ZeroByte Software Inc.</div>

</body>
</html>
