<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.example.ass2.model.Customer" %>
<%@ page import="com.example.ass2.model.CustomerStatus" %>

<%
    String formMode = (String) request.getAttribute("formMode"); // "create" hoặc "edit"
    Customer customer = (Customer) request.getAttribute("customer");
    boolean isEdit = "edit".equals(formMode);
%>

<div class="card">
    <div style="margin-bottom:12px;">
        <strong><%= isEdit ? "Cập nhật khách Spa" : "Thêm khách Spa mới" %></strong><br/>
        <span style="font-size:12px; color:#6b7280;">
            Nhập thông tin khách và dịch vụ Spa quan tâm.
        </span>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/customers">
        <!-- action để servlet biết là thêm hay sửa -->
        <input type="hidden" name="action" value="<%= isEdit ? "edit" : "create" %>"/>

        <% if (isEdit && customer != null) { %>
        <input type="hidden" name="id" value="<%= customer.getId() %>"/>
        <% } %>

        <div class="form-grid">
            <div class="form-group">
                <label for="name">Tên khách hàng</label>
                <input type="text" id="name" name="name"
                       value="<%= customer != null ? customer.getName() : "" %>"
                       required/>
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="text" id="phone" name="phone"
                       value="<%= customer != null ? customer.getPhone() : "" %>"/>
            </div>

            <div class="form-group">
                <label for="email">Email (nếu có)</label>
                <input type="email" id="email" name="email"
                       value="<%= customer != null ? customer.getEmail() : "" %>"/>
            </div>

            <div class="form-group">
                <label for="service">Dịch vụ Spa quan tâm</label>
                <input type="text" id="service" name="service"
                       value="<%= customer != null ? customer.getService() : "" %>"
                       placeholder="VD: Massage body, trị mụn, gội đầu dưỡng sinh..."/>
            </div>

            <% if (isEdit && customer != null) { %>
            <div class="form-group">
                <label for="status">Trạng thái quy trình</label>
                <select id="status" name="status">
                    <% for (CustomerStatus st : CustomerStatus.values()) { %>
                    <option value="<%= st.name() %>"
                            <%= (customer.getStatus() == st) ? "selected" : "" %>>
                        <%= st.name() %>
                    </option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label>Tư vấn viên phụ trách</label>
                <input type="text" disabled
                       value="<%= customer.getAssignedTo() %>"/>
            </div>
            <% } %>
        </div>

        <div class="form-actions">
            <a class="btn btn-secondary"
               href="${pageContext.request.contextPath}/customers">
                Hủy
            </a>
            <button class="btn" type="submit">
                <%= isEdit ? "Lưu thay đổi" : "Tạo khách mới" %>
            </button>
        </div>
    </form>
</div>
