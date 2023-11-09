<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>방 생성</title>
</head>
<body>
<h2>새로운 방 만들기</h2>

<%--/room-create--%>
<form action="/createRoom" method="POST">
    <label for="roomTitle">방 이름:</label>
    <input type="text" id="roomTitle" name="title" required>
    <label for="chatId">사용자 닉네임:</label>
    <input type="text" id="chatId" name="userNickname" required>
    <button type="submit">새 방 만들기</button>
</form>
</body>
</html>