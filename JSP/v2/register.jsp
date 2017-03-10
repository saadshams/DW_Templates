<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../Connections/connWorld.jsp" %>
<%
// *** Edit Operations: declare variables

// set the form action variable
String MM_editAction = request.getRequestURI();
if (request.getQueryString() != null && request.getQueryString().length() > 0) {
  String queryString = request.getQueryString();
  String tempStr = "";
  for (int i=0; i < queryString.length(); i++) {
    if (queryString.charAt(i) == '<') tempStr = tempStr + "&lt;";
    else if (queryString.charAt(i) == '>') tempStr = tempStr + "&gt;";
    else if (queryString.charAt(i) == '"') tempStr = tempStr +  "&quot;";
    else tempStr = tempStr + queryString.charAt(i);
  }
  MM_editAction += "?" + tempStr;
}

// connection information
String MM_editDriver = null, MM_editConnection = null, MM_editUserName = null, MM_editPassword = null;

// redirect information
String MM_editRedirectUrl = null;

// query string to execute
StringBuffer MM_editQuery = null;

// boolean to abort record edit
boolean MM_abortEdit = false;

// table information
String MM_editTable = null, MM_editColumn = null, MM_recordId = null;

// form field information
String[] MM_fields = null, MM_columns = null;
%>
<%
// *** Redirect if username exists
String MM_flag="MM_insert";
if (request.getParameter(MM_flag) != null) {
  String MM_dupKeyRedirect="exists.html";
  String MM_rsKeyConnection=MM_connWorld_STRING;
  String MM_dupKeyUsernameValue = request.getParameter("username");
  String MM_dupKeySQL = "SELECT username FROM world.user WHERE username='" + MM_dupKeyUsernameValue + "'";
  Driver MM_rsKeyDriver = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
  Connection MM_rsKeyConn = DriverManager.getConnection(MM_rsKeyConnection,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
  PreparedStatement MM_rsKeyStatement = MM_rsKeyConn.prepareStatement(MM_dupKeySQL);
  ResultSet MM_rsKey = MM_rsKeyStatement.executeQuery();
  boolean MM_rsKey_isEmpty = !MM_rsKey.next();
  MM_rsKey.close(); // Close the recordset - we have all the info we need.
  MM_rsKeyConn.close();
  if (!MM_rsKey_isEmpty) {
    // the username was found - can not add the requested username
    String MM_qsChar = "?";
    if (MM_dupKeyRedirect.indexOf("?") >= 0) MM_qsChar = "&";
    MM_dupKeyRedirect = MM_dupKeyRedirect + MM_qsChar + "requsername=" + MM_dupKeyUsernameValue;
    response.sendRedirect(response.encodeRedirectURL(MM_dupKeyRedirect));
    return;
  }
}
%>
<%
// *** Insert Record: set variables

if (request.getParameter("MM_insert") != null && request.getParameter("MM_insert").toString().equals("form1")) {

  MM_editDriver     = MM_connWorld_DRIVER;
  MM_editConnection = MM_connWorld_STRING;
  MM_editUserName   = MM_connWorld_USERNAME;
  MM_editPassword   = MM_connWorld_PASSWORD;
  MM_editTable  = "world.user";
  MM_editRedirectUrl = "success.html";
  String MM_fieldsStr = "username|value|password|value|level|value";
  String MM_columnsStr = "username|',none,''|password|',none,''|access|',none,''";

  // create the MM_fields and MM_columns arrays
  java.util.StringTokenizer tokens = new java.util.StringTokenizer(MM_fieldsStr,"|");
  MM_fields = new String[tokens.countTokens()];
  for (int i=0; tokens.hasMoreTokens(); i++) MM_fields[i] = tokens.nextToken();

  tokens = new java.util.StringTokenizer(MM_columnsStr,"|");
  MM_columns = new String[tokens.countTokens()];
  for (int i=0; tokens.hasMoreTokens(); i++) MM_columns[i] = tokens.nextToken();

  // set the form values
  for (int i=0; i+1 < MM_fields.length; i+=2) {
    MM_fields[i+1] = ((request.getParameter(MM_fields[i])!=null)?(String)request.getParameter(MM_fields[i]):"");
  }
 
  // append the query string to the redirect URL
  if (MM_editRedirectUrl.length() != 0 && request.getQueryString() != null) {
    MM_editRedirectUrl += ((MM_editRedirectUrl.indexOf('?') == -1)?"?":"&") + request.getQueryString();
  }
}
%>
<%
// *** Insert Record: construct a sql insert statement and execute it

if (request.getParameter("MM_insert") != null) {

  // create the insert sql statement
  StringBuffer MM_tableValues = new StringBuffer(), MM_dbValues = new StringBuffer();
  for (int i=0; i+1 < MM_fields.length; i+=2) {
    String formVal = MM_fields[i+1];
    String elem;
    java.util.StringTokenizer tokens = new java.util.StringTokenizer(MM_columns[i+1],",");
    String delim    = ((elem = (String)tokens.nextToken()) != null && elem.compareTo("none")!=0)?elem:"";
    String altVal   = ((elem = (String)tokens.nextToken()) != null && elem.compareTo("none")!=0)?elem:"";
    String emptyVal = ((elem = (String)tokens.nextToken()) != null && elem.compareTo("none")!=0)?elem:"";
    if (formVal.length() == 0) {
      formVal = emptyVal;
    } else {
      if (altVal.length() != 0) {
        formVal = altVal;
      } else if (delim.compareTo("'") == 0) {  // escape quotes
        StringBuffer escQuotes = new StringBuffer(formVal);
        for (int j=0; j < escQuotes.length(); j++)
          if (escQuotes.charAt(j) == '\'') escQuotes.insert(j++,'\'');
        formVal = "'" + escQuotes + "'";
      } else {
        formVal = delim + formVal + delim;
      }
    }
    MM_tableValues.append((i!=0)?",":"").append(MM_columns[i]);
    MM_dbValues.append((i!=0)?",":"").append(formVal);
  }
  MM_editQuery = new StringBuffer("insert into " + MM_editTable);
  MM_editQuery.append(" (").append(MM_tableValues.toString()).append(") values (");
  MM_editQuery.append(MM_dbValues.toString()).append(")");
  
  if (!MM_abortEdit) {
    // finish the sql and execute it
    Driver MM_driver = (Driver)Class.forName(MM_editDriver).newInstance();
    Connection MM_connection = DriverManager.getConnection(MM_editConnection,MM_editUserName,MM_editPassword);
    PreparedStatement MM_editStatement = MM_connection.prepareStatement(MM_editQuery.toString());
    MM_editStatement.executeUpdate();
    MM_connection.close();

    // redirect with URL parameters
    if (MM_editRedirectUrl.length() != 0) {
      response.sendRedirect(response.encodeRedirectURL(MM_editRedirectUrl));
      return;
    }
  }
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<form name="form1" method="POST" action="<%=MM_editAction%>">
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
      <td>level</td>
      <td><input name="level" type="text" id="level"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="Submit"></td>
    </tr>
  </table>

    <input type="hidden" name="MM_insert" value="form1">
</form>
</body>
</html>
