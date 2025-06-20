<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Update Note by Filename</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
<script src="/js/theme.js"></script>

<h2>Update Note by Filename</h2>

<!-- ✅ Feedback messages -->
<c:if test="${not empty message}">
    <p class="success">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<form action="/note/update/by-filename" method="post">
    Filename: <input type="text" name="filename" required /><br/>
    New Content:<br/>
    <textarea name="content" rows="6" cols="40" required></textarea><br/>
    <input type="submit" value="Update" />
</form><br><br>

<form action="/dashboard" method="get">
    <input type="submit" value="Back to Dashboard" />
</form>

<!-- ✅ Success Modal -->
<c:if test="${not empty modalSuccess}">
    <div class="modal" id="updateSuccessModal" style="display:block">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Update Successful!</p>
            <p>The note <strong>${updatedFile}</strong> has been updated successfully.</p>
            <form action="/dashboard" method="get">
                <button type="submit">Go to Dashboard</button>
            </form>
        </div>
    </div>
</c:if>

</body>
</html>
