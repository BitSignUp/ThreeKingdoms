<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="Pack.SqlLink"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>This is vote program</title>

<link rel="stylesheet" type="text/css" href="../mycss.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"> 
</script>

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
	<script>
	$(document).ready(function() {
		$(".go_login").click(function(){
			console.log("123213");
		    if(confirm("로그인을 하셔야 합니다. 로그인 페이지로 이동하시겠습니까?") == true){
		    	alert("페이지로 이동합니다.");
		    	location.href = "login.jsp";
		    }
		    else{
		        return ;
		    }
		})
	});
	</script>
	<%
	/* 뒤로가기 시 새 페이지로 불로오기 위함 */
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 1L);
	%>

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

	<form method="post" action="dovote.jsp"
		style="display: flex; flex-direction: row;">

		<fieldset class="cheetah">
			<legend>초선</legend>
			<div id="girl1" contentEditable='true'>
				<image src="image/girl1.jpg" border="3"
					style="width : 300px; height: 500px;">
			</div>
			<div>
				<label><input type="radio" name="lecture" value="초선" checked>
					초선에게투표</label> <br>
			</div>
		</fieldset>

		<fieldset class="cheetah">
			<legend>여포</legend>
			<div id="men1" contentEditable='true'>
				<image src="image/men1.jpg" border="3"
					style="width : 300px; height: 500px;">
			</div>
			<div>
				<label><input type="radio" name="lecture" value="여포" checked>
					여포에게투표</label> <br>
			</div>
		</fieldset>

		<fieldset class="cheetah">
			<legend>유비</legend>
			<div id="man2" contentEditable='true'>
				<image src="image/men2.jpg" border="3"
					style="width : 300px; height: 500px;">
			</div>
			<div>
				<label><input type="radio" name="lecture" value="유비" checked>
					유비에게투표</label> <br>
			</div>

		</fieldset>

		<fieldset class="cheetah">
			<legend>☞☜</legend>
			<h3 style="text-align: center;">
				<%=id%>님 안녕하십니까
			</h3>

			<%
			Map<String, Object> map = sl.getSetting();
			int maxNum = (int)map.get("maxVoterNum");
			
			Date finishTime = (Date)map.get("finishTime");
			Date curDate = new Date(); // aws 가면 바뀔 수도 있으니까 확인하기!
			
			int isFinish = (int)map.get("isFinish");
			if(sum >= maxNum || curDate.after(finishTime) || isFinish == 1){  // 투표가 종료된 경우
				out.print("<h3 style='text-align:center;'> 투표가 종료되었습니다.</h3>");
				out.print("<h3 style='text-align:center;'> 감사합니다. </h3>");
				out.print("<input style='padding: 20px 106px 20px; font-size: 1.5rem'");
				out.print("class='btn' type='button' value='최종결과'");
				out.print("onclick=location.href='resultfinal.jsp'>");
			}else{	// 투표가 종료되지 않았을때
				if(id != null && voted == 0){ %>
					<input style="padding: 20px 106px 20px; font-size: 1.5rem"
					class="btn" type="submit" value="투표하기"
					onclick="alert('투표가완료되었습니다. 앙 감사합니다.')">
					<input style='padding: 20px 106px 20px; font-size: 1.5rem'
					class='btn' type='button' value='투표현황'
					onclick="alert('투표를 해주세요. 앙 감사합니다.')">
				<%}else if (id != null && voted > 0){%>
					<input style="padding: 20px 106px 20px; font-size: 1.5rem"
					class="btn" type="button" value="투표하기"
					onclick="alert('이미 투표를 하셨습니다. 앙 감사합니다.')">
					<input style='padding: 20px 106px 20px; font-size: 1.5rem'
					class='btn' type='button' value='투표현황'
					onclick="location.href='voteresult.jsp'">
				<%}else if (id == null){%>
					<input style="padding: 20px 106px 20px; font-size: 1.5rem"
					class="btn go_login" type="button" value="투표하기">
					<input style='padding: 20px 106px 20px; font-size: 1.5rem'
					class='btn go_login' type='button' value='투표현황'>
				<%}
				/* out.print("<input style='padding: 20px 106px 20px; font-size: 1.5rem'");
				out.print("class='btn' type='button' value='투표현황'");
				out.print("onclick=location.href='voteresult.jsp'>"); */
			}
			%>



			<!-- 삼국지이미지.gif 출력 -->
			<input type="image" src="image/3world.gif" border="3"
				style="width: 370px; height: 180px;">

			<!-- 투표자 id 넘겨주기 -->
			<input type="hidden" name="id" value=<%= id %>>
		</fieldset>
	</form>



<% sl.linkDisconnect(); %>
</body>

</html>


