<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${pageTitle}" /></title>

    <style>
        body { margin: 0; font-family: system-ui, sans-serif; background: #f3f4f6; }
        .app-shell { display: flex; height: 100vh; }

        .sidebar { width: 220px; background: #020617; color: #fff; display:flex; flex-direction:column; }
        .sidebar-header { padding: 16px; font-size: 18px; font-weight: bold; border-bottom: 1px solid #1e293b; }
        .sidebar-nav a { padding: 12px 16px; display:block; text-decoration:none; color:#cbd5f5; font-size:14px; }
        .sidebar-nav a:hover { background:#1f2937; color:#fff; }
        .sidebar-footer { margin-top:auto; padding:12px 16px; font-size:13px; opacity:.8; }

        .main { flex:1; display:flex; flex-direction:column; min-width:0; }

        .topbar {
            height:50px; background:#fff; border-bottom:1px solid #e5e7eb;
            padding:0 16px; display:flex; justify-content:space-between; align-items:center;
            position:sticky; top:0; z-index:10;
        }

        .content { padding:20px; overflow-y:auto; flex:1; }

        .card {
            background:#fff;
            border-radius:12px;
            padding:16px;
            box-shadow:0 10px 15px -10px rgba(15,23,42,.25);
        }

        .btn {
            padding:6px 10px; border-radius:999px; border:none; font-size:13px;
            background:#2563eb; color:#fff; text-decoration:none; cursor:pointer;
        }
        .btn-secondary { background:#e5e7eb; color:#111827; }
        .btn-danger { background:#ef4444; color:#fff; }
        .btn-small { padding:4px 8px; font-size:11px; }

        .tag {
            display:inline-block;
            padding:2px 8px;
            border-radius:999px;
            font-size:11px;
        }
        .tag.NEW { background:#dbeafe; color:#1d4ed8; }
        .tag.CONSULTED { background:#fef3c7; color:#92400e; }
        .tag.BOOKED { background:#e0f2fe; color:#0369a1; }
        .tag.IN_TREATMENT { background:#cffafe; color:#0f766e; }
        .tag.DONE { background:#dcfce7; color:#15803d; }
        .tag.CANCELLED { background:#fee2e2; color:#b91c1c; }

        table { width:100%; border-collapse:collapse; margin-top:12px; font-size:13px; }
        th,td { padding:8px 6px; border-bottom:1px solid #e5e7eb; text-align:left; }
        th { background:#f9fafb; font-weight:600; color:#4b5563; }
        tr:hover td { background:#f9fafb; }

        .toolbar { display:flex; justify-content:space-between; align-items:center; margin-bottom:12px; }

        .form-grid {
            display:grid;
            grid-template-columns:repeat(2, minmax(0,1fr));
            gap:12px 16px;
        }
        .form-group { font-size:13px; }
        .form-group label {
            display:block;
            margin-bottom:4px;
            color:#4b5563;
        }
        .form-group input,
        .form-group select {
            width:100%;
            padding:6px 8px;
            border-radius:8px;
            border:1px solid #d1d5db;
            font-size:13px;
        }
        .form-actions {
            margin-top:16px;
            display:flex;
            gap:8px;
            justify-content:flex-end;
        }

        .logout-btn {
            background:#e5edff;
            color:#1e3a8a;
            border-radius:999px;
            padding:6px 12px;
            text-decoration:none;
            font-size:12px;
        }

        .footer {
            text-align:center;
            padding:10px;
            font-size:12px;
            color:#6b7280;
            border-top:1px solid #e5e7eb;
            background:#f9fafb;
        }
    </style>
</head>

<body>
<div class="app-shell">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-header">Spa CRM Mini</div>

        <div class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/customers">Khách hàng Spa</a>
        </div>

        <div class="sidebar-footer">
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <div><b>${sessionScope.currentUser.fullName}</b></div>
                    <div>Role: ${sessionScope.currentUser.role}</div>
                </c:when>
                <c:otherwise>Chưa đăng nhập</c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- MAIN -->
    <div class="main">

        <!-- HEADER (TOPBAR) -->
        <jsp:include page="/WEB-INF/views/partials/header.jsp"/>

        <!-- NỘI DUNG TRANG CON -->
        <div class="content">
            <jsp:include page="${body}" />
        </div>

        <!-- FOOTER -->
        <jsp:include page="/WEB-INF/views/partials/footer.jsp"/>

    </div>
</div>
</body>
</html>
