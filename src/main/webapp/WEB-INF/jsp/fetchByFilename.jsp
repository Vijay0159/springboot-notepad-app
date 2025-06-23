<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Fetch by Filename</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .container {
            max-width: 700px;
            margin: 80px auto 30px auto;
            padding: 30px 40px;
            background-color: var(--form-bg);
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }

        .note-preview {
            background-color: #1e1e1e;
            color: #f1f1f1;
            padding: 20px;
            margin-top: 20px;
            border-radius: 8px;
            text-align: left;
        }

        .note-preview .note-meta {
            margin-bottom: 12px;
            line-height: 1.5;
        }

        .note-preview .note-meta div {
            margin: 4px 0;
            color: #cccccc;
        }

        .scrollable-content {
            overflow-x: auto;
            background-color: #1e1e1e;
            padding: 10px;
            border-radius: 6px;
            color: #f1f1f1;
            white-space: pre-wrap;
            word-wrap: break-word;
            font-family: monospace;
            font-size: 14px;
        }

        .btn-row {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        .btn-row button, .btn-row input[type="submit"] {
            padding: 10px 22px;
            font-size: 14px;
            background-color: var(--button-bg);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .btn-row button:hover, .btn-row input[type="submit"]:hover {
            background-color: var(--button-hover);
        }

        .info {
            font-size: 0.95em;
            color: gray;
            margin-top: 25px;
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

<!-- 🌐 Page Body -->
<div class="container">
    <h2>📂 Fetch Note by Filename</h2>

    <!-- ❌ Error -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <!-- 🔎 Input Form -->
    <form action="/note/fetch/by-filename" method="post">
        <input type="text" name="filename" placeholder="Enter filename..." required />
        <br/>
        <input type="submit" value="Fetch" />
    </form>

    <!-- ✅ Result -->
    <c:if test="${not empty note}">
        <div class="note-preview">
            <div class="note-meta">
                <div><strong>Filename:</strong> ${note.filename}</div>
                <div><strong>Content:</strong></div>
            </div>
            <div class="scrollable-content">
                <pre>${note.content}</pre>
            </div>
        </div>

        <form action="/note/download/single" method="post" class="btn-row">
            <input type="hidden" name="noteId" value="${note.id}" />
            <button type="submit">⬇️ Download This Note</button>
        </form>
    </c:if>

    <!-- ℹ️ Info if empty -->
    <c:if test="${empty note and empty error}">
        <p class="info">🔍 Enter a filename above to fetch and view your note. Once found, you can also download it.</p>
    </c:if>

    <div class="btn-row">
        <form action="/dashboard" method="get">
            <input type="submit" value="🏠 Back to Dashboard" />
        </form>
    </div>
</div>

</body>
</html>
