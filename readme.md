# Employee Management System 🚀

## Overview 📝

This project is a web-based Employee Management System developed as part of the INTE 22242 course. The system allows users to register new employees, view existing employee records, edit employee details, and delete employee records. The application is built using Java Servlets, JSP, and XML for data storage.

## Features ✨

- **Employee Registration**: Users can register new employees by filling out a form with details such as first name, last name, employee ID, department, email, phone, address, city, region, and gender.
- **View Employees**: Users can view a list of all registered employees with options to search and sort the list.
- **Edit Employee Details**: Users can edit the details of existing employees.
- **Delete Employee Records**: Users can delete employee records from the system.

## Technologies Used 🛠️

- **Java Servlets**: For handling HTTP requests and responses.
- **JSP (JavaServer Pages)**: For generating dynamic web content.
- **XML**: For storing employee data.
- **Maven**: For project management and dependency resolution.
- **Bootstrap**: For responsive and mobile-first front-end design.
- **jQuery**: For client-side scripting and AJAX requests.

## Project Structure 🏗️

The project is structured as follows:

- **src/main/java/webappdev2/assignment01**: Contains the Java Servlets (`DeleteServlet.java`, `EditServlet.java`, `RegisterServlet.java`).
- **src/main/webapp**: Contains the JSP files (`index.jsp`, `register.jsp`, `employees.jsp`, `edit.jsp`) and the `web.xml` configuration file.
- **src/main/resources**: Contains the `employees.xml` file for storing employee data.
- **.mvn**: Contains Maven wrapper files.
- **.idea**: Contains IntelliJ IDEA project configuration files.
- **target**: Contains compiled classes and built artifacts (ignored by `.gitignore`).

## Setup and Installation 📦

### Prerequisites

- Java Development Kit (JDK) 23
- Apache Maven
- An IDE (e.g., IntelliJ IDEA, Eclipse)
- A web server (e.g., Apache Tomcat)

### Steps to Run the Project

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/InduwaraSMPN/INTE-22242-Assignment01.git
   cd INTE-22242-Assignment01
   ```

2. **Build the Project**:
   ```bash
   mvn clean install
   ```

3. **Deploy the Project**:
   - Copy the generated WAR file from the `target` directory to the `webapps` directory of your Tomcat server.
   - Start the Tomcat server.

4. **Access the Application**:
   - Open a web browser and navigate to `http://localhost:8080/Assignment01`.

## Usage 🖥️

### Homepage 🏠

- **Employee Registration**: Click on the "Employee Registration" button to register a new employee.
- **View Employees**: Click on the "View Employees" button to view the list of registered employees.

### Employee Registration 📝

- Fill out the form with the required employee details and click "Register Employee".
- Upon successful registration, a success message will be displayed.

### View Employees 👥

- The list of employees is displayed in a table with options to edit and delete each record.
- Use the search bar to filter the list by any field.
- Use the sort dropdown to sort the list by any field.

### Edit Employee ✏️

- Click the edit button (pencil icon) next to an employee record to edit their details.
- Update the required fields and click "Update Employee".
- Upon successful update, a success message will be displayed.

### Delete Employee 🗑️

- Click the delete button (trash icon) next to an employee record to delete it.
- The employee record will be removed from the list.

## Contributing 🤝

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or feature requests.

## Acknowledgements 🙏

- This project was developed as part of the INTE 22242 course.
- Special thanks to the instructors and peers for their support and feedback.
