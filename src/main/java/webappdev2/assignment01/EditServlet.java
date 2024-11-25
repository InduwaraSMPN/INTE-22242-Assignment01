package webappdev2.assignment01;

import java.io.File;
import java.io.IOException;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
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
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            // Get the path to the resources directory
            String resourcesPath = getServletContext().getRealPath("/WEB-INF/classes/employees.xml");
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
                    if (eElement.getAttribute("id").equals(id)) {
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
                        request.setAttribute("employee", employee);
                        request.getRequestDispatcher("edit.jsp").forward(request, response);
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("employees.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        String id = request.getParameter("id");
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

        // Create an Employee object
        Employee employee = new Employee(
                id,
                firstName,
                lastName,
                employeeId,
                department,
                email,
                phone,
                address,
                address2,
                city,
                region,
                gender
        );

        synchronized (this) {
            try {
                // Get the path to the resources directory
                String resourcesPath = getServletContext().getRealPath("/WEB-INF/classes/employees.xml");
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
                        if (eElement.getAttribute("id").equals(id)) {
                            // Update the employee details
                            eElement.getElementsByTagName("firstName").item(0).setTextContent(employee.getFirstName());
                            eElement.getElementsByTagName("lastName").item(0).setTextContent(employee.getLastName());
                            eElement.getElementsByTagName("employeeId").item(0).setTextContent(employee.getEmployeeId());
                            eElement.getElementsByTagName("department").item(0).setTextContent(employee.getDepartment());
                            eElement.getElementsByTagName("email").item(0).setTextContent(employee.getEmail());
                            eElement.getElementsByTagName("phone").item(0).setTextContent(employee.getPhone());
                            eElement.getElementsByTagName("address").item(0).setTextContent(employee.getAddress());
                            eElement.getElementsByTagName("address2").item(0).setTextContent(employee.getAddress2());
                            eElement.getElementsByTagName("city").item(0).setTextContent(employee.getCity());
                            eElement.getElementsByTagName("region").item(0).setTextContent(employee.getRegion());
                            eElement.getElementsByTagName("gender").item(0).setTextContent(employee.getGender());

                            // Write the updated document back to the file
                            TransformerFactory transformerFactory = TransformerFactory.newInstance();
                            Transformer transformer = transformerFactory.newTransformer();
                            DOMSource source = new DOMSource(doc);
                            StreamResult result = new StreamResult(inputFile);
                            transformer.transform(source, result);

                            response.setStatus(HttpServletResponse.SC_OK);
                            response.getWriter().write("{\"status\": 200, \"message\": \"Employee updated successfully.\"}");
                            return;
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\": 500, \"message\": \"Server error occurred. Please try again later.\"}");
            }
        }
    }
}