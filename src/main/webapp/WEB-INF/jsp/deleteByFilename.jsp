<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Delete Note by Filename</title>
    <link rel="stylesheet" href="/css/style.css">
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

<h2>Delete Note by Filename</h2>

<!-- ❌ Error block -->
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<!-- 🧾 Delete Form -->
<form action="/note/delete/by-filename" method="post">
    Filename: <input type="text" name="filename" required />
    <input type="submit" value="Delete" />
</form><br><br>

<form action="/dashboard" method="get">
    <input type="submit" value="Back to Dashboard" />
</form>

<!-- ✅ Modal on successful delete -->
<c:if test="${modalSuccess}">
    <div class="modal" style="display:block" id="deleteSuccessModal">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">🗑️ Note Deleted!</p>
            <p>The note <strong>${deletedFile}</strong> has been deleted successfully.</p>

            <div class="btn-row">
                <form action="/note/delete/by-filename" method="get">
                    <button type="submit">🔁 Stay Here</button>
                </form>
                <form action="/dashboard" method="get">
                    <button type="submit">🏠 Go to Dashboard</button>
                </form>
            </div>
        </div>
    </div>
</c:if>

</body>
</html>
