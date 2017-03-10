<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%
// *** Logout the current user.
String MM_logoutRedirectPage = "";
session.putValue("MM_Username", "");
session.putValue("MM_UserAuthorization", "");
if (!MM_logoutRedirectPage.equals("")) response.sendRedirect(response.encodeRedirectURL(MM_logoutRedirectPage));
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
</body>
</html>
