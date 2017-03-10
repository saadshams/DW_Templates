<cfparam name="URL.ARTID" default="1">
<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<cfif IsDefined("FORM.MM_UpdateRecord") AND FORM.MM_UpdateRecord EQ "form1">
  <cfquery datasource="cfartgallery">
  UPDATE APP.ART SET ARTISTID=
  <cfif IsDefined("FORM.ARTISTID") AND #FORM.ARTISTID# NEQ "">
    #FORM.ARTISTID#
      <cfelse>
      NULL
  </cfif>
  , ARTNAME=
  <cfif IsDefined("FORM.ARTNAME") AND #FORM.ARTNAME# NEQ "">
    '#FORM.ARTNAME#'
      <cfelse>
      NULL
  </cfif>
  , DESCRIPTION=
  <cfif IsDefined("FORM.DESCRIPTION") AND #FORM.DESCRIPTION# NEQ "">
    '#FORM.DESCRIPTION#'
      <cfelse>
      NULL
  </cfif>
  , PRICE=
  <cfif IsDefined("FORM.PRICE") AND #FORM.PRICE# NEQ "">
    #FORM.PRICE#
      <cfelse>
      NULL
  </cfif>
  , LARGEIMAGE=
  <cfif IsDefined("FORM.LARGEIMAGE") AND #FORM.LARGEIMAGE# NEQ "">
    '#FORM.LARGEIMAGE#'
      <cfelse>
      NULL
  </cfif>
  , MEDIAID=
  <cfif IsDefined("FORM.MEDIAID") AND #FORM.MEDIAID# NEQ "">
    #FORM.MEDIAID#
      <cfelse>
      NULL
  </cfif>
  , ISSOLD=
  <cfif IsDefined("FORM.ISSOLD") AND #FORM.ISSOLD# NEQ "">
    #FORM.ISSOLD#
      <cfelse>
      NULL
  </cfif>
  WHERE ARTID=#FORM.ARTID#
  </cfquery>
  <cflocation url="success.html?#CGI.QUERY_STRING#">
</cfif>
<cfquery name="rsOrder" datasource="cfartgallery">
SELECT *
FROM APP.ART
WHERE ARTID = #URL.ARTID# 
</cfquery>
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
      <td nowrap align="right">ARTISTID:</td>
      <td><input type="text" name="ARTISTID" value="<cfoutput>#rsOrder.ARTISTID#</cfoutput>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">ARTNAME:</td>
      <td><input type="text" name="ARTNAME" value="<cfoutput>#rsOrder.ARTNAME#</cfoutput>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">DESCRIPTION:</td>
      <td><input type="text" name="DESCRIPTION" value="<cfoutput>#rsOrder.DESCRIPTION#</cfoutput>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">PRICE:</td>
      <td><input type="text" name="PRICE" value="<cfoutput>#rsOrder.PRICE#</cfoutput>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">LARGEIMAGE:</td>
      <td><input type="text" name="LARGEIMAGE" value="<cfoutput>#rsOrder.LARGEIMAGE#</cfoutput>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">MEDIAID:</td>
      <td><input type="text" name="MEDIAID" value="<cfoutput>#rsOrder.MEDIAID#</cfoutput>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">ISSOLD:</td>
      <td><input type="text" name="ISSOLD" value="<cfoutput>#rsOrder.ISSOLD#</cfoutput>" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">&nbsp;</td>
      <td><input type="submit" value="Update record"></td>
    </tr>
  </table>
  <input type="hidden" name="MM_UpdateRecord" value="form1">
  <input type="hidden" name="ARTID" value="<cfoutput>#rsOrder.ARTID#</cfoutput>">
</form>
<p>&nbsp;</p>
</body>
</html>
