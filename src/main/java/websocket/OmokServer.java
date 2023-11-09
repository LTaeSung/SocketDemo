package websocket;

import com.example.socketdemo.Room;
import com.example.socketdemo.RoomManager;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.*;

@ServerEndpoint("/gomoku/{roomName}/{userNickname}")
public class OmokServer {
    private static Map<String, Set<Session>> roomClients = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("roomName") String roomName, @PathParam("userNickname") String userNickname) throws IOException {
        // Check if the room exists
        if (!roomClients.containsKey(roomName)) {
            roomClients.put(roomName, Collections.synchronizedSet(new HashSet<>()));
        }

        Set<Session> clients = roomClients.get(roomName);
        if (RoomManager.isRoomAvailable(roomName) && clients.size() < 2) {
            clients.add(session);
            session.getUserProperties().put("roomName", roomName);
            session.getUserProperties().put("userNickname", userNickname);
            // Determine the first player
            String firstPlayer = clients.size() == 1 ? "O" : "X";
            // Send the firstPlayer information to the client
            session.getBasicRemote().sendText("{\"event\":\"first_player\", \"firstPlayer\":\"" + firstPlayer + "\"}");


            System.out.println(userNickname + "님 방에 입장: " + roomName);
            System.out.println("session id: " + session.getId());
            System.out.println(userNickname + "님의 오목 : " + firstPlayer + "순서 : "+ clients.size());
        } else {
            System.out.println("방이 가득 참");
            session.close();
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        String roomName = (String) session.getUserProperties().get("roomName");
        Set<Session> clients = roomClients.get(roomName);
        if (message.equals("get_data")){

        }

        synchronized (clients) {
            for (Session client : clients) {
                if (!client.equals(session)) {
                    try {
                        client.getBasicRemote().sendText(message);
                        System.out.println("메세지 보내기");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        String roomName = (String) session.getUserProperties().get("roomName");
        Set<Session> clients = roomClients.get(roomName);
        clients.remove(session);
    }

    @OnError
    public void onError(Throwable error) {
        error.printStackTrace();
    }
}

