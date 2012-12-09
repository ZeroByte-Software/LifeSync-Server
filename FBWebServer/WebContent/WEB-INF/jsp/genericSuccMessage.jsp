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
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</div>

<div id="content">
	${message}
</div>

<div id="footer">
ZeroByte Software Inc.</div>

</body>
</html>
