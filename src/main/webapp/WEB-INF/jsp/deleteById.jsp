<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Delete Note by ID</title><link rel="stylesheet" href="/css/style.css"></head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
    <h2>Delete Note by ID</h2>
    <form action="/note/delete/by-id" method="post">
        Note ID: <input type="number" name="noteId" required />
        <input type="submit" value="Delete" />
    </form><br><br>
    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>

</body>
</html>
