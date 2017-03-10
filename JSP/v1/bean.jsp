<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"%>
<jsp:useBean id="Bean1" class="TestCollection.Album" scope="page"/>
<jsp:setProperty name="Bean1" property="artist" value="artist"/>
<jsp:setProperty name="Bean1" property="class" value="class"/>
<jsp:setProperty name="Bean1" property="title" value="title"/>
<jsp:setProperty name="Bean1" property="year" value="year"/>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<table width="75%" border="1">
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <jsp:getProperty name="Bean1" property="artist"/>
    </td>
    <td> 
      <jsp:getProperty name="Bean1" property="class"/>
    </td>
    <td> 
      <jsp:getProperty name="Bean1" property="title"/>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>

