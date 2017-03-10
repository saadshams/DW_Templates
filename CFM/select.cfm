<cfquery name="rsOrder" datasource="cfartgallery">
SELECT *
FROM APP.ORDERS 
</cfquery>
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
  <cfoutput query="rsOrder">
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
</body>
</html>
