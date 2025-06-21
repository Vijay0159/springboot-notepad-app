<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create Note</title>
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

<h2>Create a New Note</h2>

<!-- 🟥 Error block -->
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<!-- 🧾 Form -->
<form method="post" action="/note/create">
    Filename: <input type="text" name="filename" required /><br/>
    Content:<br/>
    <textarea name="content" rows="6" cols="40" required></textarea><br/>
    <input type="submit" value="Create Note" />
</form><br><br>

<form action="/dashboard" method="get">
    <input type="submit" value="Back to Dashboard" />
</form>

<!-- ✅ Modal -->
<c:if test="${noteCreated}">
    <div class="modal" style="display:block" id="successModal">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Note Created!</p>
            <p>The note <strong>${filename}</strong> was created successfully.</p>

            <div class="btn-row">
                <form action="/note/create" method="get">
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
