# Library Management System

A beginner-friendly, clean, and complete Library Management System built with Java Servlet, JSP, and MySQL.

## 🛠 Prerequisites

- **Java Development Kit (JDK 8 or higher)**
- **Eclipse IDE (Enterprise Java Developers edition)**
- **Apache Tomcat Server (v8.5 or v9.0)**
- **MySQL Database**

## 📂 Project Structure

```
LibraryManagementSystem/
├── src/
│   └── com/library/
│       ├── controller/   # Servlets (Login, Book, Student, Issue)
│       ├── dao/          # Data Access Objects (DB Operations)
│       ├── model/        # POJO Classes (Admin, Book, Student, Issue)
│       └── util/         # DB Connection Utility
├── WebContent/
│   ├── assets/           # CSS and JS files
│   ├── books/            # Book management JSPs
│   ├── students/         # Student management JSPs
│   ├── issue/            # Issue/Return JSPs
│   ├── includes/         # Header, Sidebar, Footer JSPs
│   ├── META-INF/
│   └── WEB-INF/
│       ├── lib/          # External JARs (mysql-connector)
│       └── web.xml       # Deployment Descriptor
├── database.sql          # MySQL Database Script
└── README.md             # Project Documentation
```

## 📂 Project Setup Steps

1.  **Database Setup**
    - Open your MySQL Workbench or Command Line.
    - Run the script provided in `database.sql`.
    - This will create the `library_db` database and necessary tables with sample data.

2.  **Import to Eclipse**
    - Open Eclipse.
    - Go to `File > Open Projects from File System...`.
    - Click `Directory` and select the `LibraryManagementSystem` folder.
    - Click `Finish`.
    - Click `Finish`.

    **OR (Manual Method - Recommended if Import fails):**
    1. Create a new **Dynamic Web Project** in Eclipse named `LibrarySystem`.
    2. Go to the file system (outside Eclipse).
    3. Copy the **contents** of `d:/LibraryManagementSystem/src` into your new project's `src` folder.
    4. Copy the **contents** of `d:/LibraryManagementSystem/WebContent` into your new project's `WebContent` (or `src/main/webapp`) folder.
    5. **Do NOT copy** the `bin` folder (it contains compiled system files, Eclipse will regenerate them).

3.  **Configure Database Connection**
    - Open `src/com/library/util/DBConnection.java`.
    - Update the `USERNAME` and `PASSWORD` fields to match your local MySQL credentials.
    - Check the JDBC URL logic (port 3306 is default).

4.  **Add MySQL Connector**
    - Ensure you have the `mysql-connector-java-x.x.x.jar`.
    - Copy it to `WebContent/WEB-INF/lib/` (create the folder if it doesn't exist).
    - Right-click the project > `Build Path > Configure Build Path > Libraries > Add JARs` and select it.

5.  **Run the Application**
    - Right-click on `WebContent/login.jsp` or the project root.
    - Select `Run As > Run on Server`.
    - Choose your Tomcat server and click `Finish`.

## 🔑 Login Credentials

- **Username:** `admin`
- **Password:** `admin123`

## 🚀 Features

- **Admin Dashboard:** View stats of books, students, and fines.
- **Book Management:** Add, View, and Delete books.
- **Student Management:** Manage student records.
- **Issue System:** Issue books to students with date tracking.
- **Return System:** Return books with automatic inventory updates.

## 🤝 Troubleshooting

- **Connection Error:** Check `DBConnection.java` credentials and ensure MySQL is running.
- **404 Error:** Ensure you are running from the `login.jsp` or the root context.
- **Driver Not Found:** Make sure `mysql-connector.jar` is in `WEB-INF/lib`.
