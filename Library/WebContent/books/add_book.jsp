<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ include file="../includes/header.jsp" %>
    <%@ include file="../includes/sidebar.jsp" %>

      <div class="main-content">
        <div class="header">
          <h1>Add New Book</h1>
          <a href="${pageContext.request.contextPath}/BookServlet" class="btn">Back to List</a>
        </div>

        <div class="card" style="max-width: 600px; margin: 0 auto; text-align: left;">
          <form action="${pageContext.request.contextPath}/BookServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
              <label>Title</label>
              <input type="text" name="title" class="form-control" required>
            </div>

            <div class="form-group">
              <label>Author</label>
              <input type="text" name="author" class="form-control" required>
            </div>

            <div class="form-group">
              <label>Category</label>
              <input type="text" name="category" class="form-control" required>
            </div>

            <div class="form-group">
              <label>Quantity</label>
              <input type="number" name="quantity" class="form-control" min="1" required>
            </div>

            <button type="submit" class="btn">Save Book</button>
          </form>
        </div>
      </div>

      <%@ include file="../includes/footer.jsp" %>