<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Forbidden</title>
<style type="text/css">
a{
	text-decoration: none;
	padding-left: 10px;
}
</style>
</head>
<body style="text-align: center; padding-top: 10%; font-size: 24px;">
	<div style="color: red; font-family: cursive;">
		<c:choose>
			<c:when test = "${pageContext.request.userPrincipal.name !=  null}">
	       		Hello <label style="color: #4C9E31;">${pageContext.request.userPrincipal.name}</label>,
				You do not have permission to see this page!
	   		</c:when>
	   		<c:otherwise>
	   			You must login before access this page!
	   			<a href="login.html">Login</a>
	   		</c:otherwise>
		</c:choose>
	</div>
</body>
</html>