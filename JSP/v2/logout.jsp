<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
// *** Logout the current user.
String MM_logoutRedirectPage = "fail.html";
session.putValue("MM_Username", "");
session.putValue("MM_UserAuthorization", "");
if (!MM_logoutRedirectPage.equals("")) {
  response.sendRedirect(response.encodeRedirectURL(MM_logoutRedirectPage));
  return;
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

</body>
</html>
