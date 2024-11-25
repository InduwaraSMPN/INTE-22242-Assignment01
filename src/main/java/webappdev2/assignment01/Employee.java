package webappdev2.assignment01;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class Employee {
    private String id;
    private String firstName;
    private String lastName;
    private String employeeId;
    private String department;
    private String email;
    private String phone;
    private String address;
    private String address2;
    private String city;
    private String region;
    private String gender;

    // Constructors
    public Employee() {}

    public Employee(String id, String firstName, String lastName, String employeeId, String department, String email, String phone, String address, String address2, String city, String region, String gender) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.employeeId = employeeId;
        this.department = department;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.address2 = address2;
        this.city = city;
        this.region = region;
        this.gender = gender;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    // Helper method to convert Employee to XML Element
    public Element toXMLElement(Document doc) {
        Element employeeElement = doc.createElement("employee");
        employeeElement.setAttribute("id", this.id);

        addChildElement(doc, employeeElement, "firstName", this.firstName);
        addChildElement(doc, employeeElement, "lastName", this.lastName);
        addChildElement(doc, employeeElement, "employeeId", this.employeeId);
        addChildElement(doc, employeeElement, "department", this.department);
        addChildElement(doc, employeeElement, "email", this.email);
        addChildElement(doc, employeeElement, "phone", this.phone);
        addChildElement(doc, employeeElement, "address", this.address);
        addChildElement(doc, employeeElement, "address2", this.address2);
        addChildElement(doc, employeeElement, "city", this.city);
        addChildElement(doc, employeeElement, "region", this.region);
        addChildElement(doc, employeeElement, "gender", this.gender);

        return employeeElement;
    }

    // Helper method to add child elements to the parent element
    private void addChildElement(Document doc, Element parent, String name, String value) {
        Element elem = doc.createElement(name);
        elem.setTextContent(value);
        parent.appendChild(elem);
    }
}