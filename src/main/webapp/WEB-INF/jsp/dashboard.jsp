<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        body {
            margin: 0;
        }

        .dashboard-wrapper {
            max-width: 1100px;
            margin: auto;
            padding-top: 60px;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 40px;
        }

        .section-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
        }

        .dashboard-card {
            width: 300px;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 25px;
            backdrop-filter: blur(6px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            text-align: center;
        }


        .dashboard-card:hover {
            transform: scale(1.02);
        }

        .dashboard-card h3 {
            margin-bottom: 18px;
        }

        .dashboard-card .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .dashboard-card .action-buttons a,
        .dashboard-card .action-buttons button {
            padding: 10px 18px;
            font-size: 15px;
            border: none;
            border-radius: 8px;
            color: white;
            background-color: var(--link-color);
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .dashboard-card .action-buttons a:hover,
        .dashboard-card .action-buttons button:hover {
            background-color: var(--button-hover);
        }

        .dashboard-card .danger {
            background-color: crimson;
        }

        .logout-container {
            text-align: center;
            margin-top: 60px;
        }

        .logout-container input[type="submit"] {
            background-color: #444;
            padding: 10px 22px;
            border-radius: 8px;
            color: white;
            border: none;
            cursor: pointer;
        }

        .logout-container input[type="submit"]:hover {
            background-color: #666;
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

<div class="dashboard-wrapper">
    <h2>👋 Welcome, <strong>${username}</strong></h2>

    <div class="section-grid">

        <div class="dashboard-card">
            <h3>📝 Create</h3>
            <div class="action-buttons">
                <a href="/note/create">➕ Create New Note</a>
            </div>
        </div>

        <div class="dashboard-card">
            <h3>📤 Upload</h3>
            <div class="action-buttons">
                <a href="/note/upload">📎 Upload .txt File</a>
            </div>
        </div>

        <div class="dashboard-card">
            <h3>🔍 Get Notes</h3>
            <div class="action-buttons">
                <a href="/note/fetch/by-id">🆔 By ID</a>
                <a href="/note/fetch/by-filename">📝 By Filename</a>
                <a href="/note/fetch/all">📚 All Notes</a>
            </div>
        </div>

        <div class="dashboard-card">
            <h3>✏️ Update</h3>
            <div class="action-buttons">
                <a href="/note/update/by-id">🆔 Update by ID</a>
                <a href="/note/update/by-filename">📝 Update by Filename</a>
            </div>
        </div>

        <div class="dashboard-card">
            <h3>🗑️ Delete</h3>
            <div class="action-buttons">
                <a href="/note/delete/by-id">🆔 Delete by ID</a>
                <a href="/note/delete/by-filename">📝 Delete by Filename</a>
            </div>
        </div>

        <div class="dashboard-card">
            <h3>🧹 Trash</h3>
            <div class="action-buttons">
                <a href="/note/trash">♻️ View Trash</a>
            </div>
        </div>

        <div class="dashboard-card">
            <h3>⚠️ Account</h3>
            <div class="action-buttons">
                <button class="danger" onclick="openDeleteModal()">🗑️ Delete Account</button>
            </div>
        </div>

    </div>

    <div class="logout-container">
        <form action="/logout" method="get">
            <input type="submit" value="🚪 Logout" />
        </form>
    </div>
</div>

<!-- ⚠️ Delete Account Modal -->
<!-- ⚠️ Delete Account Modal -->
<div id="deleteAccountModal" class="modal" style="display:none;">
    <div class="modal-content">
        <h3>⚠️ Confirm Account Deletion</h3>
        <p>
            This action will <strong>permanently delete your account</strong> along with <strong>all notes and data associated with it</strong>.
            <br><br>
            Are you absolutely sure you want to proceed? This cannot be undone.
        </p>
        <form action="/doDelete" method="post" style="margin-top: 20px;">
            <button type="submit" style="background-color: crimson;">Yes, Delete My Account</button>
        </form><br>
        <button onclick="closeDeleteModal()">Cancel</button>
    </div>
</div>


<script>
    function openDeleteModal() {
        document.getElementById("deleteAccountModal").style.display = "block";
    }

    function closeDeleteModal() {
        document.getElementById("deleteAccountModal").style.display = "none";
    }
</script>

</body>
</html>
