<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<head>
    <title>오목 게임 및 채팅</title>
    <style>
        *{
            background-color: oldlace;
            text-align: center;
        }
        .omok-board {
            display: grid;
            grid-template-columns: repeat(19, 20px);
            grid-template-rows: repeat(19, 20px);
        }

        .omok-cell {
            width: 20px;
            height: 20px;
            border: 1px solid #000;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 18px;
            color: #000;
        }

        #chatWindow {
            border: 1px solid darkblue;
            width: 270px;
            height: 310px;
            overflow: scroll;
            padding: 7px;
        }

        #chatMessage {
            width: 235px;
            height: 30px;
        }

        #sendBtn {
            height: 30px;
            position: relative;
            top: 2px;
            left: -2px;
        }

        #closeBtn {
            margin-bottom: 3px;
            position: relative;
            top: 2px;
            left: -2px;
        }

        #chatId {
            width: 158px;
            height: 24px;
            border: 1px solid darkgray;
            background-color: whitesmoke;
        }

        .myMsg {
            text-align: right;
        }
    </style>
</head>
<body>
<div>
    <!-- 오목 게임 보드 -->
    <div class="omok-board" id="omok-board">
        <!-- 19x19 게임 보드를 생성합니다. -->
    </div>
</div>
<div>
    <div>
        대화명 : <input type="text" id="chatId" value="${param.chatId}" readonly />
        <button id="closeBtn" onclick="disconnect();">채팅종료</button>
    </div>
    <!-- 채팅 창 -->
    <div id="chatWindow">
        <!-- 채팅 메시지를 표시하는 영역 -->

    </div>
    <input type="text" id="chatMessage" onkeyup="enterKey();">
    <button id="sendBtn" onclick="sendMessage();">전송</button>
