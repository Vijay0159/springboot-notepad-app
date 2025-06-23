<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create Note</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .create-note-wrapper {
            max-width: 600px;
            margin: 80px auto;
            padding: 40px;
            background-color: var(--form-bg);
            color: var(--text-color);
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            text-align: left;
        }

        .create-note-wrapper h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .create-note-wrapper label {
            display: block;
            font-weight: bold;
            margin-top: 20px;
            margin-bottom: 5px;
        }

        .create-note-wrapper input[type="text"],
        .create-note-wrapper textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: white;
            color: #333;
        }

        .create-note-wrapper textarea {
            resize: vertical;
        }

        .create-note-wrapper input[type="submit"] {
            margin-top: 25px;
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

<!-- 🧾 Main Form -->
<div class="create-note-wrapper">
    <h2>📝 Create a New Note</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form class="form-card" method="post" action="/note/create">
        <label for="filename">Filename</label>
        <input type="text" name="filename" id="filename" required />

        <label for="content">Content</label>
        <textarea name="content" id="content" rows="8" required></textarea>

        <input type="submit" value="Create Note" />
    </form>

    <div class="navigation-links">
        <form action="/dashboard" method="get">
            <input type="submit" value="⬅️ Back to Dashboard" />
        </form>
    </div>
</div>

<!-- ✅ Success Modal -->
<c:if test="${noteCreated}">
    <div class="modal" style="display:block" id="successModal">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Note Created Successfully!</p>
            <p>The note <strong>${filename}</strong> has been saved to your dashboard.</p>

            <div class="btn-row">
                <form action="/note/create" method="get">
                    <button type="submit">➕ Create Another</button>
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
