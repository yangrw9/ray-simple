<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- (5a) 导入 custom JSP tag （外面要有个 jar 配合，该是 实现库） -->    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello JSP with Tags</title>
</head>
<body>
   <c:forEach var="i" begin="1" end="5">   <!-- (5b) 这个叫 custom JSP tag -->
     <p> Welcome to <c:out value="${i}"/> world! </p>
   </c:forEach>
</body>
</html>