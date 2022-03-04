<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  page import = "Pack.SqlLink" %>

<link rel="stylesheet" type="text/css" href="../mycss.css">
<!DOCTYPE html>
<html>
<head>
<style>
	body{flex-direction : column}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div>	
	<%
	  SqlLink link = new SqlLink();
	  request.setCharacterEncoding("UTF-8");
	  String id      = request.getParameter("id");
	  String pwd      = request.getParameter("pw");
	  String name      = request.getParameter("name");
	  String birth    = request.getParameter("birth");
	  String  url;
	  id = id.trim();
	  pwd = pwd.trim();
	  name = name.trim();
	  birth = birth.trim();
	  
	  if(id==""||pwd==""||name==""||birth=="")
	  {
		  out.println("모든 값을 입력해주세요.");
		  url = "signup.jsp";
	  }
	
	 
	 
	 else{
	  int a = link.signUp(id, pwd, name, birth);
	  link.linkDisconnect();
	  
	  if(a==1) {
		  out.println("가입에 성공했습니다. ");
		  url = "../main.jsp";
	  }
	  
	  else 
		  {
		  if(a== -1) out.println("중복으로 인해 가입이 실패했습니다. ");
		  else if(a== -2) out.println("가입에 실패했습니다. "); 
		  url = "signup.jsp";
		  }
	 }
	 
	%>
	
	
	
	</div>
	<div>
	<input class="btn" type="button" onclick="goMainPage()" value="돌아가기" />
               <script>
                  function goMainPage() {
                     location.href= "<%= url %>" ;
                  }
               </script>
	</div>
</body>
</html>