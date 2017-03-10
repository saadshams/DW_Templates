<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ include file="../Connections/connWorld.jsp" %>
<%
String rsCity__MMColParam = "1";
if (request.getParameter("ID") !=null) {rsCity__MMColParam = (String)request.getParameter("ID");}
%>
<%
Driver DriverrsCity = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
Connection ConnrsCity = DriverManager.getConnection(MM_connWorld_STRING,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
PreparedStatement StatementrsCity = ConnrsCity.prepareStatement("SELECT * FROM world.city WHERE ID > " + rsCity__MMColParam + " ORDER BY Name ASC");
ResultSet rsCity = StatementrsCity.executeQuery();
boolean rsCity_isEmpty = !rsCity.next();
boolean rsCity_hasData = !rsCity_isEmpty;
Object rsCity_data;
int rsCity_numRows = 0;
%>
<%
int Repeat1__numRows = 10;
int Repeat1__index = 0;
rsCity_numRows += Repeat1__numRows;
%>
<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int rsCity_first = 1;
int rsCity_last  = 1;
int rsCity_total = -1;

if (rsCity_isEmpty) {
  rsCity_total = rsCity_first = rsCity_last = 0;
}

//set the number of rows displayed on this page
if (rsCity_numRows == 0) {
  rsCity_numRows = 1;
}
%>
<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (rsCity_total == -1) {

  // count the total records by iterating through the recordset
    for (rsCity_total = 1; rsCity.next(); rsCity_total++);

  // reset the cursor to the beginning
  rsCity.close();
  rsCity = StatementrsCity.executeQuery();
  rsCity_hasData = rsCity.next();

  // set the number of rows displayed on this page
  if (rsCity_numRows < 0 || rsCity_numRows > rsCity_total) {
    rsCity_numRows = rsCity_total;
  }

  // set the first and last displayed record
  rsCity_first = Math.min(rsCity_first, rsCity_total);
  rsCity_last  = Math.min(rsCity_first + rsCity_numRows - 1, rsCity_total);
}
%>
<% String MM_paramName = ""; %>
<%
// *** Move To Record and Go To Record: declare variables

ResultSet MM_rs = rsCity;
int       MM_rsCount = rsCity_total;
int       MM_size = rsCity_numRows;
String    MM_uniqueCol = "";
          MM_paramName = "";
int       MM_offset = 0;
boolean   MM_atTotal = false;
boolean   MM_paramIsDefined = (MM_paramName.length() != 0 && request.getParameter(MM_paramName) != null);
%>
<%
// *** Move To Record: handle 'index' or 'offset' parameter

if (!MM_paramIsDefined && MM_rsCount != 0) {

  //use index parameter if defined, otherwise use offset parameter
  String r = request.getParameter("index");
  if (r==null) r = request.getParameter("offset");
  if (r!=null) MM_offset = Integer.parseInt(r);

  // if we have a record count, check if we are past the end of the recordset
  if (MM_rsCount != -1) {
    if (MM_offset >= MM_rsCount || MM_offset == -1) {  // past end or move last
      if (MM_rsCount % MM_size != 0)    // last page not a full repeat region
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  //move the cursor to the selected record
  int i;
  for (i=0; rsCity_hasData && (i < MM_offset || MM_offset == -1); i++) {
    rsCity_hasData = MM_rs.next();
  }
  if (!rsCity_hasData) MM_offset = i;  // set MM_offset to the last possible record
}
%>
<%
// *** Move To Record: if we dont know the record count, check the display range

if (MM_rsCount == -1) {

  // walk to the end of the display range for this page
  int i;
  for (i=MM_offset; rsCity_hasData && (MM_size < 0 || i < MM_offset + MM_size); i++) {
    rsCity_hasData = MM_rs.next();
  }

  // if we walked off the end of the recordset, set MM_rsCount and MM_size
  if (!rsCity_hasData) {
    MM_rsCount = i;
    if (MM_size < 0 || MM_size > MM_rsCount) MM_size = MM_rsCount;
  }

  // if we walked off the end, set the offset based on page size
  if (!rsCity_hasData && !MM_paramIsDefined) {
    if (MM_offset > MM_rsCount - MM_size || MM_offset == -1) { //check if past end or last
      if (MM_rsCount % MM_size != 0)  //last page has less records than MM_size
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  // reset the cursor to the beginning
  rsCity.close();
  rsCity = StatementrsCity.executeQuery();
  rsCity_hasData = rsCity.next();
  MM_rs = rsCity;

  // move the cursor to the selected record
  for (i=0; rsCity_hasData && i < MM_offset; i++) {
    rsCity_hasData = MM_rs.next();
  }
}
%>
<%
// *** Move To Record: update recordset stats

// set the first and last displayed record
rsCity_first = MM_offset + 1;
rsCity_last  = MM_offset + MM_size;
if (MM_rsCount != -1) {
  rsCity_first = Math.min(rsCity_first, MM_rsCount);
  rsCity_last  = Math.min(rsCity_last, MM_rsCount);
}

// set the boolean used by hide region to check if we are on the last record
MM_atTotal  = (MM_rsCount != -1 && MM_offset + MM_size >= MM_rsCount);
%>
<%
// *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

String MM_keepBoth,MM_keepURL="",MM_keepForm="",MM_keepNone="";
String[] MM_removeList = { "index", MM_paramName };

// create the MM_keepURL string
if (request.getQueryString() != null) {
  MM_keepURL = '&' + request.getQueryString();
  for (int i=0; i < MM_removeList.length && MM_removeList[i].length() != 0; i++) {
  int start = MM_keepURL.indexOf(MM_removeList[i]) - 1;
    if (start >= 0 && MM_keepURL.charAt(start) == '&' &&
        MM_keepURL.charAt(start + MM_removeList[i].length() + 1) == '=') {
      int stop = MM_keepURL.indexOf('&', start + 1);
      if (stop == -1) stop = MM_keepURL.length();
      MM_keepURL = MM_keepURL.substring(0,start) + MM_keepURL.substring(stop);
    }
  }
}

// add the Form variables to the MM_keepForm string
if (request.getParameterNames().hasMoreElements()) {
  java.util.Enumeration items = request.getParameterNames();
  while (items.hasMoreElements()) {
    String nextItem = (String)items.nextElement();
    boolean found = false;
    for (int i=0; !found && i < MM_removeList.length; i++) {
      if (MM_removeList[i].equals(nextItem)) found = true;
    }
    if (!found && MM_keepURL.indexOf('&' + nextItem + '=') == -1) {
      MM_keepForm = MM_keepForm + '&' + nextItem + '=' + java.net.URLEncoder.encode(request.getParameter(nextItem));
    }
  }
}

// create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL + MM_keepForm;
if (MM_keepBoth.length() > 0) MM_keepBoth = MM_keepBoth.substring(1);
if (MM_keepURL.length() > 0)  MM_keepURL = MM_keepURL.substring(1);
if (MM_keepForm.length() > 0) MM_keepForm = MM_keepForm.substring(1);
%>
<%
// *** Move To Record: set the strings for the first, last, next, and previous links

String MM_moveFirst,MM_moveLast,MM_moveNext,MM_movePrev;
{
  String MM_keepMove = MM_keepBoth;  // keep both Form and URL parameters for moves
  String MM_moveParam = "index=";

  // if the page has a repeated region, remove 'offset' from the maintained parameters
  if (MM_size > 1) {
    MM_moveParam = "offset=";
    int start = MM_keepMove.indexOf(MM_moveParam);
    if (start != -1 && (start == 0 || MM_keepMove.charAt(start-1) == '&')) {
      int stop = MM_keepMove.indexOf('&', start);
      if (start == 0 && stop != -1) stop++;
      if (stop == -1) stop = MM_keepMove.length();
      if (start > 0) start--;
      MM_keepMove = MM_keepMove.substring(0,start) + MM_keepMove.substring(stop);
    }
  }

  // set the strings for the move to links
  StringBuffer urlStr = new StringBuffer(request.getRequestURI()).append('?').append(MM_keepMove);
  if (MM_keepMove.length() > 0) urlStr.append('&');
  urlStr.append(MM_moveParam);
  MM_moveFirst = urlStr + "0";
  MM_moveLast  = urlStr + "-1";
  MM_moveNext  = urlStr + Integer.toString(MM_offset+MM_size);
  MM_movePrev  = urlStr + Integer.toString(Math.max(MM_offset-MM_size,0));
}
%>
<html>
<head>
<title>Select 10</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<table width="75%" border="1">
  <tr> 
    <td>ID</td>
    <td>Name</td>
    <td>Country Code</td>
  </tr>
  <% while ((rsCity_hasData)&&(Repeat1__numRows-- != 0)) { %>
  <tr> 
    <td><%=(((rsCity_data = rsCity.getObject("ID"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
    <td><%=(((rsCity_data = rsCity.getObject("Name"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
    <td><%=(((rsCity_data = rsCity.getObject("CountryCode"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
  </tr>
  <%
  Repeat1__index++;
  rsCity_hasData = rsCity.next();
}
%>
</table>
<p>&nbsp;</p>
<table border="0" width="50%" align="center">
  <tr> 
    <td width="23%" align="center"> 
      <% if (MM_offset !=0) { %>
      <a href="<%=MM_moveFirst%>">First</a> 
      <% } /* end MM_offset != 0 */ %>
    </td>
    <td width="31%" align="center"> 
      <% if (MM_offset !=0) { %>
      <a href="<%=MM_movePrev%>">Previous</a> 
      <% } /* end MM_offset != 0 */ %>
    </td>
    <td width="23%" align="center"> 
      <% if (!MM_atTotal) { %>
      <a href="<%=MM_moveNext%>">Next</a> 
      <% } /* end !MM_atTotal */ %>
    </td>
    <td width="23%" align="center"> 
      <% if (!MM_atTotal) { %>
      <a href="<%=MM_moveLast%>">Last</a> 
      <% } /* end !MM_atTotal */ %>
    </td>
  </tr>
</table>
<p>&nbsp; Records <%=(rsCity_first)%> to <%=(rsCity_last)%> of <%=(rsCity_total)%> </p>
</body>
</html>
<%
rsCity.close();
ConnrsCity.close();
%>

