<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.UserEntity" %>
<%
UserEntity user = (UserEntity) session.getAttribute("user");
if (user != null) {
	response.sendRedirect("Dashboard.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">


<head>
  <meta charset="UTF-8">
  <title>SoloSkilling | Login</title>

  <!-- Orbitron Font -->
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background: #000;
      font-family: 'Orbitron', sans-serif;
      overflow: hidden;
      color: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    #matrixCanvas {
      position: fixed;
      top: 0;
      left: 0;
      z-index: 0;
      width: 100vw;
      height: 100vh;
    }

    /* Header (Logo + Title) */
    .header {
      position: absolute;
      top: 20px;
      left: 30px;
      display: flex;
      align-items: center;
      z-index: 3;
    }

    .header img {
      width: 45px;
      height: 45px;
      border-radius: 8px;
      margin-right: 10px;
      filter: drop-shadow(0 0 8px #00ffc3);
    }

    .header h1 {
      font-size: 1.5em;
      color: #00ffc3;
      text-shadow: 0 0 10px #00ffc3;
    }

    .login-container {
      position: relative;
      z-index: 2;
      background: rgba(0, 0, 0, 0.3);
      padding: 45px 35px;
      border-radius: 20px;
      border: 2px solid #00ffc3;
      box-shadow:
        0 0 15px #00ffc3,
        0 0 30px #00ffc3,
        0 0 60px #005858;
      backdrop-filter: blur(10px);
      width: 420px;
      text-align: center;
    }

    .login-container h2 {
      font-size: 28px;
      margin-bottom: 25px;
      color: #00ffc3;
      text-shadow: 0 0 8px #00ffc3;
    }

    .login-container input {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border-radius: 10px;
      border: none;
      outline: none;
      background: rgba(255, 255, 255, 0.05);
      color: #0ff;
      font-size: 15px;
      border: 1px solid #0ff;
      box-shadow: inset 0 0 8px #0ff;
      transition: all 0.3s ease;
    }

    .login-container input::placeholder {
      color: #99f;
    }

    .login-container input:focus {
      background: rgba(0, 255, 255, 0.1);
      box-shadow: 0 0 12px #0ff;
    }

    .login-container button {
      margin-top: 20px;
      padding: 12px 25px;
      width: 100%;
      border: none;
      border-radius: 10px;
      background-color: #00ffc3;
      color: #000;
      font-weight: bold;
      font-size: 16px;
      cursor: pointer;
      transition: 0.3s ease-in-out;
      box-shadow: 0 0 12px #00ffc3;
    }

    .login-container button:hover {
      background-color: #00e6aa;
      box-shadow: 0 0 25px #00e6aa;
    }

    .login-container p {
      font-size: 13px;
      color: #ccc;
      margin-top: 18px;
    }

    .login-container a {
      color: #0ff;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }

    .login-container a:hover {
      text-shadow: 0 0 8px #0ff;
    }
  </style>
</head>
<body>

  <!-- Matrix Background -->
  <canvas id="matrixCanvas"></canvas>

  <!-- Header -->
  <div class="header">
    <img src="Images/logo.png" alt="SoloSkilling Logo">
    <h1>SoloSkilling</h1>
  </div>

  <!-- Login Form Container -->
  <div class="login-container">
    <h2>Welcome Back, Warrior</h2>

    <form action="LoginServlet" method="post">
      <input type="text" name="username" placeholder="Enter Username" required>
      <input type="password" name="password" placeholder="Enter Password" required>
      <button type="submit">Login</button>
    </form>

    <p>New to SoloSkilling? <a href="Register.jsp">Join Now</a></p>
  </div>

  <!-- Matrix Effect Script -->
  <script>
    const canvas = document.getElementById("matrixCanvas");
    const ctx = canvas.getContext("2d");

    canvas.height = window.innerHeight;
    canvas.width = window.innerWidth;

    let matrixChars = "アァイイウエオカキクケコABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    matrixChars = matrixChars.split("");

    let fontSize = 16;
    let columns = canvas.width / fontSize;
    let drops = Array(Math.floor(columns)).fill(1);

    function drawMatrix() {
      ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
      ctx.fillRect(0, 0, canvas.width, canvas.height);

      ctx.fillStyle = "#0F0";
      ctx.font = fontSize + "px monospace";

      for (let i = 0; i < drops.length; i++) {
        const text = matrixChars[Math.floor(Math.random() * matrixChars.length)];
        ctx.fillText(text, i * fontSize, drops[i] * fontSize);

        if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
          drops[i] = 0;
        }

        drops[i]++;
      }
    }

    setInterval(drawMatrix, 35);
  </script>

</body>
</html>
