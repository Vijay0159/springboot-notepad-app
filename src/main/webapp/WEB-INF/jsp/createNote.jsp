<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Create Note</title><link rel="stylesheet" href="/css/style.css"></head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
    <h2>Create a New Note</h2>
    <form method="post" action="/note/create">
        Filename: <input type="text" name="filename" required /><br/>
        Content:<br/>
        <textarea name="content" rows="6" cols="40" required></textarea><br/>
        <input type="submit" value="Create Note" />
    </form><br><br>
    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>

</body>
</html>
