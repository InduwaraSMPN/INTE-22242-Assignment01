<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="webappdev2.assignment01.Employee" %>
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
    Employee employee = (Employee) request.getAttribute("employee");
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
    <input type="hidden" name="id" value="<%= employee.getId() %>">

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="firstName">First Name*</label>
          <input type="text" class="form-control" id="firstName" name="firstName"
                 value="<%= employee.getFirstName() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="lastName">Last Name*</label>
          <input type="text" class="form-control" id="lastName" name="lastName"
                 value="<%= employee.getLastName() %>" required>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="employeeId">Employee ID*</label>
          <input type="text" class="form-control" id="employeeId" name="employeeId"
                 value="<%= employee.getEmployeeId() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="department">Department*</label>
          <select class="form-control" id="department" name="department" required>
            <option value="HR" <%= employee.getDepartment().equals("HR") ? "selected" : "" %>>HR Department</option>
            <option value="Operations" <%= employee.getDepartment().equals("Operations") ? "selected" : "" %>>Operations Management Department</option>
            <option value="IT" <%= employee.getDepartment().equals("IT") ? "selected" : "" %>>IT Department</option>
            <option value="Marketing" <%= employee.getDepartment().equals("Marketing") ? "selected" : "" %>>Marketing Department</option>
            <option value="Sales" <%= employee.getDepartment().equals("Sales") ? "selected" : "" %>>Sales Department</option>
            <option value="Finance" <%= employee.getDepartment().equals("Finance") ? "selected" : "" %>>Accounting and Finance Department</option>
          </select>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="email">Email*</label>
          <input type="email" class="form-control" id="email" name="email"
                 value="<%= employee.getEmail() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="phone">Phone*</label>
          <input type="tel" class="form-control" id="phone" name="phone"
                 value="<%= employee.getPhone() %>" required>
        </div>
      </div>
    </div>

    <div>
      <label class="form-label">Address</label>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="address" name="address"
             value="<%= employee.getAddress() %>" required>
      <label for="address"><i>Address Line 1*</i></label>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="address2" name="address2"
             value="<%= employee.getAddress2() %>">
      <label for="address2"><i>Address Line 2</i></label>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="city">City*</label>
          <input type="text" class="form-control" id="city" name="city"
                 value="<%= employee.getCity() %>" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="region">Region*</label>
          <input type="text" class="form-control" id="region" name="region"
                 value="<%= employee.getRegion() %>" required>
        </div>
      </div>
    </div>

    <div class="form-group">
      <label class="form-label">Gender*</label>
      <div class="gender-group">
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="male" value="Male"
            <%= employee.getGender().equals("Male") ? "checked" : "" %> required>
          <label class="form-check-label" for="male">Male</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="female" value="Female"
            <%= employee.getGender().equals("Female") ? "checked" : "" %> required>
          <label class="form-check-label" for="female">Female</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="other" value="Other"
            <%= employee.getGender().equals("Other") ? "checked" : "" %> required>
          <label class="form-check-label" for="other">Other</label>
        </div>
      </div>
    </div>
    <div>
      <label style="color: #cf403a;font-style: italic;padding-bottom: 15px;text-align: right;">Fields marked with * are required</label>
      <label class="form-label"></label>
    </div>
    <button type="submit" class="button-86 registration">Update Employee</button>
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