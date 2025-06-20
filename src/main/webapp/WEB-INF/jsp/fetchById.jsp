<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Get Note by ID</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
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
