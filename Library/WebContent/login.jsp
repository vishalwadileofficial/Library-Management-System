<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Library Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  </head>

  <body>
    <div class="login-container">
      <div class="login-box">
        <h2>Admin Login</h2>
        <% String errorMessage=(String) request.getAttribute("errorMessage"); if (errorMessage !=null) { %>
          <div class="alert alert-error">
            <%= errorMessage %>
          </div>
          <% } %>
            <form action="LoginServlet" method="post">
              <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" class="form-control" required placeholder="Enter username">
              </div>
              <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required placeholder="Enter password">
              </div>
              <button type="submit" class="btn">Login</button>
            </form>
      </div>
    </div>
  </body>

  </html>