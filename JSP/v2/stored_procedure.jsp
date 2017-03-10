<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="../Connections/connWorld.jsp" %>
<%

String Callable1__con = "Asia";
if(request.getParameter("con") != null){ Callable1__con = (String)request.getParameter("con");}

%>
<%

Driver DriverCallable1 = (Driver)Class.forName(MM_connWorld_DRIVER).newInstance();
Connection ConnCallable1 = DriverManager.getConnection(MM_connWorld_STRING,MM_connWorld_USERNAME,MM_connWorld_PASSWORD);
CallableStatement Callable1 = ConnCallable1.prepareCall("{call world.country_hos(?)}");
Object Callable1_data;
Callable1.setString(1,Callable1__con);
Callable1.execute();
ResultSet rsCity = Callable1.getResultSet();
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

</body>
</html>
<%
ConnCallable1.close();
%>
