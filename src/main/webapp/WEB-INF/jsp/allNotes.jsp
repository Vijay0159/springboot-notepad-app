<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>All Notes</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css' />" />
    <style>
        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 90%;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 16px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .back-button {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>📄 All Your Notes</h2>

    <c:if test="${empty notes}">
        <p>No notes found.</p>
    </c:if>

    <c:if test="${not empty notes}">
        <table>
            <thead>
                <tr>
                    <th>Note ID</th>
                    <th>Filename</th>
                    <th>Content (Preview)</th>
                    <th>User Type</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="note" items="${notes}">
                    <tr>
                        <td>${note.id}</td>
                        <td>${note.filename}</td>
                        <td>
                            <c:choose>
                                <c:when test="${fn:length(note.content) > 100}">
                                    ${fn:substring(note.content, 0, 100)}...
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
        </table>
    </c:if>

    <div class="back-button">
        <a href="/dashboard"><input type="submit" value="Back to Dashboard" /></a>
    </div>
</body>
</html>
