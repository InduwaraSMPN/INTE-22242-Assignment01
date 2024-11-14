<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.w3c.dom.Element" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Employee</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link href="styles.css" rel="stylesheet">
  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Bootstrap JS -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.min.js"></script>
</head>
<body class="common-body-styles">
<div class="common-container-styles container">
  <h1 class="form-title">Edit Employee</h1>
  <%
    Element employee = (Element) request.getAttribute("employee");
  %>

  <!-- Error Modal -->
  <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="errorModalLabel">Error</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="errorMessage">
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Success Modal -->
  <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="successModalLabel">Success</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="successMessage">
          Employee updated successfully.
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="viewEmployeesBtn">View Employees</button>
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Edit Form -->
  <form action="EditServlet" method="post" id="editForm">
    <input type="hidden" name="id" value="<%= employee.getAttribute("id") %>">

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="firstName">First Name</label>
          <input type="text" class="form-control" id="firstName" name="firstName"
                 value="<%= employee.getElementsByTagName("firstName").item(0).getTextContent() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="lastName">Last Name</label>
          <input type="text" class="form-control" id="lastName" name="lastName"
                 value="<%= employee.getElementsByTagName("lastName").item(0).getTextContent() %>" required>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="employeeId">Employee ID</label>
          <input type="text" class="form-control" id="employeeId" name="employeeId"
                 value="<%= employee.getElementsByTagName("employeeId").item(0).getTextContent() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="department">Department</label>
          <select class="form-control" id="department" name="department" required>
            <option value="HR" <%= employee.getElementsByTagName("department").item(0).getTextContent().equals("HR") ? "selected" : "" %>>HR Department</option>
            <option value="Operations" <%= employee.getElementsByTagName("department").item(0).getTextContent().equals("Operations") ? "selected" : "" %>>Operations Management Department</option>
            <option value="IT" <%= employee.getElementsByTagName("department").item(0).getTextContent().equals("IT") ? "selected" : "" %>>IT Department</option>
            <option value="Marketing" <%= employee.getElementsByTagName("department").item(0).getTextContent().equals("Marketing") ? "selected" : "" %>>Marketing Department</option>
            <option value="Sales" <%= employee.getElementsByTagName("department").item(0).getTextContent().equals("Sales") ? "selected" : "" %>>Sales Department</option>
            <option value="Finance" <%= employee.getElementsByTagName("department").item(0).getTextContent().equals("Finance") ? "selected" : "" %>>Accounting and Finance Department</option>
          </select>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="email">Email</label>
          <input type="email" class="form-control" id="email" name="email"
                 value="<%= employee.getElementsByTagName("email").item(0).getTextContent() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="phone">Phone</label>
          <input type="tel" class="form-control" id="phone" name="phone"
                 value="<%= employee.getElementsByTagName("phone").item(0).getTextContent() %>" required>
        </div>
      </div>
    </div>

    <div class="form-group">
      <label class="form-label" for="address">Address</label>
      <input type="text" class="form-control" id="address" name="address"
             value="<%= employee.getElementsByTagName("address").item(0).getTextContent() %>" required>
    </div>

    <div class="form-group">
      <label class="form-label" for="address2">Street Address Line 2</label>
      <input type="text" class="form-control" id="address2" name="address2"
             value="<%= employee.getElementsByTagName("address2").item(0).getTextContent() %>">
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="city">City</label>
          <input type="text" class="form-control" id="city" name="city"
                 value="<%= employee.getElementsByTagName("city").item(0).getTextContent() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="region">Region</label>
          <input type="text" class="form-control" id="region" name="region"
                 value="<%= employee.getElementsByTagName("region").item(0).getTextContent() %>" required>
        </div>
      </div>
    </div>

    <div class="form-group">
      <label class="form-label">Gender</label>
      <div class="gender-group">
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="male" value="Male"
            <%= employee.getElementsByTagName("gender").item(0).getTextContent().equals("Male") ? "checked" : "" %> required>
          <label class="form-check-label" for="male">Male</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="female" value="Female"
            <%= employee.getElementsByTagName("gender").item(0).getTextContent().equals("Female") ? "checked" : "" %> required>
          <label class="form-check-label" for="female">Female</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="other" value="Other"
            <%= employee.getElementsByTagName("gender").item(0).getTextContent().equals("Other") ? "checked" : "" %> required>
          <label class="form-check-label" for="other">Other</label>
        </div>
      </div>
    </div>

    <button type="submit" class="btn btn-primary">Update Employee</button>
  </form>
</div>

<script>
  $(document).ready(function() {
    // Handle form submission
    $('#editForm').submit(function(event) {
      event.preventDefault();
      $.ajax({
        type: 'POST',
        url: 'EditServlet',
        data: $(this).serialize(),
        success: function(response) {
          if (response.status === 200) {
            // Display success message
            $('#successMessage').text(response.message);
            $('#successModal').modal('show');
          } else {
            // Display the error message in the modal
            $('#errorMessage').text(response.message);
            $('#errorModal').modal('show');
          }
        },
        error: function(xhr, status, error) {
          // Handle network errors or other issues
          var response = xhr.responseJSON;
          if (response && response.message) {
            $('#errorMessage').text(response.message);
            $('#errorModal').modal('show');
          } else {
            $('#errorMessage').text("An error occurred.");
            $('#errorModal').modal('show');
          }
        }
      });
    });

    // Redirect to employees page when "View Employees" button is clicked
    $('#viewEmployeesBtn').click(function() {
      window.open('employees.jsp', '_blank');
    });
  });
</script>
</body>
</html>