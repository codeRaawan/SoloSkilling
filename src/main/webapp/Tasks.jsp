<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="entity.TaskEntity" %>
<%@ page import="entity.UserEntity" %>
<%@ page import="dao.TaskDao" %>
<%@ page import="connect.ConnectToDB" %>
<%
UserEntity user = (UserEntity) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>SoloSkilling | Task List</title>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Orbitron', sans-serif;
    }

    body {
      background: url('Images/dashboard.jpg') no-repeat center center/cover;
      background-attachment:fixed;
      color: #fff;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .header-container {
      background: rgba(0, 0, 0, 0.7);
      padding: 20px 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 0 15px #5fffd0;
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .logo-title {
      display: flex;
      align-items: center;
      font-size: 26px;
      color: #5fffd0;
      text-shadow: 0 0 10px #5fffd0;
    }

    .logo-title img {
      height: 40px;
      margin-right: 15px;
    }

    .profile-dropdown {
      position: relative;
    }

    .profile-btn {
      background: transparent;
      border: 2px solid #5fffd0;
      color: #5fffd0;
      padding: 10px 16px;
      font-size: 14px;
      border-radius: 10px;
      cursor: pointer;
      text-shadow: 0 0 5px #5fffd0;
      transition: all 0.3s ease;
    }

    .profile-btn:hover {
      background-color: #5fffd0;
      color: #000;
      box-shadow: 0 0 20px #5fffd0;
    }

    .dropdown-content {
      display: none;
      position: absolute;
      right: 0;
      margin-top: 10px;
      background: rgba(0, 0, 0, 0.95);
      min-width: 180px;
      border: 1px solid #5fffd0;
      border-radius: 10px;
      box-shadow: 0 0 20px #5fffd0;
      z-index: 100;
    }

    .dropdown-content a {
      color: #5fffd0;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
      font-weight: bold;
    }

    .profile-dropdown:hover .dropdown-content {
      display: block;
    }

    .task-section {
      max-width: 1000px;
      margin: 40px auto;
      padding: 30px;
      background: rgba(0, 0, 0, 0.6);
      border: 2px solid #5fffd0;
      border-radius: 20px;
      box-shadow: 0 0 20px #5fffd0;
    }

    .task-section h2 {
      text-align: center;
      color: #5fffd0;
      margin-bottom: 30px;
      text-shadow: 0 0 10px #5fffd0;
      font-size: 28px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      color: #fff;
      background: rgba(255, 255, 255, 0.03);
    }

    th, td {
      padding: 14px;
      border-bottom: 1px solid #5fffd040;
      text-align: left;
    }

    th {
      background-color: rgba(0, 255, 255, 0.1);
      color: #5fffd0;
      font-weight: bold;
      text-shadow: 0 0 5px #5fffd0;
    }

    td {
      color: #ddd;
    }

    tr:hover {
      background-color: rgba(95, 255, 208, 0.08);
      box-shadow: 0 0 10px #5fffd020;
    }

    .go-back {
      text-align: center;
      margin-top: 30px;
    }

    .go-back a {
      color: #5fffd0;
      font-weight: bold;
      text-decoration: none;
      padding: 10px 20px;
      border: 1px solid #5fffd0;
      border-radius: 10px;
      transition: all 0.3s;
    }

    .go-back a:hover {
      background-color: #5fffd0;
      color: #000;
      box-shadow: 0 0 20px #5fffd0;
    }

    footer {
      text-align: center;
      padding: 12px;
      font-size: 13px;
      color: #888;
      background: rgba(0, 0, 0, 0.6);
      margin-top: auto;
    }
  </style>
</head>
<body>

  <div class="header-container">
    <div class="logo-title">
      <img src="Images/logo.png" alt="Logo" />
      SoloSkilling | Task List
    </div>
    <div class="profile-dropdown">
      <button class="profile-btn">👤 <%= user.getName() %></button>
      <div class="dropdown-content">
        <a href="Profile.jsp">Profile</a>
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="LogoutServlet">Logout</a>
      </div>
    </div>
  </div>

  <div class="task-section">
    <h2>📋 All Assigned Tasks</h2>
    <table>
      <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Subject</th>
        <th>XP</th>
      </tr>

      <%
        TaskDao tdao = new TaskDao(ConnectToDB.getConn());
        List<TaskEntity> taskEntity = tdao.getAllTasks();

        for (TaskEntity task : taskEntity) {
      %>
      <tr>
        <td><%= task.getTaskTitle() %></td>
        <td><%= task.getTaskDescription() %></td>
        <td><%= task.getTaskSubject() %></td>
        <td><%= task.getTaskXP() %> XP</td>
      </tr>
      <% } %>
    </table>

    <div class="go-back">
      <a href="Dashboard.jsp"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>
  </div>

  <footer>&copy; 2025 SoloSkilling. Forge your path, conquer your quest. ⚔️</footer>

</body>
</html>
