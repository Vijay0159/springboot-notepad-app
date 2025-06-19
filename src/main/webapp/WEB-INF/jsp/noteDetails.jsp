<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Note Details</title><link rel="stylesheet" href="/css/style.css"></head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
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
