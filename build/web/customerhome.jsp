<%-- 
    Document   : customerhome
    Created on : Dec 21, 2020, 12:36:36 AM
    Author     : Ahmad Gomma
--%>
<%--
        Name : Ahmad Gomma Farouk Mahmoud
        
        Id : 20170014
   
        Group : S1
   
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Customer Home Page</title>
    <style>
        body{

            background-color: #F3ECEA;
        }
        .styled-table {
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            font-family: sans-serif;
            min-width: 400px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            text-align: center;
        }
        .styled-table thead tr {
            background-color: #E5432D;
            color: #ffffff;
            text-align: center;
        }
        .styled-table th,
        .styled-table td {
            padding: 12px 15px;
            font-size: 30px;
        }
        .styled-table tbody tr {
            border-bottom: 1px solid #E5432D;
        }

        .styled-table tbody tr:nth-of-type(even) {
            background-color: #E5432D;
        }

        .styled-table tbody tr:last-of-type {
            border-bottom: 2px solid #E5432D;
        }
        .button {
            background-color: #E5432D; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }
        h1
        {
            color:#E5432D;  
            font-size: 40px;
            font-weight: bold;
            font-style: italic;
            margin-top: 100px;

        }
    </style>
</head>
<body>

    <%

        String customer_id = request.getSession().getAttribute("customer_id").toString();

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/mydb";
        String user = "root";
        String password = "root";
        Connection Con = null;
        Statement Stmt = null;

        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();

        Stmt.executeQuery("select* from bankaccount where customer_customer_id='" + customer_id + "'");

        ResultSet rs = Stmt.getResultSet();

        if (!rs.next()) {
            // no rows in the database in bank account
    %>
    <form action="addaccount">
        <br><br><br><br><br><br><br><br>
        <center>
        <button type="submit" class="button">Add Account</button>
        </center>
    </form>

    <%
    } else {

        HttpSession session1;
        session1 = request.getSession(true);
        String bank_account_id = rs.getString("bank_account_id");
        session1.setAttribute("bank_account_id", bank_account_id);


    %>

    <h1 style="text-align:center;">Account System </h1>
<center>
    <table border="1" class="styled-table">
        <thead>
            <tr>
                <th>Account Balance</th>
                <th>Bank Account Number</th> 

            </tr>
        </thead>
        <tbody>
            <tr>

                <td><%=rs.getString("ba_current_balance")%></td>
                <td><%=rs.getString("bankaccount_number")%></td>
            </tr>
        </tbody>
        <%}%>
    </table>
</center>
<br><br>
<form action="transactions.jsp">
    <center>
        <button type="submit" class="button">View Transaction</button>
    </center>

</form>
<br><br>



</body>
