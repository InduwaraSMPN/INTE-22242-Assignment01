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
                        request.setAttribute("employee", eElement);
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
        String id = request.getParameter("id");
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
                            eElement.getElementsByTagName("firstName").item(0).setTextContent(firstName);
                            eElement.getElementsByTagName("lastName").item(0).setTextContent(lastName);
                            eElement.getElementsByTagName("employeeId").item(0).setTextContent(employeeId);
                            eElement.getElementsByTagName("department").item(0).setTextContent(department);
                            eElement.getElementsByTagName("email").item(0).setTextContent(email);
                            eElement.getElementsByTagName("phone").item(0).setTextContent(phone);
                            eElement.getElementsByTagName("address").item(0).setTextContent(address);
                            eElement.getElementsByTagName("address2").item(0).setTextContent(address2);
                            eElement.getElementsByTagName("city").item(0).setTextContent(city);
                            eElement.getElementsByTagName("region").item(0).setTextContent(region);
                            eElement.getElementsByTagName("gender").item(0).setTextContent(gender);

                            TransformerFactory transformerFactory = TransformerFactory.newInstance();
                            Transformer transformer = transformerFactory.newTransformer();
                            DOMSource source = new DOMSource(doc);
                            StreamResult result = new StreamResult(inputFile);
                            transformer.transform(source, result);

                            response.sendRedirect("employees.jsp");
                            return;
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("employees.jsp");
        }
    }
}