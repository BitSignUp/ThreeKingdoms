<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="Pack.SqlLink"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="../mycss.css">
<title></title>
</head>
<body>
<%
   request.setCharacterEncoding("UTF-8");
 
 
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   

   SqlLink sl = new SqlLink();
   String name = sl.checkManagersLogin(id, pw);
   sl.linkDisconnect();
   
/*    
   session.setAttribute("id", id);
   session.setAttribute("pw", pw);
   session.setAttribute("name", name);
 */   
   
   if(name != null){
      response.sendRedirect("3worldMain.jsp");
   } else{
     response.sendRedirect("3world.jsp");
   }
   %>
</body>
</html>