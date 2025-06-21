<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Update Note by ID</title>
    <link rel="stylesheet" href="/css/style.css">
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

<h2>Update Note by ID</h2>

<!-- ✅ Feedback messages -->
<c:if test="${not empty message}">
    <p class="success">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<form action="/note/update/by-id" method="post">
    Note ID: <input type="number" name="noteId" required /><br/>
    New Filename: <input type="text" name="filename" required /><br/>
    New Content:<br/>
    <textarea name="content" rows="6" cols="40" required></textarea><br/>
    <input type="submit" value="Update" />
</form><br><br>

<form action="/dashboard" method="get">
    <input type="submit" value="Back to Dashboard" />
</form>

<!-- ✅ Success Modal with dual buttons -->
<c:if test="${not empty modalSuccess}">
    <div class="modal" id="updateSuccessModal" style="display:block">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Update Successful!</p>
            <p>The note <strong>${updatedFile}</strong> has been updated successfully.</p>
            <div class="btn-row">
                <form action="/note/update/by-id" method="get">
                    <button type="submit">🔁 Stay Here</button>
                </form>
                <form action="/dashboard" method="get">
                    <button type="submit">🏠 Go to Dashboard</button>
                </form>
            </div>
        </div>
    </div>
</c:if>

</body>
</html>
