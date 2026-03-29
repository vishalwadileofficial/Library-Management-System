<%@ page import="java.util.List" %>
  <%@ page import="com.library.model.IssueRecord" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
      <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/sidebar.jsp" %>

          <div class="main-content">
            <div class="header">
              <h1>Issued Books</h1>
              <a href="issue/issue_book.jsp" class="btn">Issue New Book</a>
            </div>

            <% String errorMessage=(String) request.getAttribute("errorMessage"); if (errorMessage !=null) { %>
              <div class="alert alert-error">
                <%= errorMessage %>
              </div>
              <% } %>

                <table>
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Book</th>
                      <th>Student</th>
                      <th>Issue Date</th>
                      <th>Return Date</th>
                      <th>Status</th>
                      <th>Fine</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% List<IssueRecord> listIssues = (List<IssueRecord>) request.getAttribute("listIssues");
                        if (listIssues != null) {
                        for (IssueRecord issue : listIssues) {
                        %>
                        <tr>
                          <td>
                            <%= issue.getId() %>
                          </td>
                          <td>
                            <%= issue.getBookTitle() %> (ID: <%= issue.getBookId() %>)
                          </td>
                          <td>
                            <%= issue.getStudentName() %> (ID: <%= issue.getStudentId() %>)
                          </td>
                          <td>
                            <%= issue.getIssueDate() %>
                          </td>
                          <td>
                            <%= issue.getReturnDate() %>
                          </td>
                          <td>
                            <% if("ISSUED".equals(issue.getStatus())) { %>
                              <span class="text-danger">Issued</span>
                              <% } else { %>
                                <span class="text-success">Returned</span>
                                <% } %>
                          </td>
                          <td>
                            <%= issue.getFine() %>
                          </td>
                          <td>
                            <% if("ISSUED".equals(issue.getStatus())) { %>
                              <a href="issue/return_book.jsp?issueId=<%= issue.getId() %>" class="btn btn-danger"
                                style="padding: 5px 10px; font-size: 0.8rem;">Return</a>
                              <% } else { %>
                                -
                                <% } %>
                          </td>
                        </tr>
                        <% } } else { %>
                          <tr>
                            <td colspan="8">No records found.</td>
                          </tr>
                          <% } %>
                  </tbody>
                </table>
          </div>

          <%@ include file="../includes/footer.jsp" %>