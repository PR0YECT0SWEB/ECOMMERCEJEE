<%@page import="java.util.UUID"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<% 
    SimpleDateFormat formato = new SimpleDateFormat("ddMyyyyhhmmss");
    String referencia = formato.format(new Date()) + UUID.randomUUID();
    String signature = "4Vj8eK4rloUd272L48hsrarnUA~508029~TestPayU~"+ referencia +"~COP";
    
%>

<form method="post" action="https://sandbox.checkout.payulatam.com/ppp-web-gateway-payu/">
  <input name="merchantId"    type="hidden"  value="508029"   >
  <input name="accountId"     type="hidden"  value="512321" >
  <input name="description"   type="hidden"  value="Test PAYU"  >
  <input name="referenceCode" type="hidden"  value="<%= referencia %>" >
  <input name="amount"        type="hidden"  value="${total*1.19}"   >
  <input name="tax"           type="hidden"  value="${total*0.19}"  >
  <input name="taxReturnBase" type="hidden"  value="${0.19}" >
  <input name="currency"      type="hidden"  value="${moneda}" >
  <input name="signature"     type="hidden"  value="7ee7cf808ce6a39b17481c54f2c57acc"  >
  <input name="test"          type="hidden"  value="1" >
  <input name="buyerEmail"    type="hidden"  value="test@test.com" >
  <input name="responseUrl"    type="hidden"  value="http://www.test.com/response" >
  <input name="confirmationUrl"    type="hidden"  value="http://www.test.com/confirmation" >
  <input name="Submit"        type="submit"  value="Enviar" >
</form>