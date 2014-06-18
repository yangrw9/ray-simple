<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/src.js" charset="UTF-8"></script>
<title>Insert title here</title>
</head>
<body>
	<select id="district" onchange="cascade(this.value)"> <!-- (1a) 关联事件处理函数 ，转 src.js -->
		<option value="-1">请选择</option>
		<c:forEach items="${districts }" var="district">
			<option value="${district.id }">${district.name }</option>
		</c:forEach>
	</select>
	<select id="street" onchange="alert(this.value)">
		<option>请选择</option>
	</select>
</body>
</html>