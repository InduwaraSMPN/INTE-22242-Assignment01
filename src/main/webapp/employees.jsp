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
</head>
<body class="employees-body">
<div class="common-container-styles employees_container">
  <h1 class="form-title">Employees</h1>

  <!-- Search Form -->
  <form class="form-inline mb-3" id="searchForm">
    <div class="input-group">
      <input type="text" class="form-control" id="searchInput" placeholder="Search by name, department, etc.">
      <div class="input-group-append">
        <button class="btn btn-primary" type="submit">Search</button>
      </div>
    </div>
  </form>

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
    $('#searchForm').on('submit', function(event) {
      event.preventDefault();
      var searchQuery = $('#searchInput').val().toLowerCase();
      filterTable(searchQuery);
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
  });
</script>
</body>
</html>