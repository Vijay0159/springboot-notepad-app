<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Upload Note</title>
    <link rel="stylesheet" href="/css/style.css">
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

<h2>Upload .txt File</h2>

<!-- ✅ Error or message -->
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>
<c:if test="${not empty message}">
    <p class="success small-text">📁 File received. Processing upload...</p>
</c:if>

<form action="/note/upload" method="post" enctype="multipart/form-data">
    File:
    <input type="file" name="file" accept=".txt" required onchange="handleFileSelect(event)" /><br/><br>
    <p id="file-feedback" class="success small-text" style="display: none;"></p>

    Optional Filename: <br>
    <input type="text" name="filename" id="filenameInput" /><br/>
    <input type="submit" value="Upload" />
</form><br><br>

<form action="/dashboard" method="get">
    <input type="submit" value="Back to Dashboard" />
</form>

<!-- ✅ Success Modal with Stay & Dashboard buttons -->
<c:if test="${not empty modalSuccess}">
    <div class="modal" id="uploadSuccessModal" style="display:block">
        <div class="modal-content">
            <p style="font-size: 18px; font-weight: bold;">✅ Upload Successful!</p>
            <p>The note <strong>${uploadedFile}</strong> has been uploaded and saved.</p>
            <div class="btn-row">
                <form action="/note/upload" method="get">
                    <button type="submit">🔁 Stay Here</button>
                </form>
                <form action="/dashboard" method="get">
                    <button type="submit">🏠 Go to Dashboard</button>
                </form>
            </div>
        </div>
    </div>
</c:if>

<!-- ✅ JS file feedback + autofill -->
<script>
    function handleFileSelect(event) {
        const fileInput = event.target;
        const file = fileInput.files[0];
        const feedback = document.getElementById("file-feedback");
        const filenameInput = document.getElementById("filenameInput");

        if (file && file.name.endsWith(".txt")) {
            feedback.textContent = `✅ File selected`;
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
