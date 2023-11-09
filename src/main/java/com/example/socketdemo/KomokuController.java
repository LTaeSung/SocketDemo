package com.example.socketdemo;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession을 import합니다.
import java.io.IOException;

@WebServlet("/setStone.do")
public class KomokuController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doHandle(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doHandle(request, response);
    }

    protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("실행");

        HttpSession session = request.getSession(); // 현재 세션을 가져옵니다.
        Board board = (Board) session.getAttribute("board"); // 세션에서 오목판을 가져옵니다.

        if (board == null) {
            board = new Board(); // 세션에 오목판이 없으면 새로운 오목판을 생성합니다.
            session.setAttribute("board", board); // 새로운 오목판을 세션에 저장합니다.
        }

        String stone = request.getParameter("stone");
        String row = request.getParameter("row");
        String col = request.getParameter("col");

        board.setStone(stone, row, col);
        boolean isVictory = board.check(stone);

        if (isVictory) {
            System.out.println("이겨따");
            session.removeAttribute("board"); // 게임 종료 후 오목판을 세션에서 제거합니다.
            response.getWriter().write("victory");
        }
    }
}
