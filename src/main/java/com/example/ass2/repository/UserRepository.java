package com.example.ass2.repository;

import com.example.ass2.model.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserRepository {

    private static final List<User> users = new ArrayList<>();

    static {
        // Không mã hóa mật khẩu, giữ nguyên dạng plain text
        users.add(new User("admin", "123", "Quản lý Spa", "ADMIN"));
        users.add(new User("tv1", "123", "Tư vấn viên 1", "CONSULTANT"));
        users.add(new User("tv2", "123", "Tư vấn viên 2", "CONSULTANT"));
    }

    // Tìm người dùng theo tên người dùng và mật khẩu
    public Optional<User> findByUsernameAndPassword(String username, String password) {
        return users.stream()
                .filter(u -> u.getUsername().equals(username)
                        && u.getPassword().equals(password))  // Kiểm tra mật khẩu trực tiếp
                .findFirst();
    }
}
