package com.library.controller;

import com.library.dao.BookDAO;
import com.library.model.Book;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;
  private BookDAO bookDAO;

  public void init() {
    bookDAO = new BookDAO();
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
      addBook(request, response);
    } else if ("update".equals(action)) {
      // Implement update if needed
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
      listBooks(request, response);
    } else if ("delete".equals(action)) {
      deleteBook(request, response);
    } else {
      listBooks(request, response);
    }
  }

  private void listBooks(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    List<Book> listBooks = bookDAO.getAllBooks();
    request.setAttribute("listBooks", listBooks);
    request.getRequestDispatcher("books/view_books.jsp").forward(request, response);
  }

  private void addBook(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String category = request.getParameter("category");
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    Book newBook = new Book(0, title, author, category, quantity, quantity);
    bookDAO.addBook(newBook);
    response.sendRedirect("BookServlet");
  }

  private void deleteBook(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    bookDAO.deleteBook(id);
    response.sendRedirect("BookServlet");
  }
}
