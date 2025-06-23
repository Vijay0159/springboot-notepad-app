<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Delete Note by Filename</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .delete-wrapper {
            max-width: 600px;
            margin: 80px auto;
            padding: 40px;
            background-color: var(--form-bg);
            color: var(--text-color);
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: left;
        }

        .delete-wrapper h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .delete-wrapper label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .delete-wrapper input[type="text"] {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .delete-wrapper input[type="submit"] {
            margin-top: 20px;
            width: 100%;
        }

        .navigation-links {
            text-align: center;
            margin-top: 25px;
        }

        .navigation-links form {
            display: inline-block;
            margin: 0 10px;
        }

        .modal-content .btn-row {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        .modal-content .btn-row button {
            min-width: 150px;
        }
    </style>
</head>
<body>

<!-- 🌗 Theme Switcher -->
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

<!-- 🧾 Delete Form -->
<div class="delete-wrapper">
    <h2>🗑️ Delete Note by Filename</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form class="form-card" action="/note/delete/by-filename" method="post">
        <label for="filename">Enter the filename of the note to delete:</label>
        <input type="text" name="filename" id="filename" required />

        <input type="submit" value="🗑️ Delete Note" />
    </form>

    <div class="navigation-links">
        <form action="/dashboard" method="get">
            <input type="submit" value="⬅️ Back to Dashboard" />
        </form>
    </div>
</div>

<!-- ✅ Success Modal -->
<c:if test="${modalSuccess}">
    <div class="modal" style="display:block" id="deleteSuccessModal">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Note Deleted Successfully!</p>
            <p>The note <strong>${deletedFile}</strong> has been moved to trash.</p>

            <div class="btn-row">
                <form action="/note/delete/by-filename" method="get">
                    <button type="submit">🔁 Delete Another</button>
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
