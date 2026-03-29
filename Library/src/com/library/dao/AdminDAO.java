package com.library.dao;

import com.library.model.Admin;
import com.library.util.DBConnection;
import java.sql.*;

public class AdminDAO {

  public Admin login(String username, String password) {
    Admin admin = null;
    try (Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM admin WHERE username = ? AND password = ?")) {

      ps.setString(1, username);
      ps.setString(2, password);

      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
        admin = new Admin();
        admin.setId(rs.getInt("id"));
        admin.setUsername(rs.getString("username"));
        admin.setPassword(rs.getString("password"));
        admin.setName(rs.getString("name"));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return admin;
  }
}
