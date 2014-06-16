<!-- (1) 这个叫  directive   pageEngcoding 编码方式          charset 工作字符集-->
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title> Hello JSP primary </title>
</head>
<body>

<% for(int i = 0; i < 4; i++){  %> <!-- (2) 这个叫 scriptlet -->
   <p> Hello <%= i %> world! </p>  <!-- (3) 这个叫 expression -->
<% } %>

<p> Nice ${header.host} world... </p> <!-- (4) 这个叫 Expression Language -->

</body>
</html>