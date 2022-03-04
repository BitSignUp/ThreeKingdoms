<%@page import="com.mysql.cj.protocol.a.BinaryResultsetReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="Pack.SqlLink"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- <script type="text/javascript"> location.href = document.referrer; </script> -->
<title>Insert title here</title>
</head>
<body>
	<%
	  request.setCharacterEncoding("UTF-8");
	  String a = request.getParameter("lecture");
	  String b = request.getParameter("id");
	  System.out.println(a + b);

	  SqlLink link = new SqlLink();
	  int c = link.doVote(a, b);
	  link.linkDisconnect();
	  if(c == 2){
	  	response.sendRedirect("voteresult.jsp");
	  }else{
		  response.sendRedirect("fail.jsp");
	  }
	  
	%>
	
</body>
</html>