<cfif IsDefined("FORM.FIRSTNAME")>
  <cfquery name="MM_search" datasource="cfartgallery">
  SELECT FIRSTNAME FROM APP.ARTISTS WHERE FIRSTNAME='#FORM.FIRSTNAME#'
  </cfquery>
  <cfif MM_search.RecordCount GTE 1>
    <cflocation url="exists.html?requsername=#FORM.FIRSTNAME#" addtoken="no">
  </cfif>
</cfif>
<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
  <cfquery datasource="cfartgallery">
  INSERT INTO APP.ARTISTS (FIRSTNAME, THEPASSWORD) VALUES (
  <cfif IsDefined("FORM.FIRSTNAME") AND #FORM.FIRSTNAME# NEQ "">
    '#FORM.FIRSTNAME#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.THEPASSWORD") AND #FORM.THEPASSWORD# NEQ "">
    '#FORM.THEPASSWORD#'
      <cfelse>
      NULL
  </cfif>
  )
  </cfquery>
  <cflocation url="success.html?#CGI.QUERY_STRING#">
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<form method="post" name="form1" action="<cfoutput>#CurrentPage#?#CGI.QUERY_STRING#</cfoutput>">
  <table align="center">
    <tr valign="baseline">
      <td nowrap align="right">FIRSTNAME:</td>
      <td><input type="text" name="FIRSTNAME" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">THEPASSWORD:</td>
      <td><input type="text" name="THEPASSWORD" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">&nbsp;</td>
      <td><input type="submit" value="Insert record"></td>
    </tr>
  </table>
  <input type="hidden" name="MM_InsertRecord" value="form1">
</form>
<p>&nbsp;</p>
</body>
</html>
