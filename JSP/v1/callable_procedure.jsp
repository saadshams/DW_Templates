<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<%@ include file="../Connections/connWorld.jsp" %>
<%

String Callable1__continent = "Asia";
if(request.getParameter("continent") != null){ Callable1__continent = (String)request.getParameter("continent");}

%>
<%

Driver DriverCallable1 = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
Connection ConnCallable1 = DriverManager.getConnection(MM_connWorld_STRING,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
CallableStatement Callable1 = ConnCallable1.prepareCall("{call world.country_hos(?)}");
Object Callable1_data;
Callable1.setString(1,Callable1__continent);
Callable1.execute();
ResultSet rsContinent = Callable1.getResultSet();
boolean rsContinent_isEmpty = !rsContinent.next();
boolean rsContinent_hasData = !rsContinent_isEmpty;
Object rsContinent_data;
int rsContinent_numRows = 0;

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%= (((rsContinent_data = rsContinent.getObject("Name"))==null || rsContinent.wasNull())?"":rsContinent_data)%> 
<%= (((rsContinent_data = rsContinent.getObject("HeadOfState"))==null || rsContinent.wasNull())?"":rsContinent_data)%> 
</body>
</html>
<%
ConnCallable1.close();
%>
