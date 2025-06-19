<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Logout</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
</head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
<h2>You have been logged out ✅</h2>
<p>Thanks for using Notepad App.</p>
<a href="/login"><input type="submit" value="Login Again" /></a>
</body>
</html>
