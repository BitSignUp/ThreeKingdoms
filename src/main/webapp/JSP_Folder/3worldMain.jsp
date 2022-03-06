<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@  page import = "Pack.SqlLink" %>

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../mycss.css">
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>


<title>Sign up</title>	

<style type="text/css">




#regbox {
   width: 400px;
   height: 530px;
   display: flex;
   align-items: center;
   justify-content: center;
}

.input-item-center {
   display: flex;
   justify-content: center;
   flex-direction: column;
}

.button-item-center {
   display: flex;
   justify-content: center;
}

.button-item-center input {
   margin-left : 10px;
}

input[type="text"]{
   display: inline-block;
   background: transparent;
   font-weight: 100;
   font-style: normal;
   font-size: 1rem;
   letter-spacing: 0.3em;
   color: rgba(223, 190, 106, 0.7);
   border-radius: 0;
   transition: all 0.7s ease-out;
   background: linear-gradient(270deg, rgba(223, 190, 106, 0.8),
      rgba(146, 111, 52, 0.8), rgba(34, 34, 34, 0), rgba(34, 34, 34, 0));
   background-position: 1% 50%;
   background-size: 300% 300%;
   text-decoration: none;
}
input[type="password"]{
   display: inline-block;
   background: transparent;
   font-weight: 100;
   font-style: normal;
   font-size: 1rem;
   letter-spacing: 0.3em;
   color: rgba(223, 190, 106, 0.7);
   border-radius: 0;
   transition: all 0.7s ease-out;
   background: linear-gradient(270deg, rgba(223, 190, 106, 0.8),
      rgba(146, 111, 52, 0.8), rgba(34, 34, 34, 0), rgba(34, 34, 34, 0));
   background-position: 1% 50%;
   background-size: 300% 300%;
   text-decoration: none;
}

</style>

</head>
<body>

<%
//적용 버튼 누른 경우, 각 입력창의 값들을 디비에 적용시킨다.
request.setCharacterEncoding("UTF-8");
String isApply = request.getParameter("apply");
System.out.println("isApply : " + isApply);
if(isApply != null && isApply.equals("apply")){
	String maxVoterNum = request.getParameter("maxVoterNum");
	String finishTime  = request.getParameter("finishTime");
	String isFinish    = request.getParameter("isFinish");
	
	System.out.println("데이터 내용 : " + maxVoterNum + ", " + finishTime + ", " + isFinish);

	if(maxVoterNum != null && finishTime != null && isFinish != null) {
		int maxVoterNumInt = Integer.parseInt(maxVoterNum);
		int isFinishInt    = Integer.parseInt(isFinish);
		
		SqlLink sl = new SqlLink();
		sl.setSetting(maxVoterNumInt, finishTime, isFinishInt);
		sl.linkDisconnect();
	}	
}


// 페이지에 들어오게 되면 각 입력창에 기존 값들을 불러온다.
SqlLink sl = new SqlLink();
Map<String, Object> map = sl.getSetting();
int maxVoterNum = (int)map.get("maxVoterNum");
Date finishTime = (Date)map.get("finishTime");
int isFinish = (int)map.get("isFinish");
sl.linkDisconnect();

System.out.println("page : " + maxVoterNum + ", " + finishTime + ", " + isFinish);
%>


   <form method="post" action = "3worldMain.jsp">

      <fieldset id="regbox">

         <legend>투표 설정</legend>

         <div class="item-group">
   
            <div class="input-item-center">
               <label for="maxVoterNum">최대 투표 인원</label> 
               <input type="text" name="maxVoterNum" value="<%= maxVoterNum %>"/><br />
            </div>     
   
            <div class="input-item-center">
               <label for="finishTime">투표 종료 시간</label> 
               <input type="text" name="finishTime" placeholder="YYYY-MM-DD hh:mm:ss.S" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{1}" value="<%= finishTime %>"/><br />
            </div>
   
            <div class="input-item-center">
               <label>투표 시작/종료</label> 
               <input type="text" name="isFinish" placeholder="진행 : 0, 종료 : 1" pattern="[0-1]{1}" value="<%= isFinish %>"/><br />
            </div>
   
   			<div class="input-item-center">
   			   <input type="submit" class="btn" value="적용"/>
   			   <input type="hidden" name="apply" value="apply"/>
               
               <input type="button" class="btn" name="exit" value="나가기" onclick="goPage()" />
               <script>
                  function goPage() {
                     location.href='3world.jsp';
                  }
               </script>
            </div>
         </div>
      </fieldset>

   </form>



</body>


</html>