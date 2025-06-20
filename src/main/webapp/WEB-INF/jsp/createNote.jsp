<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Create Note</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        /* ✅ Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 30px;
            border-radius: 10px;
            width: 80%;
            max-width: 400px;
            text-align: center;
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
        }
        .modal-content button {
            padding: 10px 20px;
            margin-top: 15px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal-content button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <button onclick="toggleTheme()" style="position: absolute; top: 20px; right: 20px;">🌗 Toggle Theme</button>
    <script src="/js/theme.js"></script>

    <h2>Create a New Note</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form method="post" action="/note/create">
        Filename: <input type="text" name="filename" required /><br/>
        Content:<br/>
        <textarea name="content" rows="6" cols="40" required></textarea><br/>
        <input type="submit" value="Create Note" />
    </form><br><br>

    <form action="/dashboard" method="get">
        <input type="submit" value="Back to Dashboard" />
    </form>

    <!-- ✅ Modal HTML -->
    <div id="successModal" class="modal">
        <div class="modal-content">
            <h3>✅ Note Created!</h3>
            <p>The note <strong>${filename}</strong> was created successfully.</p>
            <form action="/dashboard" method="get">
                <button type="submit">Go to Dashboard</button>
            </form>
        </div>
    </div>

    <!-- ✅ Show modal only when noteCreated is true -->
    <c:if test="${noteCreated}">
        <script>
            document.getElementById("successModal").style.display = "block";
        </script>
    </c:if>

</body>
</html>