</div>
<script>

    // 오목 게임 관련 JavaScript 코드

    // 게임 보드 요소에 대한 참조를 가져오고 서버와의 WebSocket 연결을 설정합니다.
    const board = document.getElementById("omok-board");
    const socket = new WebSocket("<%= application.getInitParameter("CHAT_ADDR")%>gomoku/${param.roomName}/${param.chatId}");
    console.log(socket);
    let currentPlayer = "O";
    let nowTurn = "O";
    // 특정 클래스를 가진 div 엘리먼트를 생성하여 19x19 게임 보드를 만듭니다.
    for (let i = 0; i < 19; i++) {
        for (let j = 0; j < 19; j++) {
            const cell = document.createElement('div');
            cell.classList.add('omok-cell');
            cell.dataset.row = i;
            cell.dataset.col = j;
            board.appendChild(cell);
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        // 게임 보드의 모든 셀에 대한 참조를 가져오고 초기 게임 변수를 설정합니다.
        const cellLinks = document.querySelectorAll(".omok-cell");

        let gameEnded = false;

        // 게임 보드의 각 셀에 클릭 이벤트 리스너를 추가합니다.
        cellLinks.forEach(link => {
            link.addEventListener("click", function (e) {
                e.preventDefault();
                if (gameEnded) {
                    return; // 게임이 종료되었으면 더 이상 움직일 수 없습니다.
                }
                if (currentPlayer === nowTurn){
                    const row = link.dataset.row;
                    const col = link.dataset.col;
                    const stone = currentPlayer;
                    if (nowTurn === "O"){
                        nowTurn = "X";
                    }
                    else{
                        nowTurn = "O";
                    }

                    if (!link.classList.contains("occupied")) {
                        link.classList.add("occupied");
                        link.textContent = currentPlayer;

                        // 선택한 셀의 좌표와 현재 플레이어의 돌을 서버로 보냅니다.
                        sendCoordinateToServer(stone, row, col);
                    }

                }
            });
        });

        function sendCoordinateToServer(stone, row, col) {
            const xhr = new XMLHttpRequest();
            const url = "setStone.do"; // 서블릿 URL

            // GET 요청을 사용하고, URL에 데이터를 추가
            xhr.open("GET", url + "?row=" + row + "&col=" + col + "&stone=" + stone, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    if (xhr.responseText === "victory") {
                        // 게임에서 승리했다면 사용자에게 알림 표시
                        alert("게임에서 승리했습니다!");

                        const eventData = {
                            event: "end",
                            row: row,
                            col: col,
                            stone: stone
                        }
                        const eventDataStr = JSON.stringify(eventData);
                        socket.send(eventDataStr);
                        gameEnded = true;
                    }
                }
            };

            xhr.send(); // 요청 전송
            // 움직임 데이터를 포함한 JSON 객체를 생성하고 문자열로 서버에 보냅니다.
            const eventData = {
                event: "place_stone",
                row: row,
                col: col,
                stone: stone
            };
            const eventDataStr = JSON.stringify(eventData);
            socket.send(eventDataStr);
        }

    });

    // 서버에서 받은 메시지를 처리합니다.
    socket.onmessage = function (event) {

        const eventData = JSON.parse(event.data);
        if(eventData.event === "end"){

            alert("게임에서 패배했습니다!");
            gameEnded = true;
        }

        // 서버에서 받은 돌 놓기 이벤트를 처리합니다.
        if (eventData.event === "place_stone") {
            const row = eventData.row;
            const col = eventData.col;
            const stone = eventData.stone;
            if (currentPlayer === stone){
                if (stone === "O")
                    currentPlayer = "X";
                else{
                    currentPlayer = "O";
                }
            }
            if (nowTurn === "O"){
                nowTurn = "X";
            }
            else{
                nowTurn = "O";
            }
            const cell = document.querySelector(`[data-row='\${row}'][data-col='\${col}']`);

            if (!cell.classList.contains("occupied")) {
                cell.classList.add("occupied");
                cell.textContent = stone;
            }
        }
        else{

            const sender = eventData.chatId;
            const content = eventData.content;

            if (content != "") {
                if (content.match("/")) {
                    if (content.match(("/" + chatId))) {
                        let temp = content.replace(("/" + chatId), " [귓속말] : ");
                        chatWindow.innerHTML += "<div>" + sender + "" + temp + "</div>";
                    }
                } else {
                    // 일반대화
                    chatWindow.innerHTML += "<div>" + sender + " : " + content + "</div>";
                }
                chatWindow.scrollTop = chatWindow.scrollHeight;
            }
        }


        // 서버가 게임이 이겼음을 알리면 알림을 표시합니다.
        if (eventData.event === "victory") {
            alert("게임에서 승리했습니다!");
            gameEnded = true;
        }
    };



    // 채팅 관련 JavaScript 코드
    let chatWindow, chatMessage, chatId;

    window.onload = () => {
        chatWindow = document.getElementById("chatWindow");
        chatMessage = document.getElementById("chatMessage");
        chatId = document.getElementById("chatId").value;
    }

    function sendMessage() {
        const messageContent = chatMessage.value;
        const message = {
            chatId: chatId,
            content: messageContent
        };

        chatWindow.innerHTML += "<div class='myMsg'> " + messageContent + "</div>";

        // 객체를 JSON 문자열로 변환하여 보냅니다.
        socket.send(JSON.stringify(message));

        chatMessage.value = "";
        chatWindow.scrollTop = chatWindow.scrollHeight;
    }

    function disconnect() {
        socket.close();
        window.location.href = "index.jsp";
    }

    function enterKey() {
        if (event.keyCode == 13) {
            sendMessage();
        }
    }

    // socket.onopen = event => chatWindow.innerHTML += "웹소켓 서버에 연결되었습니다. ";
    socket.onclose = event => {
        console.error("WebSocket 생성에 실패했습니다.");
        alert("방이 꽉차부렀으");
        // chatWindow.innerHTML += "웹소켓 서버가 연결종료되었습니다. ";
        window.location.href = "room-list.jsp";
    }

    socket.onerror = (event) => {
        alert(event.data);
        chatWindow.innerHTML += "채팅 중 에러가 발생하였습니다.";

    }


</script>

</body>
</html>