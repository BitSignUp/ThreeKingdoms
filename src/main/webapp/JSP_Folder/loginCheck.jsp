<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="Pack.SqlLink"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../mycss.css">
<meta charset="EUC-KR">
<title>Login Check</title>
</head>
<style>
body {
	flex-direction: column;
}
</style>
<body>
	<%
   request.setCharacterEncoding("UTF-8");
 
 
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");
   

   SqlLink sl = new SqlLink();
   String name = sl.checkLogin(id, pw);
   sl.linkDisconnect();
   
   session.setAttribute("id", id);
   session.setAttribute("pw", pw);
   session.setAttribute("name", name);
   
   
   if(name != null){
      response.sendRedirect("vote.jsp");
   } else{
      out.println(""
            + "<div>로그인에 실패했습니다.</div>"
            + "<div>"
            + "<input class='btn' type='button' onclick='goPage()' value='돌아가기' />"
                + "<script>"
                + "function goPage() { location.href= 'login.jsp' ; }"
                + "</script>"
            + "</div>"
      );
   }
   %>

</body>
</html>