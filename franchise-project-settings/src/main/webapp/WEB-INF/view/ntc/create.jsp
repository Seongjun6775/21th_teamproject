<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	공지글 게시판
	<form action="insert" method="post">
	공지글 제목: <input type="text" name="NtcTitle"/><br>
	공지글 작성자: <input type="text" name="NtcWriter"/><br>
	공지글 내용: <textarea rows="4" cols="15" name="NtcContent"></textarea>
	<br><br>
	<input type="submit" value="저장"/>
	</form>
</body>
</html>