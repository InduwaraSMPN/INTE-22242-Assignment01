<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.DocumentBuilder, org.w3c.dom.Document, org.w3c.dom.NodeList, org.w3c.dom.Node, org.w3c.dom.Element, java.io.File" %>
<%@ page import="webappdev2.assignment01.Employee" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Employees</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <!-- FontAwesome CSS -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link href="styles.css" rel="stylesheet">
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Bootstrap JS -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js"></script>

  <!-- Unicons CSS -->
  <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css" />
</head>
<body class="employees-body">
<div class="common-container-styles employees_container">
  <h1 class="form-title">Employees</h1>

  <!-- Search Container -->
  <div class="search-container">
    <div class="input-box">
      <i class="uil uil-search"></i>
      <input type="text" id="searchInput" placeholder="Search here..." />
      <button class="button-86 registration button " id="searchButton" >Search</button>
    </div>
  </div>

  <!-- Sort Container -->
  <div class="sort-container">
    <label for="sortSelect">Sort by:</label>
    <select id="sortSelect" class="form-select">
      <option value="First Name">First Name</option>
      <option value="Last Name">Last Name</option>
      <option value="Employee ID">Employee ID</option>
      <option value="Department">Department</option>
      <option value="Email">Email</option>
      <option value="Phone">Phone</option>
      <option value="Address">Address</option>
      <option value="Address Line 2">Address Line 2</option> <!-- New option -->
      <option value="City">City</option>
      <option value="Region">Region</option>
      <option value="Gender">Gender</option>
    </select>
    <button class="button-86" id="sortButton">Sort</button>
  </div>

  <!-- Employees Table -->
  <table class="table table-bordered" id="employeesTable">
    <thead>
    <tr>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Employee ID</th>
      <th>Department</th>
      <th>Email</th>
      <th>Phone</th>
      <th>Address</th>
      <th>Address Line 2</th> <!-- New column -->
      <th>City</th>
      <th>Region</th>
      <th>Gender</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      try {
        // Get the path to the resources directory
        String resourcesPath = application.getRealPath("/WEB-INF/classes/employees.xml");
        File inputFile = new File(resourcesPath);

        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(inputFile);
        doc.getDocumentElement().normalize();
        NodeList nList = doc.getElementsByTagName("employee");
        for (int temp = 0; temp < nList.getLength(); temp++) {
          Node nNode = nList.item(temp);
          if (nNode.getNodeType() == Node.ELEMENT_NODE) {
            Element eElement = (Element) nNode;
            Employee employee = new Employee(
                    eElement.getAttribute("id"),
                    eElement.getElementsByTagName("firstName").item(0).getTextContent(),
                    eElement.getElementsByTagName("lastName").item(0).getTextContent(),
                    eElement.getElementsByTagName("employeeId").item(0).getTextContent(),
                    eElement.getElementsByTagName("department").item(0).getTextContent(),
                    eElement.getElementsByTagName("email").item(0).getTextContent(),
                    eElement.getElementsByTagName("phone").item(0).getTextContent(),
                    eElement.getElementsByTagName("address").item(0).getTextContent(),
                    eElement.getElementsByTagName("address2").item(0).getTextContent(),
                    eElement.getElementsByTagName("city").item(0).getTextContent(),
                    eElement.getElementsByTagName("region").item(0).getTextContent(),
                    eElement.getElementsByTagName("gender").item(0).getTextContent()
            );
    %>
    <tr>
      <td><%= employee.getFirstName() %></td>
      <td><%= employee.getLastName() %></td>
      <td><%= employee.getEmployeeId() %></td>
      <td><%= employee.getDepartment() %></td>
      <td><%= employee.getEmail() %></td>
      <td><%= employee.getPhone() %></td>
      <td><%= employee.getAddress() %></td>
      <td><%= employee.getAddress2() %></td> <!-- New column -->
      <td><%= employee.getCity() %></td>
      <td><%= employee.getRegion() %></td>
      <td><%= employee.getGender() %></td>
      <td>
        <!-- Edit and Delete buttons -->
        <a href="EditServlet?id=<%= employee.getId() %>" class="btn btn-primary btn-sm"><i class="fa-solid fa-pen-to-square"></i></a>
        <a href="DeleteServlet?id=<%= employee.getId() %>" class="btn btn-danger btn-sm"><i class="fa-solid fa-trash"></i></a>
      </td>
    </tr>
    <%
          }
        }
      } catch (Exception e) {
        e.printStackTrace();
      }
    %>
    </tbody>
  </table>
  <!-- Link to add a new employee -->
  <a href="register.jsp" class="button-86 add-new">Add New Employee</a>
</div>

<script>
  $(document).ready(function() {
    // Handle search button click
    $('#searchButton').on('click', function() {
      var searchQuery = $('#searchInput').val().toLowerCase();
      filterTable(searchQuery);
    });

    // Handle sort button click
    $('#sortButton').on('click', function() {
      var sortBy = $('#sortSelect').val();
      sortTable(sortBy);
    });

    // Function to filter the table based on search query
    function filterTable(query) {
      $('#employeesTable tbody tr').each(function() {
        var row = $(this);
        var rowData = row.text().toLowerCase();
        if (rowData.indexOf(query) === -1) {
          row.hide();
        } else {
          row.show();
        }
      });
    }

    // Function to sort the table based on selected column
    function sortTable(sortBy) {
      var rows = $('#employeesTable tbody tr').get();
      rows.sort(function(a, b) {
        var A = $(a).children('td').eq(getIndex(sortBy)).text().toUpperCase();
        var B = $(b).children('td').eq(getIndex(sortBy)).text().toUpperCase();

        if (A < B) {
          return -1;
        }
        if (A > B) {
          return 1;
        }
        return 0;
      });

      $.each(rows, function(index, row) {
        $('#employeesTable').children('tbody').append(row);
      });
    }

    // Function to get the index of the column based on its header text
    function getIndex(sortBy) {
      var headers = $('#employeesTable th');
      var headerTexts = ['First Name', 'Last Name', 'Employee ID', 'Department', 'Email', 'Phone', 'Address', 'Address Line 2', 'City', 'Region', 'Gender'];
      return headerTexts.indexOf(sortBy);
    }
  });
</script>
</body>
</html>