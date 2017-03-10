<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%
// *** Restrict Access To Page: Grant or deny access to this page
String MM_authorizedUsers="manager,admin";
String MM_authFailedURL="../fail.html";
boolean MM_grantAccess=false;
if (session.getValue("MM_Username") != null && !session.getValue("MM_Username").equals("")) {
  if (false || (session.getValue("MM_UserAuthorization")=="") || 
          (MM_authorizedUsers.indexOf((String)session.getValue("MM_UserAuthorization")) >=0)) {
    MM_grantAccess = true;
  }
}
if (!MM_grantAccess) {
  String MM_qsChar = "?";
  if (MM_authFailedURL.indexOf("?") >= 0) MM_qsChar = "&";
  String MM_referrer = request.getRequestURI();
  if (request.getQueryString() != null) MM_referrer = MM_referrer + "?" + request.getQueryString();
  MM_authFailedURL = MM_authFailedURL + MM_qsChar + "accessdenied=" + java.net.URLEncoder.encode(MM_referrer);
  response.sendRedirect(response.encodeRedirectURL(MM_authFailedURL));
}
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
</body>
</html>
