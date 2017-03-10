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
// *** Update Record: set variables

if (request.getParameter("MM_update") != null &&
    request.getParameter("MM_update").toString().equals("form1") &&
    request.getParameter("MM_recordId") != null) {

  MM_editDriver     = MM_connWorld_DRIVER;
  MM_editConnection = MM_connWorld_STRING;
  MM_editUserName   = MM_connWorld_USERNAME;
  MM_editPassword   = MM_connWorld_PASSWORD;
  MM_editTable  = "world.city";
  MM_editColumn = "ID";
  MM_recordId   = "" + request.getParameter("MM_recordId") + "";
  MM_editRedirectUrl = "success.html";
  String MM_fieldsStr = "ID|value|Name|value|CountryCode|value|District|value|Population|value";
  String MM_columnsStr = "ID|none,none,NULL|Name|',none,''|CountryCode|',none,''|District|',none,''|Population|none,none,NULL";

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
// *** Update Record: construct a sql update statement and execute it

if (request.getParameter("MM_update") != null &&
    request.getParameter("MM_recordId") != null) {

  // create the update sql statement
  MM_editQuery = new StringBuffer("update ").append(MM_editTable).append(" set ");
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
    MM_editQuery.append((i!=0)?",":"").append(MM_columns[i]).append(" = ").append(formVal);
  }
  MM_editQuery.append(" where ").append(MM_editColumn).append(" = ").append(MM_recordId);
  
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
<%
String rsCity__MMColParam = "1";
if (request.getParameter("ID") !=null) {rsCity__MMColParam = (String)request.getParameter("ID");}
%>
<%
Driver DriverrsCity = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
Connection ConnrsCity = DriverManager.getConnection(MM_connWorld_STRING,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
PreparedStatement StatementrsCity = ConnrsCity.prepareStatement("SELECT * FROM world.city WHERE ID = " + rsCity__MMColParam + "");
ResultSet rsCity = StatementrsCity.executeQuery();
boolean rsCity_isEmpty = !rsCity.next();
boolean rsCity_hasData = !rsCity_isEmpty;
Object rsCity_data;
int rsCity_numRows = 0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<form method="post" action="<%=MM_editAction%>" name="form1">
  <table align="center">
    <tr valign="baseline">
      <td nowrap align="right">Name:</td>
      <td>
        <input type="text" name="Name" value="<%=(((rsCity_data = rsCity.getObject("Name"))==null || rsCity.wasNull())?"":rsCity_data)%>" size="32">
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">CountryCode:</td>
      <td>
        <input type="text" name="CountryCode" value="<%=(((rsCity_data = rsCity.getObject("CountryCode"))==null || rsCity.wasNull())?"":rsCity_data)%>" size="32">
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">District:</td>
      <td>
        <input type="text" name="District" value="<%=(((rsCity_data = rsCity.getObject("District"))==null || rsCity.wasNull())?"":rsCity_data)%>" size="32">
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">Population:</td>
      <td>
        <input type="text" name="Population" value="<%=(((rsCity_data = rsCity.getObject("Population"))==null || rsCity.wasNull())?"":rsCity_data)%>" size="32">
      </td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">&nbsp;</td>
      <td>
        <input type="submit" value="Update record">
      </td>
    </tr>
  </table>
  <input type="hidden" name="ID" value="<%=(((rsCity_data = rsCity.getObject("ID"))==null || rsCity.wasNull())?"":rsCity_data)%>" size="32">
  <input type="hidden" name="MM_update" value="form1">
  <input type="hidden" name="MM_recordId" value="<%=(((rsCity_data = rsCity.getObject("ID"))==null || rsCity.wasNull())?"":rsCity_data)%>">
</form>
<p>&nbsp;</p>
</body>
</html>
<%
rsCity.close();
StatementrsCity.close();
ConnrsCity.close();
%>
