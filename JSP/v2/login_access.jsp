<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../Connections/connWorld.jsp" %>
<%
// *** Validate request to log in to this site.
String MM_LoginAction = request.getRequestURI();
if (request.getQueryString() != null && request.getQueryString().length() > 0) {
  String queryString = request.getQueryString();
  String tempStr = "";
  for (int i=0; i < queryString.length(); i++) {
    if (queryString.charAt(i) == '<') tempStr = tempStr + "&lt;";
    else if (queryString.charAt(i) == '>') tempStr = tempStr + "&gt;";
    else if (queryString.charAt(i) == '"') tempStr = tempStr +  "&quot;";
    else tempStr = tempStr + queryString.charAt(i);
  }
  MM_LoginAction += "?" + tempStr;
}
String MM_valUsername=request.getParameter("username");
if (MM_valUsername != null) {
  String MM_fldUserAuthorization="access";
  String MM_redirectLoginSuccess="success";
  String MM_redirectLoginFailed="fail";
  String MM_redirectLogin=MM_redirectLoginFailed;
  Driver MM_driverUser = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
  Connection MM_connUser = DriverManager.getConnection(MM_connWorld_STRING,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
  String MM_pSQL = "SELECT username, username";
  if (!MM_fldUserAuthorization.equals("")) MM_pSQL += "," + MM_fldUserAuthorization;
  MM_pSQL += " FROM world.user WHERE username=\'" + MM_valUsername.replace('\'', ' ') + "\' AND username=\'" + request.getParameter("password").toString().replace('\'', ' ') + "\'";
  PreparedStatement MM_statementUser = MM_connUser.prepareStatement(MM_pSQL);
  ResultSet MM_rsUser = MM_statementUser.executeQuery();
  boolean MM_rsUser_isNotEmpty = MM_rsUser.next();
  if (MM_rsUser_isNotEmpty) {
    // username and password match - this is a valid user
    session.putValue("MM_Username", MM_valUsername);
    if (!MM_fldUserAuthorization.equals("")) {
      session.putValue("MM_UserAuthorization", MM_rsUser.getString(MM_fldUserAuthorization).trim());
    } else {
      session.putValue("MM_UserAuthorization", "");
    }
    if ((request.getParameter("accessdenied") != null) && true) {
      MM_redirectLoginSuccess = request.getParameter("accessdenied");
    }
    MM_redirectLogin=MM_redirectLoginSuccess;
  }
  MM_rsUser.close();
  MM_connUser.close();
  response.sendRedirect(response.encodeRedirectURL(MM_redirectLogin));
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
<form name="form1" method="POST" action="<%=MM_LoginAction%>">
  <table width="200" border="1">
    <tr>
      <td>Username</td>
      <td><input name="username" type="text" id="username"></td>
    </tr>
    <tr>
      <td>Password</td>
      <td><input name="password" type="text" id="password"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="Submit"></td>
    </tr>
  </table>
</form>
</body>
</html>
