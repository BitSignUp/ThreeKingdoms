<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Pack.SqlLink"%>
<%@ page import="java.lang.Math"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../mycss.css">
<link rel="icon" href="https://board.jinhak.com/BoardV1/Upload/Job/Company/CI/185841.jpg">
<style>
html {
	height: 95%;
}

body {
	height: 100%;
	width: 100%;
	background: #231f20;
	color: rgba(223, 190, 106, 0.7);
	font-family: "Helvetica Neue", Helvetica, Arials, sans;
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
}

.ratio {
	padding-top: 20px
}

.ratio li {
	float: left;
	position: relative;
	width: 100px;
	height: 300px;
	margin-right: 10px;
	list-style: none;
	color: yellow;
}

.ratio div {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 100%;
	background: url(JSP_Folder/image/girl1.jpg) repeat;
	font-size: 0;
	color: yellow;
}

.ratio em {
	position: absolute;
	top: -20px;
	width: 100%;
	font-size: 12px;
	font-weight: bold;
	text-align: center;
	color: yellow;
}

.voteresult_label {
	position: absolute;
	text-align: center;
}

#absolute {
	background: yellow;
	position: absolute;
	right: 0;
}

#parent {
	position: relative;
	width: 100px;
	height: 100px;
	background: skyblue;
}

#child {
	position: absolute;
	right: 0;
}

h1 {
	text-align: center;
}
</style>

<title>voteresult</title>
</head>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();"
	onunload="">
	<%
		request.setCharacterEncoding("UTF-8");

		SqlLink sl = new SqlLink(); // DB 연결
		double x = (double)sl.checkVoteCount(); //11
		double cho = (double)sl.getChoCount(); //2
		double po = (double)sl.getPoCount();
		double you = (double)sl.getYouCount();
		int sum = (int)cho + (int)po + (int)you;
		
		sl.linkDisconnect();
	%>
	
	<!-- 동률 -->
	<%if(cho == po && po == you){
		out.println("<div class='www'>");
		out.println("<h1> 동률로 당선자가 없습니다. </h1>");
		out.println("</div>");
	}
	%>
	<%if(cho == po && po > you){
		out.println("<div class='www'>");
		out.println("<h1> 초선과 여포 동률 </h1>");
		out.println("<image src='image/girl1.jpg' height='280' width='280'>");
		out.println("<image src='image/men1.jpg' height='280' width='280'>");
		out.println("<h1> 당선자가 없습니다. </h1>");
		out.println("</div>");
	}
	%>
	<%if(cho == you && you > po){
		out.println("<div class='www'>");
		out.println("<h1> 초선과 유비 동률 </h1>");
		out.println("<image src='image/girl1.jpg' height='280' width='280'>");
		out.println("<image src='image/men2.jpg' height='280' width='280'>");
		out.println("<h1> 당선자가 없습니다. </h1>");
		out.println("</div>");
	}
	%>
	<%if(po == you && you > cho){
		out.println("<div class='www'>");
		out.println("<h1> 유비와 여포 동률 </h1>");
		out.println("<image src='image/men1.jpg' height='280' width='280'>");
		out.println("<image src='image/men2.jpg' height='280' width='280'>");
		out.println("<h1> 당선자가 없습니다. </h1>");
		out.println("</div>");
	}
	%>
	
	<!-- 당선자 -->
	<%if(cho > po && cho > you){

		out.println("<div class='www'>");
		out.println("<h1>초선 당선</h1>");
		out.println("<image src='image/girl1.jpg' height='280' width='280'>");
		out.println("</div>");
	}%>
	<%if(po > cho && po > you){
		out.println("<div class='www'>");
		out.println("<h1>여포 당선</h1>");
		out.println("<image src='image/men1.jpg' height='280' width='280'>");
		out.println("</div>");
	}%>
	<%if(you > cho && you > po){
		out.println("<div class='www'>");
		out.println("<h1>유비 당선</h1>");
		out.println("<image src='image/men2.jpg' height='280' width='280'>");
		out.println("</div>");
	}%>
	<!-- 보낸거 받음 -->
	<!-- 받아야할 데이터 -->
	<!-- 받은 것을 switch문으로 girl01 -> 초선, 여포, 유비로 바꿔준다. -->

	<!-- DB 에 넣는다. -->
	<div class="vote">
		<ul class="ratio">
			<li>
				<div
					style="height:<%= cho/x*100 %>%; background:url(image/girl1.jpg) repeat;">
					<em><%= Math.round(cho/sum*100) %>%</em>
					<div class="voteresult_label">
						<label
							style="color: yellow; font-size: 20px; position: relative; top: 30px;">초선</label>
					</div>
				</div>
			</li>
			<li>
				<div
					style="height:<%= po/x*100 %>%; background:url(image/girl1.jpg) repeat;">
					<em><%= Math.round(po/sum*100) %>%</em>
					<div class="voteresult_label">
						<label
							style="color: yellow; font-size: 20px; position: relative; top: 30px;">여포</label>
					</div>
				</div>
			</li>
			<li>
				<div
					style="height:<%= you/x*100 %>%; background:url(image/girl1.jpg) repeat;">
					<em><%= Math.round(you/sum*100) %>%</em>
					<div class="voteresult_label">
						<label
							style="color: yellow; font-size: 20px; position: relative; top: 30px;">유비</label>
					</div>
				</div>				
			</li>
		</ul>
	</div>
		<div>
			<!-- <button onclick="location.href='../main.jsp'">돌아가기</button> -->
			<input style="padding: 40px; font-size: 1.5rem"
			class="btn" type="button" value="돌아가기"
			onclick="location.href='../main.jsp'">
		</div>
</body>
</html>




