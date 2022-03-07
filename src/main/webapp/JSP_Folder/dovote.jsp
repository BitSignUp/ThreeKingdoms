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
	  /* String b = request.getParameter("id"); */
	  String id = (String)session.getAttribute("id");
	  
	  
	  SqlLink link = new SqlLink();
	  int success_cnt = link.doVote(a, id);
	  link.linkDisconnect();
	  
	  
	  if(success_cnt == 2){
	  		response.sendRedirect("voteresult.jsp");
	  }
	  else if(success_cnt == -1){
		  response.sendRedirect("fail.jsp");
	  }
	  else{
		  response.sendRedirect("fail.jsp");
	  }
	  
	%>

</body>
</html>