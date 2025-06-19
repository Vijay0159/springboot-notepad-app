<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
</head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>
<h2>Register</h2>

<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<!-- ✅ Fixed action path -->
<form action="/doRegister" method="post">
    Username: <input type="text" name="username" required /><br/><br/>
    Password: <input type="password" name="password" required /><br/><br/>
    <input type="submit" value="Register" />
</form>

<p>Already have an account? <a href="/login">Login here</a></p>
</body>
</html>
