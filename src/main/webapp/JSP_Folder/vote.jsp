<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="Pack.SqlLink"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>This is vote program</title>
<link rel="stylesheet" type="text/css" href="../mycss.css">

<style>
.cheetah {
   width: 300px;
   height: 550px;
   border: 1px solid rgba(223, 190, 106, 0.3);
   border: 2px groove(internal value);
}

</style>


</head>
<body>

	<%
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 1L);
	%>
	
   <%
   String id = request.getParameter("id");
   String pw = request.getParameter("pw");

   SqlLink sl = new SqlLink(); // DB 연결
   String name = sl.checkLogin(id, pw);
   int stop = sl.checkVoteCount();
   int voted = sl.isvoted(id, pw);
   sl.linkDisconnect();
   
   System.out.println(id + ", " + pw + ", " + name);
   %>

   <form method="post" action="dovote.jsp" style = " display: flex; flex-direction: row;">

      <fieldset class="cheetah">
         <legend>초선</legend>
            <div id = "girl1" contentEditable = 'true'>
               <input type="image" src="image/girl1.jpg" border = "3" style = "width : 300px; height: 500px;">
            </div>
            <div>
               <label><input type="radio" name="lecture" value="초선" checked> 초선에게투표</label> <br>
            </div>
      </fieldset>
      
      <fieldset class="cheetah">
         <legend>여포</legend>
            <div id = "men1" contentEditable = 'true'>
               <input type="image" src="image/men1.jpg" border = "3" style = "width : 300px; height: 500px;">
            </div>   
            <div>
               <label><input type="radio" name="lecture" value="여포" checked> 여포에게투표</label> <br>
            </div>
      </fieldset>
      
      <fieldset class="cheetah">
         <legend>유비</legend>
            <div id = "man2" contentEditable = 'true'>
               <input type="image" src="image/men2.jpg" border = "3" style = "width : 300px; height: 500px;">
            </div>   
            <div>
               <label><input type="radio" name="lecture" value="유비" checked> 유비에게투표</label> <br>
            </div>
            
      </fieldset>

     <fieldset class="cheetah">
         <legend>☞☜</legend>
         <h3 style = "text-align : center;"> <%=id%>님 안녕하십니까 </h3>
            <!-- 로그인을 한경우 투표가능, else 회원가입이 필요합니다.  -->
            <%if(stop >= 23){
            %>
            	<input style = "padding : 20px 106px 20px;
                font-size: 1.5rem "  class="btn" type="button" value="투표하기" 
                onclick="alert('투표 종료 되었따 윤호야. 앙 감사합니다.')">
            
            <%
            }else if(id != null && voted != 0){
            %>
            	<input style = "padding : 20px 106px 20px;
                font-size: 1.5rem "  class="btn" type="button" value="투표하기" 
                onclick="alert('이미 투표를 하셨습니다. 앙 감사합니다.')">
            <%
            }else if(id != null && voted ==0){
            %>
               
                <input style = "padding : 20px 106px 20px;
                 font-size: 1.5rem "  class="btn" type="submit" value="투표하기" 
                 onclick="alert('투표가완료되었습니다. 앙 감사합니다.')">   
            <%
            }else{
            
            %>
               <input style = "padding : 20px 106px 20px;
                font-size: 1.5rem "  class="btn" type="button" value="투표하기" 
                onclick="alert('회원가입이 필요합니다. 앙 감사합니다.')">
            <%
            }
            
            %>
            
            
            
            <!-- 투표한경우(voted 가 1 인경우) 집계확인가능 else 불가능 -->
            
            <% if(voted >= 1) {
            %>
            	
                <input style = "padding : 20px 106px 20px; font-size: 1.5rem" class="btn" type="submit" value="결과보기" onclick="alert('결과페이지로 이동합니다.')">
                
            <%    
               }else{
            
            %>
               <input style = "padding : 20px 106px 20px; font-size: 1.5rem "  class="btn" type="button" value="결과보기" onclick="alert('투표를 하지 않았습니다.')">
            <%
               }
            
            %>       
         
            
            
            <!-- 삼국지이미지.gif 출력 -->
            <input type="image" src="image/3world.gif" border = "3" style = "width : 370px; height: 180px;">
            
            <!-- 투표자 id 넘겨주기 -->
            <input type="hidden" name="id" value=<%=id%>>
      </fieldset>
   </form>
   
   
   
   

</body>
</html>