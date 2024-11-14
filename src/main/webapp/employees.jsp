<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.DocumentBuilder, org.w3c.dom.Document, org.w3c.dom.NodeList, org.w3c.dom.Node, org.w3c.dom.Element, java.io.File" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Employees</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link href="styles.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js"></script>
  <!-- Unicons CSS -->
  <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css" />
</head>
<body class="employees-body">
<div class="common-container-styles employees_container">
  <h1 class="form-title">Employees</h1>

  <!-- Styled Search Bar -->
  <div class="search-container">
    <div class="input-box">
      <i class="uil uil-search"></i>
      <input type="text" id="searchInput" placeholder="Search here..." />
      <button class="button" id="searchButton">Search</button>
    </div>
  </div>

  <!-- Sorting Options -->
  <div class="sort-container">
    <label for="sortSelect">Sort by:</label>
    <select id="sortSelect" class="form-select">
      <option value="firstName">First Name</option>
      <option value="lastName">Last Name</option>
      <option value="employeeId">Employee ID</option>
      <option value="department">Department</option>
      <option value="email">Email</option>
      <option value="phone">Phone</option>
      <option value="city">City</option>
      <option value="region">Region</option>
      <option value="gender">Gender</option>
    </select>
    <button class="btn btn-secondary" id="sortButton">Sort</button>
  </div>

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
    %>
    <tr>
      <td><%= eElement.getElementsByTagName("firstName").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("lastName").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("employeeId").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("department").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("email").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("phone").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("address").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("city").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("region").item(0).getTextContent() %></td>
      <td><%= eElement.getElementsByTagName("gender").item(0).getTextContent() %></td>
      <td>
        <a href="EditServlet?id=<%= eElement.getAttribute("id") %>" class="btn btn-primary btn-sm"><i class="fa-solid fa-pen-to-square"></i></a>
        <a href="DeleteServlet?id=<%= eElement.getAttribute("id") %>" class="btn btn-danger btn-sm"><i class="fa-solid fa-trash"></i></a>
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
  <a href="register.jsp" class="button-86 add-new">Add New Employee</a>
</div>

<script>
  $(document).ready(function() {
    $('#searchButton').on('click', function() {
      var searchQuery = $('#searchInput').val().toLowerCase();
      filterTable(searchQuery);
    });

    $('#sortButton').on('click', function() {
      var sortBy = $('#sortSelect').val();
      sortTable(sortBy);
    });

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

    function getIndex(sortBy) {
      var headers = $('#employeesTable th');
      for (var i = 0; i < headers.length; i++) {
        if ($(headers[i]).text().toLowerCase() === sortBy) {
          return i;
        }
      }
      return 0;
    }
  });
</script>
</body>
</html>