Library Management System - Setup Guide

1. Prerequisites
   - Java Development Kit (JDK) 8 or higher
   - Eclipse IDE for Enterprise Java and Web Developers
   - Apache Tomcat Server (v8.5 or v9.0 recommended)
   - MySQL Server and MySQL Workbench

2. Database Setup
   - Open MySQL Workbench.
   - Run the script `database.sql` located in the `Library` folder.
     This will create the `library_db` database and necessary tables.
   - The system is configured to use:
     Username: root
     Password: Vishal@789.
   - If your password differs, update `src/com/library/util/DBConnection.java`.

3. Import Project into Eclipse
   - Open Eclipse.
   - Go to File > Open Projects from File System...
   - Click "Directory" and select the `Library` folder from this directory.
   - Click "Finish".

4. Server Configuration
   - In Eclipse, go to the "Servers" tab.
   - Right-click > New > Server.
   - Select Apache Tomcat v9.0 Server (or your installed version) and click Next.
   - Browse to your Tomcat installation directory.
   - Click Finish.

5. Running the Application
   - Right-click the project `LibraryManagementSystem` in Project Explorer.
   - Select Run As > Run on Server.
   - Select your configured Tomcat server and click Finish.
   - The application should open in the internal web browser.

6. Default Login
   - Admin Username: admin
   - Admin Password: admin123
