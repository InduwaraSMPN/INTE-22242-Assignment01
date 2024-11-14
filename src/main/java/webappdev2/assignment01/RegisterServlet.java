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
        // Retrieve form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String employeeId = request.getParameter("employeeId");
        String department = request.getParameter("department");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String address2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String region = request.getParameter("region");
        String gender = request.getParameter("gender");

        // Validate input (e.g., email format, required fields)
        if (firstName == null || lastName == null || employeeId == null || department == null || email == null || phone == null || address == null || city == null || region == null || gender == null) {
            response.sendRedirect("register.jsp?error=missingFields");
            return;
        }

        // Save data to XML
        synchronized (this) {
            try {
                // Get the path to the resources directory
                String resourcesPath = getServletContext().getRealPath("/WEB-INF/classes/employees.xml");
                File inputFile = new File(resourcesPath);

                DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
                Document doc = docBuilder.parse(inputFile);

                // Create new employee element
                Element employee = doc.createElement("employee");
                employee.setAttribute("id", UUID.randomUUID().toString()); // Unique identifier

                // Add child elements to the employee element
                Element firstNameElem = doc.createElement("firstName");
                firstNameElem.appendChild(doc.createTextNode(firstName));
                employee.appendChild(firstNameElem);

                Element lastNameElem = doc.createElement("lastName");
                lastNameElem.appendChild(doc.createTextNode(lastName));
                employee.appendChild(lastNameElem);

                Element employeeIdElem = doc.createElement("employeeId");
                employeeIdElem.appendChild(doc.createTextNode(employeeId));
                employee.appendChild(employeeIdElem);

                Element departmentElem = doc.createElement("department");
                departmentElem.appendChild(doc.createTextNode(department));
                employee.appendChild(departmentElem);

                Element emailElem = doc.createElement("email");
                emailElem.appendChild(doc.createTextNode(email));
                employee.appendChild(emailElem);

                Element phoneElem = doc.createElement("phone");
                phoneElem.appendChild(doc.createTextNode(phone));
                employee.appendChild(phoneElem);

                Element addressElem = doc.createElement("address");
                addressElem.appendChild(doc.createTextNode(address));
                employee.appendChild(addressElem);

                Element address2Elem = doc.createElement("address2");
                address2Elem.appendChild(doc.createTextNode(address2));
                employee.appendChild(address2Elem);

                Element cityElem = doc.createElement("city");
                cityElem.appendChild(doc.createTextNode(city));
                employee.appendChild(cityElem);

                Element regionElem = doc.createElement("region");
                regionElem.appendChild(doc.createTextNode(region));
                employee.appendChild(regionElem);

                Element genderElem = doc.createElement("gender");
                genderElem.appendChild(doc.createTextNode(gender));
                employee.appendChild(genderElem);

                // Append new employee to root element
                doc.getDocumentElement().appendChild(employee);

                // Write the content into XML file
                TransformerFactory transformerFactory = TransformerFactory.newInstance();
                Transformer transformer = transformerFactory.newTransformer();
                DOMSource source = new DOMSource(doc);
                StreamResult result = new StreamResult(inputFile);
                transformer.transform(source, result);

                // Redirect to the employees page
                response.sendRedirect("employees.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("register.jsp?error=serverError");
            }
        }
    }
}