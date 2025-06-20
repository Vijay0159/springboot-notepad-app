<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Delete Note by Filename</title><link rel="stylesheet" href="/css/style.css"></head>
<body>
<button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
<script src="/js/theme.js"></script>

<h2>Delete Note by Filename</h2>

<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<form action="/note/delete/by-filename" method="post">
    Filename: <input type="text" name="filename" required />
    <input type="submit" value="Delete" />
</form><br><br>

<form action="/dashboard" method="get">
    <input type="submit" value="Back to Dashboard" />
</form>

<!-- ✅ Success Modal -->
<c:if test="${modalSuccess}">
    <div class="modal" style="display:block" id="deleteSuccessModal">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">🗑️ Note Deleted!</p>
            <p>The note <strong>${deletedFile}</strong> has been deleted successfully.</p>
            <form action="/dashboard" method="get">
                <button type="submit">Go to Dashboard</button>
            </form>
        </div>
    </div>
</c:if>

</body>
</html>
