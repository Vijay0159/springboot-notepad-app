<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>All Notes</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />" />
    <style>
        table {
            margin: 30px auto;
            border-collapse: collapse;
            width: 90%;
            background-color: var(--form-bg);
            color: var(--text-color);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.15);
            transition: background-color 0.3s, color 0.3s;
        }

        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }

        th {
            background-color: var(--button-bg);
            color: white;
        }

        tr:nth-child(even) {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .toggle-btn {
            background: none;
            color: var(--link-color);
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .full-content {
            display: none;
            white-space: pre-wrap;
            margin-top: 5px;
        }

        .back-button {
            margin-top: 30px;
        }
    </style>
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

<h2>📄 All Your Notes</h2>
<div class="sort-controls">
    <form method="get" action="/note/fetch/all">
        <label for="sortBy">Sort by:</label>
        <select name="sortBy" id="sortBy">
            <option value="id" ${sortBy == 'id' ? 'selected' : ''}>Note ID</option>
            <option value="filename" ${sortBy == 'filename' ? 'selected' : ''}>Filename</option>
        </select>

        <label for="order">Order:</label>
        <select name="order" id="order">
            <option value="asc" ${order == 'asc' ? 'selected' : ''}>Ascending</option>
            <option value="desc" ${order == 'desc' ? 'selected' : ''}>Descending</option>
        </select>

        <input type="submit" value="Sort" />
    </form>
</div>


<c:if test="${empty notes}">
    <p>No notes found.</p>
</c:if>
<c:if test="${not empty notes}">
    <form method="post" action="/note/download/all" style="text-align:center; margin-top: 10px;">
        <button type="submit">📦 Download All Notes (ZIP)</button>
    </form>
</c:if>

<c:if test="${not empty notes}">
    <table>
        <thead>
            <tr>
                <th>Note ID</th>
                <th>Filename</th>
                <th>Content (Preview)</th>
                <th>User Type</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="note" items="${notes}">
                <tr>
                    <td>${note.id}</td>
                    <td>${note.filename}</td>
                    <td>
                        <c:choose>
                            <c:when test="${fn:length(note.content) > 100}">
                                <div class="preview">${fn:substring(note.content, 0, 100)}...</div>
                                <div class="full-content">${note.content}</div>
                                <button class="toggle-btn" onclick="toggleContent(this)">🔽 Show More</button>
                            </c:when>
                            <c:otherwise>
                                ${note.content}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${note.userType}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

<div class="back-button">
    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>
</div>

<script>
function toggleContent(btn) {
    const preview = btn.previousElementSibling.previousElementSibling;
    const full = btn.previousElementSibling;

    if (full.style.display === "none" || full.style.display === "") {
        full.style.display = "block";
        preview.style.display = "none";
        btn.innerHTML = "🔼 Show Less";
    } else {
        full.style.display = "none";
        preview.style.display = "block";
        btn.innerHTML = "🔽 Show More";
    }
}
</script>

</body>
</html>
