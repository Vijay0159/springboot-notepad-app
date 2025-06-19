<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Upload Note</title><link rel="stylesheet" href="/css/style.css"></head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
    <h2>Upload .txt File</h2>
    <form action="/note/upload" method="post" enctype="multipart/form-data">
        File: <input type="file" name="file" accept=".txt" required /><br/><br>
        Optional Filename: <br><input type="text" name="filename" /><br/>
        <input type="submit" value="Upload" />
    </form><br><br>
    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>

</body>
</html>
