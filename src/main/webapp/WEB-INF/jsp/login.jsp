<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
</head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
<h2>Login</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="/doLogin" method="post">
    <label>Username:</label>
    <input type="text" name="username" required />

    <label>Password:</label>
    <input type="password" name="password" required />

    <button type="submit">Login</button>
</form>


<p>Don't have an account? <a href="/register">Register here</a></p>
</body>
</html>
