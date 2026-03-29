package com.library.controller;

import com.library.dao.AdminDAO;
import com.library.model.Admin;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private AdminDAO adminDAO;

  public void init() {
    adminDAO = new AdminDAO();
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Admin admin = adminDAO.login(username, password);

    if (admin != null) {
      HttpSession session = request.getSession();
      session.setAttribute("admin", admin);
      response.sendRedirect("dashboard.jsp");
    } else {
      request.setAttribute("errorMessage", "Invalid Username or Password");
      request.getRequestDispatcher("login.jsp").forward(request, response);
    }
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    String action = request.getParameter("action");
    if ("logout".equals(action)) {
      HttpSession session = request.getSession(false);
      if (session != null) {
        session.invalidate();
      }
      response.sendRedirect("login.jsp");
    } else {
      response.sendRedirect("login.jsp");
    }
  }
}
