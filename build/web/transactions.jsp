<%-- 
    Document   : transaction
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Transaction</title>
    <style>
        body{

            background-color: #FDFBFB;
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
            background-color: #f3f3f3;
        }

        .styled-table tbody tr:last-of-type {
            border-bottom: 2px solid #E5432D;
        }
        input[type=text] {
            padding: 12px 20px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 3px solid #ccc;
            -webkit-transition: 0.5s;
            transition: 0.5s;
            outline: none;
        }

        input[type=text]:focus {
            border: 3px solid #555;
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

        }
        label
        {
            font-size: 25px;
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
        Statement Stmt1 = null;

        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        Stmt1 = Con.createStatement();
        String bank_account_id = "";
        Stmt.executeQuery("select bank_Account_id from bankaccount where customer_customer_id='" +customer_id+ "'");
        ResultSet rs = Stmt.getResultSet();
        if (rs.next()) {
            bank_account_id = rs.getString("bank_account_id");
        }
        Stmt1.executeQuery("select * from banktransaction where bta_from_account ='" + bank_account_id + "'");
        ResultSet Rs1 = Stmt1.getResultSet();

    %>
    <h1 style="text-align:center">Account Transactions</h1>
<center>
    <table class="styled-table">
        <thead>
            <tr>
                <th>Bank Transaction Id</th>
                <th>Creation Date</th> 
                <th>Transaction Amount</th>
                <th>From Account ID</th>
                <th>To Account Id</th>
            </tr>
        </thead>

        <tr>
            <%while (Rs1.next()) {%>
            <td><%=Rs1.getString("bank_transaction_id")%></td>
            <td><%=Rs1.getString("btc_creation_datel")%></td>
            <td><%=Rs1.getString("bta_ammount")%></td>

            <td><%=Rs1.getString("bta_from_account")%></td>

            <td><%=Rs1.getString("bt_to_account")%></td>

        </tr>
        <%}%>
    </table>
    <form action="customerhome.jsp">
        <button type="submit" class="button">Back To Customer Home</button>
    </form>
</center>


<hr>
<h1 style="text-align:center">Make Transaction</h1>
<form action="addtransaction.jsp">
    <center>
        <label>
            Enter account Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </label>
        <input type="text" name="bankaccount_id">
        <label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enter Amount &nbsp;&nbsp;&nbsp;
        </label>
        <input type="text" name="ammount">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="button">Make Transaction</button>
    </center>
</form>
<hr>
<h1 style="text-align:center">Cancel Transaction</h1>
<form action="cancel.jsp" method="post">
    <center>
        <label>
            Enter Transaction Id &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </label>
        <input type="text" name="delete_transaction">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="button">Cancel Transaction</button>
    </center>

</form>

</body>
