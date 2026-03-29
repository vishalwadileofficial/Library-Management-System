<%@ page import="com.library.dao.BookDAO" %>
  <%@ page import="com.library.dao.StudentDAO" %>
    <%@ page import="com.library.model.Book" %>
      <%@ page import="com.library.model.Student" %>
        <%@ page import="java.util.List" %>
          <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ include file="../includes/header.jsp" %>
              <%@ include file="../includes/sidebar.jsp" %>

                <div class="main-content">
                  <div class="header">
                    <h1>Issue Book</h1>
                    <a href="${pageContext.request.contextPath}/IssueServlet" class="btn">Back to List</a>
                  </div>

                  <div class="card" style="max-width: 600px; margin: 0 auto; text-align: left;">
                    <form action="${pageContext.request.contextPath}/IssueServlet" method="post">
                      <input type="hidden" name="action" value="issue">

                      <div class="form-group">
                        <label>Select Book</label>
                        <select name="bookId" class="form-control" required>
                          <option value="">-- Select Book --</option>
                          <% BookDAO bookDAO=new BookDAO(); List<Book> books = bookDAO.getAllBooks();
                            for(Book b : books) {
                            if(b.getAvailable() > 0) {
                            %>
                            <option value="<%= b.getId() %>">
                              <%= b.getTitle() %> (ID: <%= b.getId() %>)
                            </option>
                            <% } } %>
                        </select>
                      </div>

                      <div class="form-group">
                        <label>Select Student</label>
                        <select name="studentId" class="form-control" required>
                          <option value="">-- Select Student --</option>
                          <% StudentDAO studentDAO=new StudentDAO(); List<Student> students =
                            studentDAO.getAllStudents();
                            for(Student s : students) {
                            %>
                            <option value="<%= s.getId() %>">
                              <%= s.getName() %> (ID: <%= s.getId() %>)
                            </option>
                            <% } %>
                        </select>
                      </div>

                      <div class="form-group">
                        <label>Issue Date</label>
                        <input type="date" name="issueDate" class="form-control" required>
                      </div>

                      <div class="form-group">
                        <label>Return Date</label>
                        <input type="date" name="returnDate" class="form-control" required>
                      </div>

                      <button type="submit" class="btn">Issue Book</button>
                    </form>
                  </div>
                </div>

                <script>
                  // Set default dates
                  const dateInput = document.querySelector('input[name="issueDate"]');
                  const returnInput = document.querySelector('input[name="returnDate"]');
                  const today = new Date().toISOString().split('T')[0];
                  dateInput.value = today;

                  // Default return date (7 days later)
                  const nextWeek = new Date();
                  nextWeek.setDate(nextWeek.getDate() + 7);
                  returnInput.value = nextWeek.toISOString().split('T')[0];
                </script>

                <%@ include file="../includes/footer.jsp" %>