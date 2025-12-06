package com.example.ass2.servlet;

import com.example.ass2.model.Customer;
import com.example.ass2.model.CustomerStatus;
import com.example.ass2.repository.CustomerRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {

    private final CustomerRepository repo = new CustomerRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null || action.equals("list")) {
            list(req, resp);
        } else if ("create".equals(action)) {
            showCreate(req, resp);
        } else if ("edit".equals(action)) {
            showEdit(req, resp);
        } else if ("delete".equals(action)) {
            delete(req, resp);
        } else if ("updateStatus".equals(action)) {
            updateStatus(req, resp);
        }
    }

    // ================== DANH SÁCH + TỔNG QUAN ==================
    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String statusStr = req.getParameter("status");
        String keyword = req.getParameter("keyword");

        List<Customer> data;

        // Lọc theo trạng thái
        if (statusStr == null || statusStr.trim().isEmpty() || "ALL".equals(statusStr)) {
            data = repo.findAll();
        } else {
            try {
                // kiểm tra status hợp lệ
                boolean valid = Arrays.stream(CustomerStatus.values())
                        .anyMatch(st -> st.name().equals(statusStr));
                if (valid) {
                    CustomerStatus st = CustomerStatus.valueOf(statusStr);
                    data = repo.findByStatus(st);
                } else {
                    data = repo.findAll();
                }
            } catch (IllegalArgumentException e) {
                data = repo.findAll();
            }
        }

        // Tìm kiếm theo từ khóa
        data = search(data, keyword);

        // Gửi dữ liệu ra JSP
        req.setAttribute("customers", data);
        req.setAttribute("selectedStatus", statusStr);
        req.setAttribute("keyword", keyword);

        // Tiêu đề trang
        req.setAttribute("pageTitle", "Khách hàng Spa");

        // Thống kê tổng quan
        req.setAttribute("totalCount", repo.countAll());
        req.setAttribute("newCount", repo.count(CustomerStatus.NEW));
        req.setAttribute("consultedCount", repo.count(CustomerStatus.CONSULTED));
        req.setAttribute("bookedCount", repo.count(CustomerStatus.BOOKED));
        req.setAttribute("inTreatmentCount", repo.count(CustomerStatus.IN_TREATMENT));
        req.setAttribute("doneCount", repo.count(CustomerStatus.DONE));
        req.setAttribute("cancelledCount", repo.count(CustomerStatus.CANCELLED));

        // Gán body là trang con, forward qua layout.jsp
        req.setAttribute("body", "/WEB-INF/views/customers.jsp");
        req.getRequestDispatcher("/WEB-INF/views/layout.jsp")
                .forward(req, resp);
    }

    // ================== HIỂN THỊ FORM THÊM ==================
    private void showCreate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("formMode", "create");
        req.setAttribute("pageTitle", "Thêm khách Spa");

        // gán body = form, forward layout
        req.setAttribute("body", "/WEB-INF/views/customer-form.jsp");
        req.getRequestDispatcher("/WEB-INF/views/layout.jsp")
                .forward(req, resp);
    }

    // ================== HIỂN THỊ FORM SỬA ==================
    private void showEdit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Customer c = repo.findById(id).orElse(null);

        req.setAttribute("customer", c);
        req.setAttribute("formMode", "edit");
        req.setAttribute("pageTitle", "Cập nhật khách Spa");

        req.setAttribute("body", "/WEB-INF/views/customer-form.jsp");
        req.getRequestDispatcher("/WEB-INF/views/layout.jsp")
                .forward(req, resp);
    }

    // ================== XÓA KHÁCH ==================
    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        repo.delete(id);

        resp.sendRedirect(req.getContextPath() + "/customers");
    }

    // ================== CẬP NHẬT TRẠNG THÁI NHANH ==================
    private void updateStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");

        repo.findById(id).ifPresent(c -> {
            try {
                CustomerStatus st = CustomerStatus.valueOf(status);
                c.setStatus(st);
                repo.update(c);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        });

        resp.sendRedirect(req.getContextPath() + "/customers");
    }

    // ================== XỬ LÝ POST (THÊM / SỬA) ==================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");
        if ("create".equals(action)) {
            create(req, resp);
        } else if ("edit".equals(action)) {
            update(req, resp);
        }
    }

    // Thêm khách mới
    private void create(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Customer c = new Customer();
        c.setName(req.getParameter("name"));
        c.setPhone(req.getParameter("phone"));
        c.setEmail(req.getParameter("email"));
        c.setService(req.getParameter("service"));
        c.setStatus(CustomerStatus.NEW);
        // sau này có thể lấy từ session currentUser
        c.setAssignedTo("admin");

        repo.add(c);

        resp.sendRedirect(req.getContextPath() + "/customers");
    }

    // Cập nhật khách
    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Customer c = repo.findById(id).orElse(null);
        if (c == null) {
            resp.sendRedirect(req.getContextPath() + "/customers");
            return;
        }

        c.setName(req.getParameter("name"));
        c.setPhone(req.getParameter("phone"));
        c.setEmail(req.getParameter("email"));
        c.setService(req.getParameter("service"));
        c.setStatus(CustomerStatus.valueOf(req.getParameter("status")));

        repo.update(c);

        resp.sendRedirect(req.getContextPath() + "/customers");
    }

    // Tìm kiếm theo từ khóa (tên hoặc SĐT)
    private List<Customer> search(List<Customer> list, String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return list;
        }
        String kw = keyword.trim().toLowerCase();
        return list.stream()
                .filter(c -> (c.getName() != null && c.getName().toLowerCase().contains(kw)) ||
                        (c.getPhone() != null && c.getPhone().toLowerCase().contains(kw)))
                .collect(Collectors.toList());
    }
}
