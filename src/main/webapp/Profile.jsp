<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.UserEntity"%>
<%
UserEntity user = (UserEntity) session.getAttribute("user");
if (user == null) {
	response.sendRedirect("Login.jsp");
	return;
}
int xp = user.getXp();
if (xp > 100) {
	int dig = xp / 100;
	xp = xp - (dig * 100);
}
int xpLeft = 100 - xp;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>SoloSkilling | Profile</title>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Orbitron', sans-serif;
    }

    body {
      background: url("Images/wallpaper.jpg") no-repeat center center/cover;
      min-height: 100vh;
      color: #fff;
      display: flex;
      flex-direction: column;
    }

    header {
      background: rgba(0, 0, 0, 0.6);
      padding: 20px 40px;
      font-size: 26px;
      color: #5fffd0;
      box-shadow: 0 0 15px #5fffd0;
      text-align: center;
      letter-spacing: 2px;
      text-shadow: 0 0 10px #5fffd0;
    }

    .profile-container {
      flex-grow: 1;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .profile-box {
      background: rgba(0, 0, 0, 0.5);
      border: 2px solid #5fffd0;
      box-shadow: 0 0 15px #5fffd0, 0 0 30px #9e7cff;
      backdrop-filter: blur(10px);
      padding: 40px;
      border-radius: 20px;
      width: 500px;
      text-align: center;
      animation: fadeIn 1.2s ease-in;
    }

    .avatar-circle {
      width: 100px;
      height: 100px;
      background: rgba(0,255,255,0.1);
      border: 2px solid #5fffd0;
      border-radius: 50%;
      margin: 0 auto 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 40px;
      color: #5fffd0;
      box-shadow: 0 0 20px #5fffd0;
      text-shadow: 0 0 10px #5fffd0;
    }

    .profile-box h2 {
      font-size: 24px;
      color: #5fffd0;
      margin-bottom: 20px;
      text-shadow: 0 0 10px #5fffd0;
    }

    .profile-info {
      text-align: left;
      font-size: 16px;
      line-height: 2;
      margin-bottom: 20px;
    }

    .profile-info span {
      color: #5fffd0;
      font-weight: bold;
      display: inline-block;
      width: 120px;
    }

    .xp-section p {
      font-size: 16px;
    }

    .xp-bar-container {
      width: 300px;
      height: 20px;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 10px;
      border: 1px solid #5fffd0;
      margin: 10px auto;
      overflow: hidden;
      box-shadow: 0 0 10px #5fffd0;
    }

    .xp-bar {
      height: 100%;
      width: <%= xp %>%;
      background: linear-gradient(to right, #5fffd0, #9e7cff);
      transition: width 1s ease-in-out;
    }

    .back-btn {
      margin-top: 30px;
    }

    .back-btn a {
      text-decoration: none;
      padding: 12px 20px;
      background: #5fffd0;
      color: #000;
      font-weight: bold;
      border-radius: 8px;
      font-size: 14px;
      box-shadow: 0 0 10px #5fffd0;
      transition: all 0.3s ease;
    }

    .back-btn a:hover {
      background: #00e6a8;
      box-shadow: 0 0 20px #00e6a8;
      color: #000;
    }

    footer {
      text-align: center;
      padding: 12px;
      font-size: 13px;
      color: #888;
      background: rgba(0, 0, 0, 0.6);
      box-shadow: 0 -1px 5px #5fffd0;
      margin-top: auto;
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  </style>
</head>

<body>

  <header>🧑‍💻 SoloSkilling | Profile</header>

  <div class="profile-container">
    <div class="profile-box">
      
      <div class="avatar-circle">
        <%= user.getName().charAt(0) %>
      </div>

      <h2>Your Info</h2>

      <div class="profile-info">
        <p><span>Name:</span> <%= user.getName() %></p>
        <p><span>Username:</span> <%= user.getUsername() %></p>
        <p><span>Email:</span> <%= user.getEmail() %></p>
      </div>

      <div class="xp-section">
        <p>
          <strong>Level <%= user.getLevel() %></strong>
          <span style="color: #5fffd0;"> (XP: <%= xp %> / 100)</span>
        </p>

        <div class="xp-bar-container">
          <div class="xp-bar"></div>
        </div>

        <p style="font-size: 14px; color: #aaa;">
          Only <span style="color: #5fffd0;"><%= xpLeft %> XP</span> to Level <%= user.getLevel() + 1 %> 🚀
        </p>
      </div>

      <div class="back-btn">
        <a href="Dashboard.jsp">⬅ Back to Dashboard</a>
      </div>

    </div>
  </div>

  <footer>&copy; 2025 SoloSkilling. Stay grinding, stay glowing 💻⚔️</footer>

</body>
</html>
