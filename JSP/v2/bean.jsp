<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="Bean1" class="TestCollection.MusicCollection" scope="page"/>
<jsp:setProperty name="Bean1" property="*"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<jsp:getProperty name="Bean1" property="albumsSize"/>
<jsp:getProperty name="Bean1" property="albums"/>
</body>
</html>
