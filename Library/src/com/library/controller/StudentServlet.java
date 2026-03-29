package com.library.controller;

import com.library.dao.StudentDAO;
import com.library.model.Student;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private StudentDAO studentDAO;

  public void init() {
    studentDAO = new StudentDAO();
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("admin") == null) {
      response.sendRedirect("login.jsp");
      return;
    }

    String action = request.getParameter("action");
    if ("add".equals(action)) {
      addStudent(request, response);
    }
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("admin") == null) {
      response.sendRedirect("login.jsp");
      return;
    }

    String action = request.getParameter("action");
    if (action == null) {
      listStudents(request, response);
    } else if ("delete".equals(action)) {
      deleteStudent(request, response);
    } else {
      listStudents(request, response);
    }
  }

  private void listStudents(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    List<Student> listStudents = studentDAO.getAllStudents();
    request.setAttribute("listStudents", listStudents);
    request.getRequestDispatcher("students/view_students.jsp").forward(request, response);
  }

  private void addStudent(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String branch = request.getParameter("branch");
    int year = Integer.parseInt(request.getParameter("year"));

    Student newStudent = new Student(0, name, email, branch, year);
    studentDAO.addStudent(newStudent);
    response.sendRedirect("StudentServlet");
  }

  private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    studentDAO.deleteStudent(id);
    response.sendRedirect("StudentServlet");
  }
}
