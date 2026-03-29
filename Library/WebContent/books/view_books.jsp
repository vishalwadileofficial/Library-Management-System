<%@ page import="java.util.List" %>
  <%@ page import="com.library.model.Book" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/sidebar.jsp" %>

          <div class="main-content">
            <div class="header">
              <h1>Book Management</h1>
              <a href="books/add_book.jsp" class="btn">Add New Book</a>
            </div>

            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Title</th>
                  <th>Author</th>
                  <th>Category</th>
                  <th>Quantity</th>
                  <th>Available</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <% List<Book> listBooks = (List<Book>) request.getAttribute("listBooks");
                    if (listBooks != null) {
                    for (Book book : listBooks) {
                    %>
                    <tr>
                      <td>
                        <%= book.getId() %>
                      </td>
                      <td>
                        <%= book.getTitle() %>
                      </td>
                      <td>
                        <%= book.getAuthor() %>
                      </td>
                      <td>
                        <%= book.getCategory() %>
                      </td>
                      <td>
                        <%= book.getQuantity() %>
                      </td>
                      <td>
                        <%= book.getAvailable() %>
                      </td>
                      <td>
                        <a href="BookServlet?action=delete&id=<%= book.getId() %>" class="text-danger"
                          onclick="return confirmDelete()">Delete</a>
                      </td>
                    </tr>
                    <% } } else { %>
                      <tr>
                        <td colspan="7">No books found. Please add some.</td>
                      </tr>
                      <% } %>
              </tbody>
            </table>
          </div>

          <%@ include file="../includes/footer.jsp" %>