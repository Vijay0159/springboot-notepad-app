<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Get Note by ID</title>
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


    <h2>Fetch Note by ID</h2>

    <!-- 🟥 Error block -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <!-- 🧾 Form to fetch note -->
    <form action="/note/fetch/by-id" method="post">
        Note ID: <input type="number" name="noteId" required />
        <input type="submit" value="Fetch" />
    </form><br><br>

    <!-- ✅ Display note if available -->
    <c:if test="${not empty note}">
        <div class="note-display">
            <p><strong>🆔 Note ID:</strong> ${note.id}</p>
            <p><strong>📁 Filename:</strong> ${note.filename}</p>
            <p><strong>📝 Content:</strong></p>
            <pre>${note.content}</pre>

            <!-- ⬇️ Download Button -->
            <form action="/note/download/single" method="post">
                <input type="hidden" name="noteId" value="${note.id}" />
                <button type="submit">⬇️ Download This Note</button>
            </form>
        </div>
    </c:if>

    <!-- ℹ️ Message for initial load -->
    <c:if test="${empty note and empty error}">
        <p class="info">Enter a note ID above to fetch and download its content.</p>
    </c:if>

    <br>
    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>
</body>
</html>
