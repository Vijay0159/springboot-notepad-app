<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Upload Note</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>

    <h2>Upload .txt File</h2>

    <!-- ✅ Optional message (e.g. duplicate filename or file rejected) -->
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

    <!-- ✅ Success Modal -->
    <c:if test="${not empty modalSuccess}">
        <div class="modal" id="uploadSuccessModal" style="display:block">
            <div class="modal-content">
                <p style="font-size: 18px; font-weight: bold;">✅ Upload Successful!</p>
                <p>The note <strong>${uploadedFile}</strong> has been uploaded and saved.</p>
                <form action="/dashboard" method="get">
                    <button type="submit">Go to Dashboard</button>
                </form>
            </div>
        </div>
    </c:if>

    <!-- ✅ JS to show selected file info and autofill filename -->
    <script>
        function handleFileSelect(event) {
            const fileInput = event.target;
            const file = fileInput.files[0];
            const feedback = document.getElementById("file-feedback");
            const filenameInput = document.getElementById("filenameInput");

            if (file && file.name.endsWith(".txt")) {
                feedback.textContent = `✅ File selected`;
                feedback.style.display = "block";

                // Auto-fill optional filename if field is empty
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
