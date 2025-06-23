<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Trashed Notes</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
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

        td form {
            display: inline-block;
            margin-right: 8px;
        }

        .modal-buttons {
            display: flex;
            justify-content: space-around;
            gap: 10px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .modal-buttons form {
            flex: 1;
            min-width: 120px;
        }

        .modal-buttons button {
            width: 100%;
        }

        .info {
            text-align: center;
            font-size: 0.95em;
            color: gray;
            margin-top: 20px;
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

<div class="container">
    <h2>🗑️ Trashed Notes</h2>

    <!-- 🔍 Search bar -->
    <div class="search-bar">
        <input type="search" id="searchInput" placeholder="🔎 Search filename..." />
    </div>

    <c:if test="${empty trashedNotes}">
        <p class="info">No notes in trash.</p>
    </c:if>

    <c:if test="${not empty trashedNotes}">
        <table id="trashTable">
            <thead>
                <tr>
                    <th>📁 Filename</th>
                    <th>🕓 Deleted At</th>
                    <th>⚙️ Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="note" items="${trashedNotes}">
                    <tr>
                        <td class="filename-cell">${note.filename}</td>
                        <td>${note.deletedAt}</td>
                        <td>
                            <form method="post" action="/note/trash/restore">
                                <input type="hidden" name="trashId" value="${note.id}" />
                                <button type="submit">♻️ Restore</button>
                            </form>
                            <form method="post" action="/note/trash/delete-permanent" onsubmit="return confirm('Are you sure you want to permanently delete this note?');">
                                <input type="hidden" name="trashId" value="${note.id}" />
                                <button type="submit" style="background-color: #d9534f;">🗑️ Delete Permanently</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- ✅ Restore Modal -->
    <c:if test="${modalSuccess}">
        <div class="modal" style="display:block" id="restoreSuccessModal">
            <div class="modal-content">
                <p style="font-size: 20px; font-weight: bold;">✅ Note Restored!</p>
                <p>The note <strong>${restoredFile}</strong> has been successfully restored.</p>
                <div class="modal-buttons">
                    <form method="get" action="/note/trash">
                        <button type="submit">🔁 Stay Here</button>
                    </form>
                    <form method="get" action="/dashboard">
                        <button type="submit">🏠 Go to Dashboard</button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <!-- 🗑️ Delete Modal -->
    <c:if test="${permanentDeleteSuccess}">
        <div class="modal" style="display:block" id="permanentDeleteModal">
            <div class="modal-content">
                <p style="font-size: 20px; font-weight: bold;">🗑️ Note Deleted Permanently!</p>
                <p>The note <strong>${deletedFile}</strong> has been permanently removed.</p>
                <div class="modal-buttons">
                    <form method="get" action="/note/trash">
                        <button type="submit">🔁 Stay Here</button>
                    </form>
                    <form method="get" action="/dashboard">
                        <button type="submit">🏠 Go to Dashboard</button>
                    </form>
                </div>
            </div>
        </div>
    </c:if>

    <br>
    <form action="/dashboard" method="get" style="text-align:center;">
        <input type="submit" value="🏠 Back to Dashboard" />
    </form>
</div>

<script>
    document.getElementById("searchInput").addEventListener("input", function () {
        const value = this.value.toLowerCase();
        const rows = document.querySelectorAll("#trashTable tbody tr");

        rows.forEach(row => {
            const filename = row.querySelector(".filename-cell").textContent.toLowerCase();
            row.style.display = filename.includes(value) ? "" : "none";
        });
    });
</script>

</body>
</html>
