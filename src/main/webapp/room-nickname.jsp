<%--
  Created by IntelliJ IDEA.
  User: kky
  Date: 2023/11/07
  Time: 2:03 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Orbit&display=swap" rel="stylesheet">
    <title>Omok_login</title>
    <script>
        function gameStart() {
            var id = document.getElementById("chatId");
            if(id.value =="" ){
                alert("아이디 입력해 주세요.");
            }
        }
    </script>
    <style>
        *{
            background-color: oldlace;
            text-align: center;
        }
        .main{
            width: 1440px;
            height: 1024px;
            padding: 100;
            text-align: center;

        }
        p{
            font-size: 90px;
            background-color: white;
            font-weight: 400;
            font-family: 'East Sea Dokdo', sans-serif;
        }
        h2{
            background-color: white;
            text-align: left;
            margin-left: 50px;
        }
        .loginLine{
            width: 600px;
            height: 600px;
            margin: 0 auto;
            text-align: center;
            border: 0px solid black;
            border-radius: 100px;
            background-color: white;
            color: orange;
        }
        #chatId{
            width: 500px;
            height: 60px;
            text-align: center;
            border: 0px solid black;
            border-radius: 100px;
            background-color: cornsilk;
            color: orange;
        }
        #playbtn{
            width: 200px;
            height: 50px;
            text-align: center;
            font-size: 40px;
            font-weight: 300;
            border: 0px solid black;
            border-radius: 100px;
            background-image:url(img/monarch-2873979_1280.png);
            color:white;
            font-family: 'East Sea Dokdo', sans-serif;
        }
        .foot{
            font-size: 15px;
            font-family: 'Orbit', sans-serif;
        }
    </style>

</head>
<body>
<div style="width: 1000px; height: 200px;">
</div>
<form action="/createRoom" method="POST">
    <fieldsete class="main">
        <img src="img/orange-1618917_1280.png" width="80px">
        <img src="img/orange-1618917_1280.png" width="80px">
        <img src="img/orange-1618917_1280.png" width="80px">
        <img src="img/orange-1618917_1280.png" width="80px">
        <img src="img/orange-1618917_1280.png" width="80px">
        <fieldset class="loginLine">
            <p>모두의 오목</p>
            <h2>login</h2>
            <br>
            <label for="chatId">사용자 닉네임</label>
            <input type="text"  id="chatId" name="userNickname" placeholder="ID를 입력하세요" required><br>
            <br>
            <br>
            <input type="submit" id="playbtn" value="게임시작" onclick="gameStart();"></a>
        </fieldset>
        <br>
        <div class="foot"> 신한DS SW 아카데미 <br>
            주소: 서울특별시 마포구 월드컵북로 4길 77 <br>
            만든이 : 1조 (이태성, 김고은, 이규빈 김경영, 윤채원) <br>
        </div>
        </fieldset>
</form>
</body>
</html>