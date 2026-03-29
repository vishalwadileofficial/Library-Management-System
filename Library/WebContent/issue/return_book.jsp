<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ include file="../includes/header.jsp" %>
    <%@ include file="../includes/sidebar.jsp" %>

      <div class="main-content">
        <div class="header">
          <h1>Return Book</h1>
          <a href="${pageContext.request.contextPath}/IssueServlet" class="btn">Back to List</a>
        </div>

        <div class="card" style="max-width: 600px; margin: 0 auto; text-align: left;">
          <form action="${pageContext.request.contextPath}/IssueServlet" method="post">
            <input type="hidden" name="action" value="return">

            <div class="form-group">
              <label>Issue ID</label>
              <input type="number" name="issueId" class="form-control" value="<%= request.getParameter(" issueId") %>"
              readonly>
            </div>

            <div class="form-group">
              <label>Actual Return Date</label>
              <input type="date" name="actualReturnDate" class="form-control" required>
            </div>

            <div class="form-group">
              <label>Fine Amount (if any)</label>
              <input type="number" name="fine" class="form-control" value="0.00" step="0.01">
            </div>

            <button type="submit" class="btn btn-danger">Confirm Return</button>
          </form>
        </div>
      </div>

      <script>
        // Set default date to today
        document.querySelector('input[name="actualReturnDate"]').value = new Date().toISOString().split('T')[0];
      </script>

      <%@ include file="../includes/footer.jsp" %>