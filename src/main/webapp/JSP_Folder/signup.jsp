<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@  page import = "Pack.SqlLink" %>

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" type="text/css" href="../mycss.css">
<link rel="icon" href="https://board.jinhak.com/BoardV1/Upload/Job/Company/CI/185841.jpg">
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>


<title>Sign up</title>	
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
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

   <form method="post" action = "signup_insert.jsp">

      <fieldset id="regbox">

         <legend>회원가입</legend>

         <div class="item-group">
   
            <div class="input-item-center">
               <label for="id">아이디</label> 
               <input type="text" name="id" id="id" placeholder="4자리 이상 아이디" pattern="^[A-Za-z0-9]{4,15}" 
               maxlength="15" /><br />
            </div>     
   
            <div class="input-item-center">
               <label for="pw">비밀번호</label> 
               <input type="password" name="pw" placeholder="영어와 숫자만 입력" pattern="^[a-zA-Z0-9]{4,15}" 
               maxlength="15"/><br />
            </div>
   
            <div class="input-item-center">
               <label for="email">이름</label> 
               <input type="text" name="name" /><br />
            </div>
   
       
            <div class="input-item-center">
               <label for="birth">생년월일</label> 
               <input type="date" name="birth" max="2000-12-31"/><br />
            </div>
            <div class="button-item-center">
               <input class="btn" type="submit" value="가입">
               <input class="btn" type="reset" value="초기화" />
               <input class="btn" type="button" onclick="goMainPage()" value="돌아가기" />
               <script>
                  function goMainPage() {
                     location.href='../main.jsp';
                  }
               </script>
            </div>
         </div>
      </fieldset>

   </form>



</body>


</html>