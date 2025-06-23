<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Update Note by ID</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .update-wrapper {
            max-width: 700px;
            margin: 80px auto;
            padding: 40px;
            background-color: var(--form-bg);
            color: var(--text-color);
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: left;
        }

        .update-wrapper h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .update-wrapper label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        .update-wrapper input[type="number"],
        .update-wrapper input[type="text"],
        .update-wrapper textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .update-wrapper input[type="submit"] {
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
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }

        .modal-content .btn-row button {
            min-width: 160px;
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

<div class="update-wrapper">
    <h2>✏️ Update Note by ID</h2>

    <c:if test="${not empty message}">
        <p class="success">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form class="form-card" action="/note/update/by-id" method="post">
        <label for="noteId">Note ID:</label>
        <input type="number" name="noteId" id="noteId" required />

        <label for="filename">New Filename:</label>
        <input type="text" name="filename" id="filename" required />

        <label for="content">New Content:</label>
        <textarea name="content" id="content" rows="8" required></textarea>

        <input type="submit" value="✏️ Update Note" />
    </form>

    <div class="navigation-links">
        <form action="/dashboard" method="get">
            <input type="submit" value="⬅️ Back to Dashboard" />
        </form>
    </div>
</div>

<!-- ✅ Success Modal -->
<c:if test="${not empty modalSuccess}">
    <div class="modal" id="updateSuccessModal" style="display:block">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Note Updated Successfully!</p>
            <p>The note <strong>${updatedFile}</strong> has been updated.</p>

            <div class="btn-row">
                <form action="/note/update/by-id" method="get">
                    <button type="submit">🔁 Update Another</button>
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
