<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Delete Account</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
</head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
<h2>Delete Account</h2>

<p style="color:red;">⚠️ This action cannot be undone. All your notes will be permanently deleted.</p>

<form action="/auth/account/delete" method="post">
    <input type="submit" value="Delete My Account" />
</form>

<a href="/dashboard"><input type="submit" value="Cancel" /></a>
</body>
</html>
