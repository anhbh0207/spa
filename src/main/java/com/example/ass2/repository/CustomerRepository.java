package com.example.ass2.repository;

import com.example.ass2.model.Customer;
import com.example.ass2.model.CustomerStatus;
import com.example.ass2.util.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CustomerRepository {

    // KHÔNG dùng MySQL nữa, dùng DBConnect (SQL Server)
    private Connection getConnection() throws SQLException {
        return DBConnect.getConnection();
    }

    // Lấy tất cả khách hàng
    public List<Customer> findAll() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customer";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                CustomerStatus status = getStatusFromString(rs.getString("status"));
                customers.add(new Customer(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("service"),
                        status,
                        rs.getString("assignedTo")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Tìm theo ID
    public Optional<Customer> findById(int id) {
        String sql = "SELECT * FROM Customer WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    CustomerStatus status = getStatusFromString(rs.getString("status"));
                    return Optional.of(new Customer(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("service"),
                            status,
                            rs.getString("assignedTo")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // Lọc theo trạng thái
    public List<Customer> findByStatus(CustomerStatus status) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customer WHERE status = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status.name());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CustomerStatus statusFromDb = getStatusFromString(rs.getString("status"));
                    customers.add(new Customer(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("service"),
                            statusFromDb,
                            rs.getString("assignedTo")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Tạo mới khách hàng
    public void add(Customer c) {
        String sql = "INSERT INTO Customer (name, phone, email, service, status, assignedTo) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, c.getName());
            stmt.setString(2, c.getPhone());
            stmt.setString(3, c.getEmail());
            stmt.setString(4, c.getService());
            stmt.setString(5, c.getStatus().name());
            stmt.setString(6, c.getAssignedTo());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        c.setId(generatedKeys.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật thông tin khách hàng
    public void update(Customer c) {
        String sql = "UPDATE Customer SET name = ?, phone = ?, email = ?, service = ?, status = ?, assignedTo = ? " +
                "WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, c.getName());
            stmt.setString(2, c.getPhone());
            stmt.setString(3, c.getEmail());
            stmt.setString(4, c.getService());
            stmt.setString(5, c.getStatus().name());
            stmt.setString(6, c.getAssignedTo());
            stmt.setInt(7, c.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Xóa khách hàng
    public void delete(int id) {
        String sql = "DELETE FROM Customer WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Đếm tất cả khách hàng
    public long countAll() {
        String sql = "SELECT COUNT(*) FROM Customer";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Đếm khách hàng theo trạng thái
    public long count(CustomerStatus status) {
        String sql = "SELECT COUNT(*) FROM Customer WHERE status = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status.name());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Helper: chuyển String -> enum
    private CustomerStatus getStatusFromString(String status) {
        try {
            return CustomerStatus.valueOf(status);
        } catch (Exception e) {
            return CustomerStatus.NEW;
        }
    }
}
