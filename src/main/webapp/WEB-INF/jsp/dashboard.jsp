<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div id="dashboard">
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
    <h2>Welcome, ${username} 👋</h2>

    <h3>📝 Create</h3>
    <ul>
        <li><a href="/note/create">Create New Note</a></li>
    </ul>

    <h3>📤 Upload</h3>
    <ul>
        <li><a href="/note/upload">Upload .txt File as Note</a></li>
    </ul>

    <h3>🔍 Get</h3>
    <ul>
        <li><a href="/note/fetch/by-id">Get Note by ID</a></li>
        <li><a href="/note/fetch/by-filename">Get Note by Filename</a></li>
        <li><a href="/note/fetch/all">Get All Notes</a></li>
    </ul>

    <h3>✏️ Update</h3>
    <ul>
        <li><a href="/note/update/by-id">Update Note by ID</a></li>
        <li><a href="/note/update/by-filename">Update Note by Filename</a></li>
    </ul>

    <h3>🗑️ Delete</h3>
    <ul>
        <li><a href="/note/delete/by-id">Delete Note by ID</a></li>
        <li><a href="/note/delete/by-filename">Delete Note by Filename</a></li>
    </ul>

<br><br>
    <!-- ✅ Fixed: valid HTML for logout button -->
    <form action="/logout" method="get" style="display:inline;">
        <input type="submit" value="Logout" />
    </form>
</div>
</body>
</html>
