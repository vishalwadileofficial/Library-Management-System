<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ include file="../includes/header.jsp" %>
    <%@ include file="../includes/sidebar.jsp" %>

      <div class="main-content">
        <div class="header">
          <h1>Add New Student</h1>
          <a href="${pageContext.request.contextPath}/StudentServlet" class="btn">Back to List</a>
        </div>

        <div class="card" style="max-width: 600px; margin: 0 auto; text-align: left;">
          <form action="${pageContext.request.contextPath}/StudentServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
              <label>Name</label>
              <input type="text" name="name" class="form-control" required>
            </div>

            <div class="form-group">
              <label>Email</label>
              <input type="email" name="email" class="form-control" required>
            </div>

            <div class="form-group">
              <label>Branch</label>
              <select name="branch" class="form-control" required>
                <option value="">Select Branch</option>
                <option value="CS">Computer Science</option>
                <option value="IT">Information Technology</option>
                <option value="ECE">Electronics</option>
                <option value="ME">Mechanical</option>
                <option value="CE">Civil</option>
              </select>
            </div>

            <div class="form-group">
              <label>Year</label>
              <select name="year" class="form-control" required>
                <option value="1">1st Year</option>
                <option value="2">2nd Year</option>
                <option value="3">3rd Year</option>
                <option value="4">4th Year</option>
              </select>
            </div>

            <button type="submit" class="btn">Save Student</button>
          </form>
        </div>
      </div>

      <%@ include file="../includes/footer.jsp" %>