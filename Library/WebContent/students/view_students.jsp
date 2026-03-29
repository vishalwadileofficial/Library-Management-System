<%@ page import="java.util.List" %>
  <%@ page import="com.library.model.Student" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/sidebar.jsp" %>

          <div class="main-content">
            <div class="header">
              <h1>Student Management</h1>
              <a href="students/add_student.jsp" class="btn">Add New Student</a>
            </div>

            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Branch</th>
                  <th>Year</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <% List<Student> listStudents = (List<Student>) request.getAttribute("listStudents");
                    if (listStudents != null) {
                    for (Student student : listStudents) {
                    %>
                    <tr>
                      <td>
                        <%= student.getId() %>
                      </td>
                      <td>
                        <%= student.getName() %>
                      </td>
                      <td>
                        <%= student.getEmail() %>
                      </td>
                      <td>
                        <%= student.getBranch() %>
                      </td>
                      <td>
                        <%= student.getYear() %>
                      </td>
                      <td>
                        <a href="StudentServlet?action=delete&id=<%= student.getId() %>" class="text-danger"
                          onclick="return confirmDelete()">Delete</a>
                      </td>
                    </tr>
                    <% } } else { %>
                      <tr>
                        <td colspan="6">No students found.</td>
                      </tr>
                      <% } %>
              </tbody>
            </table>
          </div>

          <%@ include file="../includes/footer.jsp" %>