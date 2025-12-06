package com.example.ass2.model;

public class Customer {
    private int id;
    private String name;
    private String phone;
    private String email;
    private String service;         // Dịch vụ spa quan tâm
    private CustomerStatus status;  // Trạng thái quy trình
    private String assignedTo;      // Nhân viên tư vấn (username)

    public Customer() {
    }

    public Customer(int id, String name, String phone, String email,
                    String service, CustomerStatus status, String assignedTo) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.service = service;
        this.status = status;
        this.assignedTo = assignedTo;
    }

    // Getter & Setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public CustomerStatus getStatus() {
        return status;
    }

    public void setStatus(CustomerStatus status) {
        this.status = status;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }
}
