<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<cfparam name="PageNum_rsOrder" default="1">
<cfquery name="rsOrder" datasource="cfartgallery">
SELECT *
FROM APP.ORDERS 
</cfquery>
<cfset MaxRows_rsOrder=10>
<cfset StartRow_rsOrder=Min((PageNum_rsOrder-1)*MaxRows_rsOrder+1,Max(rsOrder.RecordCount,1))>
<cfset EndRow_rsOrder=Min(StartRow_rsOrder+MaxRows_rsOrder-1,rsOrder.RecordCount)>
<cfset TotalPages_rsOrder=Ceiling(rsOrder.RecordCount/MaxRows_rsOrder)>
<cfset QueryString_rsOrder=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_rsOrder,"PageNum_rsOrder=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_rsOrder=ListDeleteAt(QueryString_rsOrder,tempPos,"&")>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table border="1">
  <tr>
    <td>ORDERID</td>
    <td>TAX</td>
    <td>TOTAL</td>
    <td>ORDERDATE</td>
    <td>ORDERSTATUSID</td>
    <td>CUSTOMERFIRSTNAME</td>
    <td>CUSTOMERLASTNAME</td>
    <td>ADDRESS</td>
    <td>CITY</td>
    <td>STATE</td>
    <td>POSTALCODE</td>
    <td>PHONE</td>
  </tr>
  <cfoutput query="rsOrder" startRow="#StartRow_rsOrder#" maxRows="#MaxRows_rsOrder#">
    <tr>
      <td>#rsOrder.ORDERID#</td>
      <td>#rsOrder.TAX#</td>
      <td>#rsOrder.TOTAL#</td>
      <td>#rsOrder.ORDERDATE#</td>
      <td>#rsOrder.ORDERSTATUSID#</td>
      <td>#rsOrder.CUSTOMERFIRSTNAME#</td>
      <td>#rsOrder.CUSTOMERLASTNAME#</td>
      <td>#rsOrder.ADDRESS#</td>
      <td>#rsOrder.CITY#</td>
      <td>#rsOrder.STATE#</td>
      <td>#rsOrder.POSTALCODE#</td>
      <td>#rsOrder.PHONE#</td>
    </tr>
  </cfoutput>
</table>
<p>&nbsp;</p>
<p> <cfoutput>Records #StartRow_rsOrder# to #EndRow_rsOrder# of #rsOrder.RecordCount# </cfoutput>
<table border="0" width="50%" align="center">
  <cfoutput>
    <tr>
      <td width="23%" align="center">
        <cfif PageNum_rsOrder GT 1>
          <a href="#CurrentPage#?PageNum_rsOrder=1#QueryString_rsOrder#">First</a>
        </cfif>
      </td>
      <td width="31%" align="center">
        <cfif PageNum_rsOrder GT 1>
          <a href="#CurrentPage#?PageNum_rsOrder=#Max(DecrementValue(PageNum_rsOrder),1)##QueryString_rsOrder#">Previous</a>
        </cfif>
      </td>
      <td width="23%" align="center">
        <cfif PageNum_rsOrder LT TotalPages_rsOrder>
          <a href="#CurrentPage#?PageNum_rsOrder=#Min(IncrementValue(PageNum_rsOrder),TotalPages_rsOrder)##QueryString_rsOrder#">Next</a>
        </cfif>
      </td>
      <td width="23%" align="center">
        <cfif PageNum_rsOrder LT TotalPages_rsOrder>
          <a href="#CurrentPage#?PageNum_rsOrder=#TotalPages_rsOrder##QueryString_rsOrder#">Last</a>
        </cfif>
      </td>
    </tr>
  </cfoutput>
</table>
</p>
</body>
</html>
