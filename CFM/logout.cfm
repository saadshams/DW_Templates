<cftry>
  <cflock scope="Session" type="Exclusive" timeout="30">
    <cfset Session.MM_Username="">
    <cfset Session.MM_UserAuthorization="">
  </cflock>
  <cflocation url="success.html" addtoken="no">
  <cfcatch type="Lock">
    <!--- code for handling timeout of cflock --->
  </cfcatch>
</cftry>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

</body>
</html>
