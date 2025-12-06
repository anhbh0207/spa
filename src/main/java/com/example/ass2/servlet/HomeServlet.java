package com.example.ass2.servlet;

import com.example.ass2.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/app")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Lấy thông tin người dùng hiện tại từ session
        User current = (User) req.getSession().getAttribute("currentUser");

        // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang login
        if (current == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Nếu người dùng đã đăng nhập, chuyển hướng đến trang danh sách khách hàng
        resp.sendRedirect(req.getContextPath() + "/customers");
    }
}
