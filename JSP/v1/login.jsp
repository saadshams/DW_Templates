<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ include file="../Connections/connWorld.jsp" %>
<%
// *** Validate request to log in to this site.
String MM_LoginAction = request.getRequestURI();
if (request.getQueryString() != null && request.getQueryString().length() > 0) MM_LoginAction += "?" + request.getQueryString();
String MM_valUsername=request.getParameter("username");
if (MM_valUsername != null) {
  String MM_fldUserAuthorization="";
  String MM_redirectLoginSuccess="../success.html";
  String MM_redirectLoginFailed="../fail.html";
  String MM_redirectLogin=MM_redirectLoginFailed;
  Driver MM_driverUser = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
  Connection MM_connUser = DriverManager.getConnection(MM_connWorld_STRING,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
  String MM_pSQL = "SELECT username, password";
  if (!MM_fldUserAuthorization.equals("")) MM_pSQL += "," + MM_fldUserAuthorization;
  MM_pSQL += " FROM world.user WHERE username='" + MM_valUsername + "' AND password='" + request.getParameter("password") + "'";
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
    if ((request.getParameter("accessdenied") != null) && false) {
      MM_redirectLoginSuccess = request.getParameter("accessdenied");
    }
    MM_redirectLogin=MM_redirectLoginSuccess;
  }
  MM_rsUser.close();
  MM_connUser.close();
  response.sendRedirect(response.encodeRedirectURL(MM_redirectLogin));
}
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" method="post" action="<%=MM_LoginAction%>">
  <table width="75%" border="1">
    <tr> 
      <td>username</td>
      <td> 
        <input type="text" name="username">
      </td>
    </tr>
    <tr> 
      <td>password</td>
      <td> 
        <input type="text" name="password">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <input type="submit" name="Submit" value="Submit">
      </td>
    </tr>
  </table>
</form>
</body>
</html>

