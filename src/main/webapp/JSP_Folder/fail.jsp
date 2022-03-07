<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" type="text/css" href="../mycss.css">
<title>Insert title here</title>
<style>
body {
flex-direction: column;
}
</style>
</head>
<body>
	<div>실패했습니다.</div>
            <div>
            <input class='btn' type='button' onclick='goPage()' value='돌아가기' />
                <script>
                function goPage() { location.href= 'login.jsp' ; }
                </script>
            </div>
</body>
</html>