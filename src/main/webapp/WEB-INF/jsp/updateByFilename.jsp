<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Update Note by Filename</title><link rel="stylesheet" href="/css/style.css"></head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
    <h2>Update Note by Filename</h2>
    <form action="/note/update/by-filename" method="post">
        Filename: <input type="text" name="filename" required /><br/>
        New Content:<br/>
        <textarea name="content" rows="6" cols="40" required></textarea><br/>
        <input type="submit" value="Update" />
    </form><br><br>
    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>

</body>
</html>
