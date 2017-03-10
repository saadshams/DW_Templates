<cfquery name="Recordset1" datasource="cfartgallery">
SELECT *
FROM APP.ORDERS 
 WHERE ORDERID = #URL.recordID# 
</cfquery>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table border="1" align="center">
  <cfoutput>
  <tr>
    <td>TAX</td>
    <td>#Recordset1.TAX#</td>
  </tr>
  <tr>
    <td>TOTAL</td>
    <td>#Recordset1.TOTAL#</td>
  </tr>
  <tr>
    <td>ORDERDATE</td>
    <td>#Recordset1.ORDERDATE#</td>
  </tr>
  <tr>
    <td>ORDERSTATUSID</td>
    <td>#Recordset1.ORDERSTATUSID#</td>
  </tr>
  <tr>
    <td>CUSTOMERFIRSTNAME</td>
    <td>#Recordset1.CUSTOMERFIRSTNAME#</td>
  </tr>
  <tr>
    <td>CUSTOMERLASTNAME</td>
    <td>#Recordset1.CUSTOMERLASTNAME#</td>
  </tr>
  <tr>
    <td>ADDRESS</td>
    <td>#Recordset1.ADDRESS#</td>
  </tr>
  <tr>
    <td>CITY</td>
    <td>#Recordset1.CITY#</td>
  </tr>
  <tr>
    <td>STATE</td>
    <td>#Recordset1.STATE#</td>
  </tr>
  <tr>
    <td>POSTALCODE</td>
    <td>#Recordset1.POSTALCODE#</td>
  </tr>
  <tr>
    <td>PHONE</td>
    <td>#Recordset1.PHONE#</td>
  </tr>
  </cfoutput>
</table>


</body>
</html>
