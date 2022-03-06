<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="Pack.SqlLink"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" type="text/css" href="mycss.css">
	<title>Bit World</title>
</head>
<body>
	<%
	   String id = (String)session.getAttribute("id");
	   String pw = (String)session.getAttribute("pw");
	   SqlLink sl = new SqlLink(); // DB 연결
	   /* String name = sl.checkLogin(id, pw); */
	   int stop = sl.checkVoteCount();
	   int voted = sl.isvoted(id, pw);
	
	   int x = sl.checkVoteCount(); //11
	   int cho = sl.getChoCount(); //2
	   int po = sl.getPoCount();
	   int you = sl.getYouCount();
	   int sum = cho + po + you;
	   
	   %>
	   <%
	   Map<String, Object> map = sl.getSetting();
       int maxNum = (int)map.get("maxVoterNum");
       
       Date finishTime = (Date)map.get("finishTime");
       Date curDate = new Date(); // aws 가면 바뀔 수도 있으니까 확인하기!
       
       int isFinish = (int)map.get("isFinish");
	   %>
	<fieldset id="regbox">

		<legend>메인화면</legend>
		
		<div class="item-group">
		
			<div><button class = "btn" onclick="location.href='JSP_Folder/signup.jsp'"> 회원가입 </button></div> 
			<div><button class = "btn" onclick="location.href='JSP_Folder/login.jsp'"> 로 그 인  </button></div>
			<% if(sum >= maxNum || curDate.after(finishTime) || isFinish == 1){%>
			<div><button class = "btn" onclick="location.href='JSP_Folder/resultfinal.jsp'"> 투표결과  </button></div>
			<% }else{ %>
			<div><button class = "btn" onclick="alert('아직 투표가 진행중입니다.')"> 투표결과  </button></div>
			<%} %>
		</div>
		
   </fieldset>
</body>
</html>