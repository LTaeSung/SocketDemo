<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.socketdemo.Room" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
  <title>makeroom</title>
  <style>
    *{
      background-color: oldlace;
      text-align: center;
    }
    #container{
      width: 1440px;
      height: 1024px;
      margin: 4px auto;

    }
    #header{

      height: 170px;
      margin: 0 auto;
      text-align: center;
      font-size: 10px;
      color: orange;
      font-family: 'East Sea Dokdo', sans-serif;
      background-color: oldlace;
    }
    p{
      font-size: 40px;
      color: orange;
      margin-top: 0;
      margin-bottom: 0;
      text-align: center;
      font-family: 'East Sea Dokdo', sans-serif;
    }
    a{
      text-decoration-line: none;
    }

    #roomTitle{
      width: 200px;
      height: 35px;
      color: white;
      background-color: orange;
      border: 0px orange;
      border-radius: 100px;
      text-align: left;
    }
    #idbox{
      width: 200px;
      height: 35px;
      color: white;
      background-color: orange;
      border: 0px orange;
      border-radius: 100px;
      text-align: center;
    }
    h1{
      font-family: 'East Sea Dokdo', sans-serif;
      font-size: 80px;
      text-align: center;
    }
    #contents{
      width: 100%;
      height: 900px;
      margin: 0 auto;
      background-color: oldlace;
      float: left;
    }
    #roomList{
      width: 400px;
      height: 150px;
      border: 5px solid orange;
      box-shadow : 10px 10px  orange;
      border-radius: 80px;
      float: left;
      margin-left: 35px;
      margin-top: 15px;
    }
    #rmname{
      font-size: 70px;
      font-family: 'East Sea Dokdo', sans-serif;
      text-align: center;
      color:orange;
    }

    #makeroombtn{
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

  </style>
</head>
<body>

<%
  List<Room> rooms = (List<Room>) request.getAttribute("rooms");
  String userNickname = (String) session.getAttribute("userNickname");
%>
<div id="container">
  <header id="header">
    <h1>모두의 오목</h1>

  </header>
  <section id="contents">
    <form action="/createRoom" method="POST">
      <div>
        <p>아이디 : <input type="" id="idbox" value="<%= userNickname %>" disabled></p>
        <p>방이름 : <input type="text" id="roomTitle" name="title" required></p>
        <p><button id="makeroombtn" type="submit">방 만들기</button></p>

      </div>
    </form>

    <div id="roomListt">
      <c:forEach items="${rooms}" var="room">

        <div class="room">
          <fieldset id="roomList">
          <a href="OmokAndChat.jsp?roomName=${room.name}&chatId=${userNickname}">
            <p id="rmname">방 이름: ${room.name}</p>
            <p>인원 제한: ${room.capacity}</p>
          </a>
          </fieldset>
        </div>

      </c:forEach>
    </div>

  </section>
</div>
<script>
  function goToRoom(roomName, userNickname) {
    let url = `OmokAndChat.jsp?roomName=${roomName}&userNickname=${userNickname}`;
    window.location.href = url;
  }
</script>
</html>
