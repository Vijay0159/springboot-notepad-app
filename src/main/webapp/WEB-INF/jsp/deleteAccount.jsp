<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Delete Account</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
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

<h2>Delete Account</h2>

<p style="color:red;">⚠️ This action cannot be undone. All your notes will be permanently deleted.</p>

<form action="/auth/account/delete" method="post">
    <input type="submit" value="Delete My Account" />
</form>

<a href="/dashboard"><input type="submit" value="Cancel" /></a>
</body>
</html>
