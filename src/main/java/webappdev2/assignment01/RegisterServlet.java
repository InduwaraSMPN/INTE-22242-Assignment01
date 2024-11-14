package webappdev2.assignment01;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        // Retrieve form data
        String firstName = request.getParameter("firstName").trim();
        String lastName = request.getParameter("lastName").trim();
        String employeeId = request.getParameter("employeeId").trim();
        String department = request.getParameter("department").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();
        String address2 = request.getParameter("address2") != null ? request.getParameter("address2").trim() : "";
        String city = request.getParameter("city").trim();
        String region = request.getParameter("region").trim();
        String gender = request.getParameter("gender").trim();

        // Validate all fields are filled
        if (firstName.isEmpty() || lastName.isEmpty() || employeeId.isEmpty()
                || department.isEmpty() || email.isEmpty() || phone.isEmpty()
                || address.isEmpty() || city.isEmpty() || region.isEmpty()
                || gender.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\": 400, \"message\": \"All fields are required.\"}");
            return;
        }

        // Validate name format
        String namePattern = "^[A-Za-zÀ-ÖØ-öø-ÿ'\\-\\s]+$";
        if (!firstName.matches(namePattern)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\": 400, \"message\": \"Invalid first name format.\"}");
            return;
        }
        if (!lastName.matches(namePattern)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\": 400, \"message\": \"Invalid last name format.\"}");
            return;
        }

        // Validate email format
        String emailPattern = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        if (!email.matches(emailPattern)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\": 400, \"message\": \"Invalid email format.\"}");
            return;
        }

        // Validate phone number format
        String phonePattern = "^\\+?[0-9]{1,3}[-.\s]?(\\([0-9]{1,4}\\)|[0-9]{1,4})[-.\s]?[0-9]{1,4}[-.\s]?[0-9]{1,4}[-.\s]?[0-9]{1,9}$";
        if (!phone.matches(phonePattern)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\": 400, \"message\": \"Invalid phone number format.\"}");
            return;
        }

        // Synchronized block to ensure thread safety
        synchronized (this) {
            try {
                // Get the path to the resources directory
                String resourcesPath = getServletContext().getRealPath("/WEB-INF/classes/employees.xml");
                File inputFile = new File(resourcesPath);

                DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
                Document doc = docBuilder.parse(inputFile);

                // Create a new employee element
                Element employee = doc.createElement("employee");
                employee.setAttribute("id", UUID.randomUUID().toString()); // Generate a unique ID

                // Add child elements to the employee element
                addChildElement(doc, employee, "firstName", firstName);
                addChildElement(doc, employee, "lastName", lastName);
                addChildElement(doc, employee, "employeeId", employeeId);
                addChildElement(doc, employee, "department", department);
                addChildElement(doc, employee, "email", email);
                addChildElement(doc, employee, "phone", phone);
                addChildElement(doc, employee, "address", address);
                if (!address2.isEmpty()) addChildElement(doc, employee, "address2", address2);
                addChildElement(doc, employee, "city", city);
                addChildElement(doc, employee, "region", region);
                addChildElement(doc, employee, "gender", gender);

                // Append the new employee element to the document
                doc.getDocumentElement().appendChild(employee);

                // Write the updated document back to the file
                TransformerFactory transformerFactory = TransformerFactory.newInstance();
                Transformer transformer = transformerFactory.newTransformer();
                DOMSource source = new DOMSource(doc);
                StreamResult result = new StreamResult(inputFile);
                transformer.transform(source, result);

                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"status\": 200, \"message\": \"Employee registered successfully.\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\": 500, \"message\": \"Server error occurred. Please try again later.\"}");
            }
        }
    }

    // Helper method to add child elements to the parent element
    private void addChildElement(Document doc, Element parent, String name, String value) {
        Element elem = doc.createElement(name);
        elem.setTextContent(value);
        parent.appendChild(elem);
    }
}