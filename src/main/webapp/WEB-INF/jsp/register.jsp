<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
</head>
<body>
<div class="theme-switcher">
    <select id="themeDropdown" onchange="changeTheme(this.value)">
        <option value="light">☀️ Light</option>
        <option value="dark">🌑 Dark</option>
        <option value="rose">🌸 Rose</option>
        <option value="lavender">💜 Lavender</option>
        <option value="aqua">🌊 Aqua</option>
    </select>
</div>
<script src="/js/theme.js"></script>

<h2>Register</h2>

<!-- ❌ Error Message -->
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<!-- 🧾 Registration Form -->
<form action="/doRegister" method="post">
    Username: <input type="text" name="username" required /><br/><br/>
    Password: <input type="password" name="password" required /><br/><br/>
    Confirm Password: <input type="password" name="confirmPassword" required /><br/><br/>
    <input type="submit" value="Register" />
</form>

<p>Already have an account? <a href="/login">Login here</a></p>

<!-- ✅ Modal shown only on success -->
<c:if test="${modalSuccess}">
    <div class="modal" style="display:block;">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Registered Successfully!</p>
            <p>User <strong>${registeredUsername}</strong> has been created.</p>
            <form action="/login" method="get">
                <button type="submit">🔐 Login Now</button>
            </form>
        </div>
    </div>
</c:if>
</body>
</html>
