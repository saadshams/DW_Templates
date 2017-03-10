<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<cfif IsDefined("FORM.MM_InsertRecord") AND FORM.MM_InsertRecord EQ "form1">
  <cfquery datasource="cfartgallery">
  INSERT INTO APP.ORDERS (TAX, TOTAL, ORDERDATE, ORDERSTATUSID, CUSTOMERFIRSTNAME, CUSTOMERLASTNAME, ADDRESS, CITY,"STATE", POSTALCODE, PHONE) VALUES (
  <cfif IsDefined("FORM.TAX") AND #FORM.TAX# NEQ "">
    #FORM.TAX#
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.TOTAL") AND #FORM.TOTAL# NEQ "">
    #FORM.TOTAL#
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.ORDERDATE") AND #FORM.ORDERDATE# NEQ "">
    '#FORM.ORDERDATE#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.ORDERSTATUSID") AND #FORM.ORDERSTATUSID# NEQ "">
    #FORM.ORDERSTATUSID#
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.CUSTOMERFIRSTNAME") AND #FORM.CUSTOMERFIRSTNAME# NEQ "">
    '#FORM.CUSTOMERFIRSTNAME#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.CUSTOMERLASTNAME") AND #FORM.CUSTOMERLASTNAME# NEQ "">
    '#FORM.CUSTOMERLASTNAME#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.ADDRESS") AND #FORM.ADDRESS# NEQ "">
    '#FORM.ADDRESS#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.CITY") AND #FORM.CITY# NEQ "">
    '#FORM.CITY#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.STATE") AND #FORM.STATE# NEQ "">
    '#FORM.STATE#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.POSTALCODE") AND #FORM.POSTALCODE# NEQ "">
    '#FORM.POSTALCODE#'
      <cfelse>
      NULL
  </cfif>
  ,
  <cfif IsDefined("FORM.PHONE") AND #FORM.PHONE# NEQ "">
    '#FORM.PHONE#'
      <cfelse>
      NULL
  </cfif>
  )
  </cfquery>
  <cflocation url="success.html">
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<form method="post" name="form1" action="<cfoutput>#CurrentPage#</cfoutput>">
  <table align="center">
    <tr valign="baseline">
      <td nowrap align="right">TAX:</td>
      <td><input type="text" name="TAX" value="10000" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">TOTAL:</td>
      <td><input type="text" name="TOTAL" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">ORDERDATE:</td>
      <td><input type="text" name="ORDERDATE" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">ORDERSTATUSID:</td>
      <td><input type="text" name="ORDERSTATUSID" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">CUSTOMERFIRSTNAME:</td>
      <td><input type="text" name="CUSTOMERFIRSTNAME" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">CUSTOMERLASTNAME:</td>
      <td><input type="text" name="CUSTOMERLASTNAME" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">ADDRESS:</td>
      <td><input type="text" name="ADDRESS" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">CITY:</td>
      <td><input type="text" name="CITY" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">STATE:</td>
      <td><input type="text" name="STATE" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">POSTALCODE:</td>
      <td><input type="text" name="POSTALCODE" value="" size="32"></td>
    </tr>
    <tr valign="baseline">
      <td nowrap align="right">PHONE:</td>
      <td><input type="text" name="PHONE" value="" size="32"></td>
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
