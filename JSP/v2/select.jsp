<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../Connections/connWorld.jsp" %>
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
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
rsCity_numRows += Repeat1__numRows;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table border="1">
  <tr>
    <td>ID</td>
    <td>Name</td>
    <td>CountryCode</td>
    <td>District</td>
    <td>Population</td>
  </tr>
  <% while ((rsCity_hasData)&&(Repeat1__numRows-- != 0)) { %>
  <tr>
    <td><%=(((rsCity_data = rsCity.getObject("ID"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
    <td><%=(((rsCity_data = rsCity.getObject("Name"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
    <td><%=(((rsCity_data = rsCity.getObject("CountryCode"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
    <td><%=(((rsCity_data = rsCity.getObject("District"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
    <td><%=(((rsCity_data = rsCity.getObject("Population"))==null || rsCity.wasNull())?"":rsCity_data)%></td>
  </tr>
  <%
  Repeat1__index++;
  rsCity_hasData = rsCity.next();
}
%>
</table>
</body>
</html>
<%
rsCity.close();
StatementrsCity.close();
ConnrsCity.close();
%>
