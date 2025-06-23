<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Upload Note</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .upload-wrapper {
            max-width: 700px;
            margin: 80px auto;
            padding: 40px;
            background-color: var(--form-bg);
            color: var(--text-color);
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: left;
        }

        .upload-wrapper h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .upload-wrapper label {
            font-weight: bold;
            margin-bottom: 6px;
            display: inline-block;
        }

        .upload-wrapper input[type="file"],
        .upload-wrapper input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .upload-wrapper input[type="submit"] {
            width: 100%;
        }

        #file-feedback {
            margin-top: -12px;
            margin-bottom: 18px;
            font-size: 0.9em;
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

<div class="upload-wrapper">
    <h2>📁 Upload a .txt Note</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p class="success small-text">📁 File received. Processing upload...</p>
    </c:if>

    <form class="form-card" action="/note/upload" method="post" enctype="multipart/form-data">
        <label for="file">Select a .txt File:</label>
        <input type="file" name="file" accept=".txt" required onchange="handleFileSelect(event)" />
        <p id="file-feedback" class="success small-text" style="display: none;"></p>

        <label for="filenameInput">Optional Filename:</label>
        <input type="text" name="filename" id="filenameInput" placeholder="Leave blank to use file name" />

        <input type="submit" value="📤 Upload Note" />
    </form>

    <div class="navigation-links">
        <form action="/dashboard" method="get">
            <input type="submit" value="⬅️ Back to Dashboard" />
        </form>
    </div>
</div>

<!-- ✅ Upload Success Modal -->
<c:if test="${not empty modalSuccess}">
    <div class="modal" id="uploadSuccessModal" style="display:block">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Upload Successful!</p>
            <p>The note <strong>${uploadedFile}</strong> has been uploaded and saved.</p>

            <div class="btn-row">
                <form action="/note/upload" method="get">
                    <button type="submit">🔁 Upload Another</button>
                </form>
                <form action="/dashboard" method="get">
                    <button type="submit">🏠 Go to Dashboard</button>
                </form>
            </div>
        </div>
    </div>
</c:if>

<!-- ✅ JS: File Feedback + Autofill -->
<script>
    function handleFileSelect(event) {
        const fileInput = event.target;
        const file = fileInput.files[0];
        const feedback = document.getElementById("file-feedback");
        const filenameInput = document.getElementById("filenameInput");

        if (file && file.name.endsWith(".txt")) {
            feedback.textContent = `✅ File selected: ${file.name}`;
            feedback.style.display = "block";
            feedback.style.color = "#4caf50";

            if (!filenameInput.value) {
                filenameInput.value = file.name;
            }
        } else {
            feedback.textContent = "❌ Invalid file type. Only .txt files are allowed.";
            feedback.style.display = "block";
            feedback.style.color = "red";
        }
    }
</script>

</body>
</html>
