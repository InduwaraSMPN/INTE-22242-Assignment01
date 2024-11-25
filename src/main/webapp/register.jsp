<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Employee Registration</title>
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
  <h1 class="form-title">Employee Registration</h1>

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
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
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
          Employee registered successfully.
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" id="viewEmployeesBtn">View Employees</button>
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Registration Form -->
  <form action="RegisterServlet" method="post" id="registrationForm">
    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="firstName">First Name*</label>
          <input type="text" class="form-control" id="firstName" name="firstName" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="lastName">Last Name*</label>
          <input type="text" class="form-control" id="lastName" name="lastName" required>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="employeeId">Employee ID*</label>
          <input type="text" class="form-control" id="employeeId" name="employeeId" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="department">Department*</label>
          <select class="form-control" id="department" name="department" required>
            <option value="">Please select</option>
            <option value="HR">HR Department</option>
            <option value="Operations">Operations Management Department</option>
            <option value="IT">IT Department</option>
            <option value="Marketing">Marketing Department</option>
            <option value="Sales">Sales Department</option>
            <option value="Finance">Accounting and Finance Department</option>
          </select>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="email">Email*</label>
          <input type="email" class="form-control" id="email" name="email" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="phone">Phone*</label>
          <input type="tel" class="form-control" id="phone" name="phone" required>
        </div>
      </div>
    </div>

    <div>
      <label class="form-label">Address</label>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="address" name="address" required>
      <label for="address"><i>Address Line 1*</i></label>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="address2" name="address2">
      <label for="address2"><i>Address Line 2</i></label>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="city">City*</label>
          <input type="text" class="form-control" id="city" name="city" required>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="form-label" for="region">Region*</label>
          <input type="text" class="form-control" id="region" name="region" required>
        </div>
      </div>
    </div>

    <div class="form-group">
      <label class="form-label">Gender*</label>
      <div class="gender-group">
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="male" value="Male" required>
          <label class="form-check-label" for="male">Male</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="female" value="Female" required>
          <label class="form-check-label" for="female">Female</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="gender" id="other" value="Other" required>
          <label class="form-check-label" for="other">Other</label>
        </div>
      </div>
    </div>
    <div>
      <label style="color: #cf403a;font-style: italic;padding-bottom: 15px;text-align: right;">Fields marked with * are required</label>
      <label class="form-label"></label>
    </div>
    <button type="submit" class="button-86 registration">Register Employee</button>
  </form>
</div>

<script>
  $(document).ready(function() {
    // Handle form submission
    $('#registrationForm').submit(function(event) {
      event.preventDefault();
      $.ajax({
        type: 'POST',
        url: 'RegisterServlet',
        data: $(this).serialize(),
        success: function(response) {
          if (response.status === 200) {
            // Clear the form
            $('#registrationForm')[0].reset();
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
          $('#errorMessage').text(xhr.responseJSON.message || "An error occurred.");
          $('#errorModal').modal('show');
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