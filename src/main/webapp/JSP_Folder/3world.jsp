<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% %>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <link rel="stylesheet" type="text/css" href="../mycss.css">
   <style>
      
      #regbox {
         width: 400px;
         height: 300px;
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
   <title>3 World</title>
</head>
<body>

   <form method="post" action="3worldCheck.jsp">

      <fieldset id="regbox">

         <legend>로그인</legend>

         <div class="item-group">
            <div class="input-item-center">
               <label for="id">아이디</label> <input type="text" name="id" value="3world"/><br />
            </div>

            <div class="input-item-center">
               <label for="pw">비밀번호</label> <input type="password" name="pw" value="1234"/><br />
            </div>
            
            <div class="button-item-center">
               <input class="btn" type="submit" style="margin-right: 10px;" value="로그인" >
            </div>
         </div>
      </fieldset>

   </form>
</body>
</html>