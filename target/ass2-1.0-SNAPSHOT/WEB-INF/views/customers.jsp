<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="selectedStatus" value="${empty selectedStatus ? 'ALL' : selectedStatus}" />

<div class="card">

    <!-- TỔNG QUAN KHÁCH SPA -->
    <div style="display:flex; gap:12px; margin-bottom:16px;">
        <div style="flex:1; padding:10px 12px; border-radius:12px;
                    background:#020617; color:#e5e7eb;">
            <div style="font-size:12px; opacity:.75;">Tổng số khách Spa</div>
            <div style="font-size:22px; font-weight:600; margin-top:2px;">
                ${totalCount}
            </div>
        </div>

        <div style="flex:1; padding:10px 12px; border-radius:12px;
                    background:#dbeafe; color:#1d4ed8;">
            <div style="font-size:12px; opacity:.85;">Khách mới</div>
            <div style="font-size:22px; font-weight:600; margin-top:2px;">
                ${newCount}
            </div>
            <a href="${pageContext.request.contextPath}/customers?action=list&status=NEW"
               style="font-size:11px; text-decoration:none; color:#1d4ed8;">
                Xem danh sách khách mới →
            </a>
        </div>

        <div style="flex:1; padding:10px 12px; border-radius:12px;
                    background:#fef3c7; color:#92400e;">
            <div style="font-size:12px; opacity:.85;">Đã tư vấn</div>
            <div style="font-size:22px; font-weight:600; margin-top:2px;">
                ${consultedCount}
            </div>
        </div>
    </div>

    <div style="display:flex; gap:12px; margin-bottom:12px;">
        <div style="flex:1; padding:8px 10px; border-radius:10px;
                    background:#e0f2fe; color:#0369a1;">
            <div style="font-size:11px; opacity:.85;">Đã đặt lịch</div>
            <div style="font-size:18px; font-weight:600;">${bookedCount}</div>
        </div>
        <div style="flex:1; padding:8px 10px; border-radius:10px;
                    background:#cffafe; color:#0f766e;">
            <div style="font-size:11px; opacity:.85;">Đang điều trị</div>
            <div style="font-size:18px; font-weight:600;">${inTreatmentCount}</div>
        </div>
        <div style="flex:1; padding:8px 10px; border-radius:10px;
                    background:#dcfce7; color:#15803d;">
            <div style="font-size:11px; opacity:.85;">Hoàn thành</div>
            <div style="font-size:18px; font-weight:600;">${doneCount}</div>
        </div>
        <div style="flex:1; padding:8px 10px; border-radius:10px;
                    background:#fee2e2; color:#b91c1c;">
            <div style="font-size:11px; opacity:.85;">Đã hủy</div>
            <div style="font-size:18px; font-weight:600;">${cancelledCount}</div>
        </div>
    </div>

    <!-- TIÊU ĐỀ + NÚT THÊM -->
    <div class="toolbar"
         style="display:flex; justify-content:space-between; align-items:center; margin-bottom:8px;">
        <div>
            <strong>Khách hàng Spa</strong><br/>
            <span style="font-size:12px; color:#6b7280;">
                Theo dõi quy trình tiếp nhận &amp; chăm sóc khách Spa Pretty.
            </span>
        </div>
        <div>
            <a class="btn"
               href="${pageContext.request.contextPath}/customers?action=create">
                + Khách Spa mới
            </a>
        </div>
    </div>

    <!-- BỘ LỌC + TÌM KIẾM -->
    <form method="get"
          action="${pageContext.request.contextPath}/customers"
          style="margin-bottom:8px; display:flex; gap:8px; align-items:center; flex-wrap:wrap;">
        <input type="hidden" name="action" value="list"/>

        <span style="font-size:13px; color:#6b7280;">Trạng thái:</span>
        <select name="status"
                style="padding:4px 8px; border-radius:999px; border:1px solid #d1d5db; font-size:13px;">
            <option value="ALL" ${selectedStatus == 'ALL' ? 'selected' : ''}>Tất cả</option>
            <option value="NEW" ${selectedStatus == 'NEW' ? 'selected' : ''}>Khách mới</option>
            <option value="CONSULTED" ${selectedStatus == 'CONSULTED' ? 'selected' : ''}>Đã tư vấn</option>
            <option value="BOOKED" ${selectedStatus == 'BOOKED' ? 'selected' : ''}>Đã đặt lịch</option>
            <option value="IN_TREATMENT" ${selectedStatus == 'IN_TREATMENT' ? 'selected' : ''}>Đang điều trị</option>
            <option value="DONE" ${selectedStatus == 'DONE' ? 'selected' : ''}>Hoàn thành</option>
            <option value="CANCELLED" ${selectedStatus == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
        </select>

        <input type="text" name="keyword"
               placeholder="Tìm theo tên hoặc SĐT..."
               value="${keyword}"
               style="padding:4px 10px; border-radius:999px; border:1px solid #d1d5db;
                      font-size:13px; min-width:220px;">

        <button class="btn btn-secondary btn-small" type="submit">Lọc</button>
    </form>

    <!-- BẢNG KHÁCH HÀNG -->
    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>Khách hàng</th>
            <th>Liên hệ</th>
            <th>Dịch vụ Spa quan tâm</th>
            <th>Trạng thái</th>
            <th>Tư vấn viên</th>
            <th style="width:220px;">Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${customers}">
            <tr>
                <td>${c.id}</td>

                <td>
                    <strong>${c.name}</strong><br/>
                    <span style="font-size:12px; color:#6b7280;">${c.email}</span>
                </td>

                <td>${c.phone}</td>
                <td>${c.service}</td>

                <td>
                    <span class="tag ${c.status}">
                        <c:choose>
                            <c:when test="${c.status=='NEW'}">Khách mới</c:when>
                            <c:when test="${c.status=='CONSULTED'}">Đã tư vấn</c:when>
                            <c:when test="${c.status=='BOOKED'}">Đã đặt lịch</c:when>
                            <c:when test="${c.status=='IN_TREATMENT'}">Đang điều trị</c:when>
                            <c:when test="${c.status=='DONE'}">Hoàn thành</c:when>
                            <c:otherwise>Đã hủy</c:otherwise>
                        </c:choose>
                    </span>
                </td>

                <td>${c.assignedTo}</td>

                <td>
                    <a class="btn btn-secondary btn-small"
                       href="${pageContext.request.contextPath}/customers?action=edit&id=${c.id}">
                        Sửa
                    </a>
                    <a class="btn btn-danger btn-small"
                       href="${pageContext.request.contextPath}/customers?action=delete&id=${c.id}"
                       onclick="return confirm('Xóa khách hàng này?');">
                        Xóa
                    </a>

                    <!-- Đổi trạng thái nhanh -->
                    <div style="margin-top:4px;">
                        <form method="get"
                              action="${pageContext.request.contextPath}/customers"
                              style="display:inline;">
                            <input type="hidden" name="action" value="updateStatus"/>
                            <input type="hidden" name="id" value="${c.id}"/>

                            <select name="status"
                                    style="font-size:11px; padding:2px 4px; border-radius:8px; border:1px solid #d1d5db;">
                                <option value="NEW">Khách mới</option>
                                <option value="CONSULTED">Đã tư vấn</option>
                                <option value="BOOKED">Đã đặt lịch</option>
                                <option value="IN_TREATMENT">Đang điều trị</option>
                                <option value="DONE">Hoàn thành</option>
                                <option value="CANCELLED">Đã hủy</option>
                            </select>

                            <button class="btn btn-secondary btn-small" type="submit">OK</button>
                        </form>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
