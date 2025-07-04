<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>All Notes</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />" />
    <style>
    .bulk-actions {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin: 15px auto 25px auto;
        flex-wrap: wrap;
    }

    .bulk-actions button {
        background-color: var(--button-bg);
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 8px;
        cursor: pointer;
    }

    .bulk-actions button:hover {
        background-color: var(--button-hover);
    }

    .checkbox-cell {
        text-align: center;
    }

        .container {
            max-width: 1200px;
            margin: 80px auto;
            padding: 30px 40px;
            background-color: var(--form-bg);
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .sort-controls {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }

        .sort-controls label {
            font-weight: bold;
        }

        .sort-controls select,
        .sort-controls input[type="submit"] {
            padding: 8px 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
            background-color: var(--form-bg);
            color: var(--text-color);
        }

        .sort-controls input[type="submit"]:hover {
            background-color: var(--button-hover);
            color: white;
        }

        .search-bar {
            display: flex;
            justify-content: center;
            margin-bottom: 25px;
        }

        .search-bar input[type="search"] {
            width: 300px;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            background-color: var(--form-bg);
            color: var(--text-color);
        }

        .download-btn {
            text-align: center;
            margin-bottom: 20px;
        }

        .download-btn button {
            background-color: var(--button-bg);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
        }

        .download-btn button:hover {
            background-color: var(--button-hover);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--form-bg);
            color: var(--text-color);
            table-layout: fixed;
            word-wrap: break-word;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid #ccc;
            text-align: left;
            vertical-align: top;
        }

        th {
            background-color: var(--button-bg);
            color: white;
        }

        tr:nth-child(even) {
            background-color: rgba(0, 0, 0, 0.02);
        }

        td.content-cell {
            max-width: 400px;
        }

        .preview,
        .full-content {
            white-space: pre-wrap;
            word-break: break-word;
            overflow-x: auto;
            max-width: 100%;
        }

        .full-content {
            display: none;
            margin-top: 5px;
        }

        .toggle-btn {
            background: none;
            color: var(--link-color);
            border: none;
            cursor: pointer;
            font-size: 14px;
            padding: 0;
            margin-top: 6px;
        }

        .back-button {
            text-align: center;
            margin-top: 40px;
        }

        .info {
            text-align: center;
            font-size: 0.95em;
            color: gray;
        }
        /* ✅ Checkbox Column Styling */
        .checkbox-cell {
            text-align: center;
            vertical-align: middle;
            width: 40px;
        }

        input[type="checkbox"] {
            transform: scale(1.2);
            accent-color: var(--button-bg); /* ✅ Matches your theme color */
            cursor: pointer;
            margin: auto;
        }

        /* Align checkbox in table header */
        th.checkbox-cell input[type="checkbox"] {
            margin-top: 2px;
        }

        .bulk-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
            flex-wrap: wrap;
        }

        .bulk-actions button {
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 6px;
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

<!-- 📦 Main Container -->
<div class="container">

    <h2>📄 All Your Notes</h2>

    <!-- 🔃 Sorting -->
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

    <!-- 🔍 Search -->
    <div class="search-bar">
        <input type="search" id="searchInput" placeholder="🔎 Search filename..." />
    </div>

    <!-- 📥 ZIP Download -->
    <c:if test="${not empty notes}">
        <div class="download-btn">
            <form method="post" action="/note/download/all">
                <button type="submit">📦 Download All Notes (ZIP)</button>
            </form>
        </div>
    </c:if>

    <!-- 📋 Table -->
    <c:if test="${not empty notes}">
        <form method="post" id="bulkForm">

    <div class="bulk-actions">
        <button type="button" onclick="selectAllCheckboxes(true)">✅ Select All</button>
        <button type="button" onclick="selectAllCheckboxes(false)">❌ Deselect All</button>
        <button type="submit" formaction="/note/bulk-download">⬇️ Download Selected</button>
        <button type="submit" formaction="/note/bulk-delete" onclick="return confirm('Move selected notes to Trash?');">🗑️ Delete Selected</button>
    </div>

    <table id="notesTable"> <!-- ✅ Start table here -->
        <thead>
            <tr>
                <th class="checkbox-cell"><input type="checkbox" onclick="toggleSelectAll(this)" /></th>
                <th>Note ID</th>
                <th>Filename</th>
                <th>Content</th>
                <th>User Type</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="note" items="${notes}">
                <tr>
                    <td class="checkbox-cell">
                        <input type="checkbox" name="selectedIds" value="${note.id}" class="note-checkbox" />
                    </td>
                    <td>${note.id}</td>
                    <td class="filename-cell">${note.filename}</td>
                    <td class="content-cell">
                        <c:choose>
                            <c:when test="${fn:length(note.content) > 100}">
                                <div class="preview">${fn:substring(note.content, 0, 100)}...</div>
                                <div class="full-content">${note.content}</div>
                                <button type="button" class="toggle-btn" onclick="toggleContent(this)">🔽 Show More</button>

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
    </table> <!-- ✅ Close table here -->
</form>


    </c:if>

    <!-- ❗Empty -->
    <c:if test="${empty notes}">
        <p class="info">No notes found. Create one from dashboard to see them here!</p>
    </c:if>

    <!-- 🔙 Back -->
    <div class="back-button">
    <!-- ✅ Bulk Delete Modal -->
    <c:if test="${bulkDeleteSuccess}">
        <div class="modal" style="display:block;" id="bulkDeleteModal">
            <div class="modal-content">
                <p style="font-size: 20px; font-weight: bold;">🗑️ Notes Moved to Trash</p>
                <p>${deletedFile}</p>
                <div class="modal-buttons">
                    <form method="get" action="/note/fetch/all">
                        <button type="submit">🔁 Stay Here</button>
                    </form>
                    <form method="get" action="/dashboard">
                        <button type="submit">🏠 Go to Dashboard</button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <!-- ✅ Bulk Download Modal (Optional: if you plan to show success message) -->
    <c:if test="${bulkDownloadSuccess}">
        <div class="modal" style="display:block;" id="bulkDownloadModal">
            <div class="modal-content">
                <p style="font-size: 20px; font-weight: bold;">⬇️ Notes Downloaded</p>
                <p>${downloadedFile}</p>
                <div class="modal-buttons">
                    <form method="get" action="/note/fetch/all">
                        <button type="submit">🔁 Stay Here</button>
                    </form>
                    <form method="get" action="/dashboard">
                        <button type="submit">🏠 Go to Dashboard</button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

        <form action="/dashboard" method="get">
            <input type="submit" value="🏠 Back to Dashboard" />
        </form>
    </div>
</div>

<!-- 📜 JS -->
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

document.getElementById("searchInput").addEventListener("input", function () {
    const value = this.value.toLowerCase();
    const rows = document.querySelectorAll("#notesTable tbody tr");

    rows.forEach(row => {
        const filename = row.querySelector(".filename-cell").textContent.toLowerCase();
        row.style.display = filename.includes(value) ? "" : "none";
    });
});

function selectAllCheckboxes(value) {
    document.querySelectorAll('.note-checkbox').forEach(cb => cb.checked = value);
}

function toggleSelectAll(source) {
    selectAllCheckboxes(source.checked);
}

document.getElementById("bulkForm").addEventListener("submit", function (e) {
    const anyChecked = [...document.querySelectorAll(".note-checkbox")].some(cb => cb.checked);
    if (!anyChecked) {
        e.preventDefault();
        alert("⚠️ Please select at least one note to perform this action.");
    }
});
</script>


</body>
</html>
