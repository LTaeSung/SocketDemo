package com.example.socketdemo;

import java.util.Arrays;

public class Board {
    private static final int SIZE = 19;
    String[][] map = new String[SIZE][SIZE];

    public Board() {
        for (int i = 0; i < SIZE; i++) {
            Arrays.fill(map[i], ".");
        }
    }

    public void setStone(String stone, String x, String y) {
        int rx = Integer.parseInt(x);
        int ry = Integer.parseInt(y);
        map[rx][ry] = stone;

        System.out.println();

        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                System.out.print(map[i][j]);
            }
            System.out.println();
        }

        System.out.println();

    }

    public boolean check(String stone) {
        int[] dx = { -1, -1, -1, 0, 1, 1, 1, 0 };
        int[] dy = { -1, 0, 1, 1, 1, 0, -1, -1 };

        for (int x = 0; x < SIZE; x++) {
            for (int y = 0; y < SIZE; y++) {
                if (stone.equals(map[x][y])) {
                    for (int i = 0; i < 8; i++) {
                        int cnt = 1;
                        int nextx = dx[i] + x;
                        int nexty = dy[i] + y;
                        for (int k = 0; k < 4; k++) {

                            if (nextx >= 0 && nexty >= 0 && nextx < SIZE && nexty < SIZE) {
                                if (stone.equals(map[nextx][nexty])) {
                                    cnt++;
                                }
                            }
                            nextx += dx[i];
                            nexty += dy[i];
                        }
                        if (cnt == 5) {

                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }
}
