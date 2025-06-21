<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Note Details</title><link rel="stylesheet" href="/css/style.css"></head>
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

    <h2>Note Details</h2>
    <p><strong>Filename:</strong> ${note.filename}</p>
    <p><strong>Content:</strong></p>
    <pre>${note.content}</pre><br><br>
    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>

</body>
</html>
