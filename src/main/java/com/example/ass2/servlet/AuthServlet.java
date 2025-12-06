package com.example.ass2.servlet;

import com.example.ass2.model.User;
import com.example.ass2.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;
@WebServlet({"/login", "/logout"})
public class AuthServlet extends HttpServlet {

    private final UserRepository userRepo = new UserRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Nếu là logout → xóa session + cookie
        if (req.getServletPath().equals("/logout")) {

            req.getSession().invalidate();

            Cookie ck = new Cookie("usernameCookie", "");
            ck.setMaxAge(0);
            resp.addCookie(ck);

            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy username từ cookie
        String savedUser = "";
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("usernameCookie")) {
                    savedUser = c.getValue();
                }
            }
        }

        req.setAttribute("savedUser", savedUser);

        req.getRequestDispatcher("/WEB-INF/views/login.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Optional<User> userOpt = userRepo.findByUsernameAndPassword(username, password);

        if (userOpt.isPresent()) {
            req.getSession().setAttribute("currentUser", userOpt.get());

            // Lưu cookie username để nhớ lần sau
            Cookie ck = new Cookie("usernameCookie", username);
            ck.setMaxAge(60 * 60 * 24 * 7); // 7 ngày
            resp.addCookie(ck);

            resp.sendRedirect(req.getContextPath() + "/customers");
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(req, resp);
        }
    }
}
