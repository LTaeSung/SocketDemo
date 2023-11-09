package com.example.socketdemo;

import java.util.HashMap;
import java.util.Map;

public class RoomManager {
    private static Map<String, Room> rooms = new HashMap<>();

    public static boolean isRoomAvailable(String roomName) {
        Room room = rooms.get(roomName);
        if (room == null) {
            room = new Room(roomName, 2); // 방을 생성하고 최대 2명으로 설정
            rooms.put(roomName, room);
        }
        return room.isAvailable();
    }

    // 다른 방과 사용자 관리 메서드들 추가
    public static Room getRoom(String roomName) {
        return rooms.get(roomName);
    }
}
