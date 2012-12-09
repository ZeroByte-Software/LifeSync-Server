<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<link REL=StyleSheet HREF="<c:url value="/resources/style.css" />" TYPE="text/css">
</head>
<body>

<div id="header">
<h1>Error</h1></div>

<div id="menu">
<c:if test = "${user != null}">
Logged As:<br/>
${user}<br/><br/>
</c:if>
<a href="javascript: history.go(-1)">Back</a><br/>
<c:if test = "${user != null}">
<a href="<c:url value="/j_spring_security_logout" />" >Logout</a><br/>
</c:if>
</div>

<div id="content">
	Unhandled error occurred.
</div>

<div id="footer">
ZeroByte Software Inc.</div>

</body>
</html>
