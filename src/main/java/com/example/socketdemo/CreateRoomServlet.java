package com.example.socketdemo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


// 방 생성 및 목록 관리 서블릿 만들기 - 클라이언트로부터 방 생성 요청 수신, 새로운 방 만들어 방 목록에 추가
@WebServlet("/createRoom")
public class CreateRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        // HTML이 UTF-8 형식이라는 것을 브라우저에게 전달
        response.setContentType("text/html; charset=utf-8");
        // 클라이언트에서 보낸 방 이름 가져오기
        String roomTitle = request.getParameter("title");
        // 사용자가 입력한 닉네임을 가져옵니다.
        String userNickname = request.getParameter("userNickname");
        // 방을 생성한 후, 방 목록을 업데이트하고 세션에 저장
        List<Room> roomList = getAvailableRooms();

        // 방 이름이 유효한 경우에만 새로운 방을 생성
        if (roomTitle != null && !roomTitle.isEmpty()) {
            // 방 생성 로직 (서버 데이터베이스에 방 추가 등)

            // 성공적으로 방을 생성한 후, 클라이언트에 응답으로 성공 메시지를 보내거나 새로운 방 정보를 JSON으로 반환
            String successMessage = "방이 성공적으로 생성되었습니다.";
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(successMessage);


            Room newRoom = new Room(roomTitle, 2);
            roomList.add(newRoom);

            HttpSession session = request.getSession();
            session.setAttribute("rooms", roomList);

            // 방이 성공적으로 생성되면 방 목록 페이지로 리다이렉션
            response.sendRedirect("room-list.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("userNickname", userNickname);
            session.setAttribute("rooms", roomList);
            response.sendRedirect("room-list.jsp");
            // 방 이름이 유효하지 않을 때 에러 응답을 보냅니다.
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
        }
    }

    public List<Room> getAvailableRooms() {
        // 실제로 사용 가능한 방 목록을 데이터베이스에서 또는 다른 소스로 가져오는 대신, 여기서 방 목록을 동적으로 생성합니다.
        List<Room> rooms = new ArrayList<>();

        // 예제: 방 목록을 동적으로 생성
        Room room1 = new Room("Room 1", 2);
        Room room2 = new Room("Room 2", 2);
        Room room3 = new Room("Room 3", 2);
        Room room4 = new Room("Room 4", 2);
        Room room5 = new Room("Room 5", 2);
        Room room6 = new Room("Room 6", 2);
        Room room7 = new Room("Room 7", 2);
        Room room8 = new Room("Room 8", 2);
        Room room9 = new Room("Room 9", 2);
        Room room10 = new Room("Room 10", 2);


        rooms.add(room1);
        rooms.add(room2);
        rooms.add(room3);
        rooms.add(room4);
        rooms.add(room5);
        rooms.add(room6);
        rooms.add(room7);
        rooms.add(room8);
        rooms.add(room9);
        rooms.add(room10);

        return rooms;
    }
}
