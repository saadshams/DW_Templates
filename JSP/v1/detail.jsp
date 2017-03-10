<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ include file="../Connections/connWorld.jsp" %>

<%
String rsCity__MM_ColParam = "1";
if (request.getParameter("ID") !=null) {rsCity__MM_ColParam = (String)request.getParameter("ID");}
%>

<%
Driver DriverrsCity = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
Connection ConnrsCity = DriverManager.getConnection(MM_connWorld_STRING,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
PreparedStatement StatementrsCity = ConnrsCity.prepareStatement("SELECT *  FROM world.city WHERE ID = " + rsCity__MM_ColParam + "");
ResultSet rsCity = StatementrsCity.executeQuery();
boolean rsCity_isEmpty = !rsCity.next();
boolean rsCity_hasData = !rsCity_isEmpty;
Object rsCity_data;
int rsCity_numRows = 0;
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">

  <table align="center" border="1">
  <tr>
    <td align="default" width="50%">ID</td>
    <td align="default" width="50%"><%=(((rsCity_data = rsCity.getObject("ID"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
  </tr>
  <tr>
    <td align="default" width="50%">Name</td>
    <td align="default" width="50%"><%=(((rsCity_data = rsCity.getObject("Name"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
  </tr>
  <tr>
    <td align="default" width="50%">CountryCode</td>
    <td align="default" width="50%"><%=(((rsCity_data = rsCity.getObject("CountryCode"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
  </tr>
  <tr>
    <td align="default" width="50%">District</td>
    <td align="default" width="50%"><%=(((rsCity_data = rsCity.getObject("District"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
  </tr>
  <tr>
    <td align="default" width="50%">Population</td>
    <td align="default" width="50%"><%=(((rsCity_data = rsCity.getObject("Population"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
  </tr>
  </table>
</body>
</html>
<%
rsCity.close();
ConnrsCity.close();
%>

