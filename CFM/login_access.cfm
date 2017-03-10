<cfif IsDefined("FORM.username")>
  <cfset MM_redirectLoginSuccess="success.html">
  <cfset MM_redirectLoginFailed="fail.html">
  <cfquery  name="MM_rsUser" datasource="cfartgallery">
  SELECT ARTISTID,ARTNAME,ISSOLD FROM APP.ART WHERE ARTISTID='#FORM.username#' AND ARTNAME='#FORM.password#'
  </cfquery>
  <cfif MM_rsUser.RecordCount NEQ 0>
    <cftry>
      <cflock scope="Session" timeout="30" type="Exclusive">
        <cfset Session.MM_Username=FORM.username>
        <cfset Session.MM_UserAuthorization=MM_rsUser.ISSOLD[1]>
      </cflock>
      <cfif IsDefined("URL.accessdenied") AND true>
        <cfset MM_redirectLoginSuccess=URL.accessdenied>
      </cfif>
      <cflocation url="#MM_redirectLoginSuccess#" addtoken="no">
      <cfcatch type="Lock">
        <!--- code for handling timeout of cflock --->
      </cfcatch>
    </cftry>
  </cfif>
  <cflocation url="#MM_redirectLoginFailed#" addtoken="no">
  <cfelse>
  <cfset MM_LoginAction=CGI.SCRIPT_NAME>
  <cfif CGI.QUERY_STRING NEQ "">
    <cfset MM_LoginAction=MM_LoginAction & "?" & XMLFormat(CGI.QUERY_STRING)>
  </cfif>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<form name="form1" method="POST" action="<cfoutput>#MM_loginAction#</cfoutput>">
  <table width="200" border="1">
    <tr>
      <td>username</td>
      <td><input name="username" type="text" id="username"></td>
    </tr>
    <tr>
      <td>password</td>
      <td><input name="password" type="text" id="password"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>
