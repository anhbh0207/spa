<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập Spa CRM Mini</title>
    <style>
        body {
            margin:0;
            font-family:sans-serif;
            background:linear-gradient(135deg,#0f172a,#1e293b);
            height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }
        .card {
            width:320px;
            background:#fff;
            border-radius:16px;
            padding:20px 22px;
            box-shadow:0 20px 35px -15px rgba(15,23,42,.6);
        }
        h1 { margin:0 0 4px; font-size:20px; text-align:center; }
        .subtitle { font-size:13px; text-align:center; color:#6b7280; margin-bottom:18px; }
        label { display:block; font-size:13px; margin-bottom:4px; color:#4b5563; }
        input {
            width:100%; padding:7px 9px; border-radius:10px;
            border:1px solid #d1d5db; font-size:13px; margin-bottom:10px;
        }
        button {
            width:100%; padding:8px; border-radius:999px; border:none;
            background:#2563eb; color:#fff; font-size:14px; cursor:pointer; margin-top:4px;
        }
        button:hover { background:#1d4ed8; }
        .error { margin-top:6px; font-size:12px; color:#b91c1c; text-align:center; }
        .hint { margin-top:10px; font-size:11px; color:#6b7280; text-align:center; }
        .hint code { background:#f3f4f6; padding:2px 4px; border-radius:4px; }
    </style>
</head>
<body>
<div class="card">
    <h1>Spa CRM Mini</h1>
    <div class="subtitle">Đăng nhập để quản lý khách hàng Spa</div>
    <form method="post" action="${pageContext.request.contextPath}/login">
        <label for="username">Tài khoản</label>
        <input type="text" id="username" name="username" placeholder="admin / tv1 / tv2"/>

        <label for="password">Mật khẩu</label>
        <input type="password" id="password" name="password" value="123"/>

        <button type="submit">Đăng nhập</button>

        <div class="error">
            <c:out value="${error}" />
        </div>

        <div class="hint">
            Demo: <code>admin / 123</code> hoặc <code>tv1 / 123</code>, <code>tv2 / 123</code>
        </div>
    </form>
</div>
</body>
</html>
