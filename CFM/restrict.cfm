<cflock scope="Session" type="ReadOnly" timeout="30" throwontimeout="no">
  <cfset MM_Username=Iif(IsDefined("Session.MM_Username"),"Session.MM_Username",DE(""))>
  <cfset MM_UserAuthorization=Iif(IsDefined("Session.MM_UserAuthorization"),"Session.MM_UserAuthorization",DE(""))>
</cflock>
<cfif MM_Username EQ "" OR MM_UserAuthorization EQ "" OR ListFind("manager,employee",MM_UserAuthorization) EQ 0>
  <cfset MM_referer=CGI.SCRIPT_NAME>
  <cfif CGI.QUERY_STRING NEQ "">
    <cfset MM_referer=MM_referer & "?" & CGI.QUERY_STRING>
  </cfif>
  <cfset MM_failureURL="fail.html?accessdenied=" & URLEncodedFormat(MM_referer)>
  <cflocation url="#MM_failureURL#" addtoken="no">
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

</body>
</html>
