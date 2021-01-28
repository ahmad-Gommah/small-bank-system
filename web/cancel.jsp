<%-- 
    Document   : Cancel
    Created on : Dec 21, 2020, 12:36:36 AM
    Author     : Ahmad Gomma
--%>

<%--
        Name : Ahmad Gomma Farouk Mahmoud
        
        Id : 20170014
   
        Group : S1
   
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import=" static java.time.LocalDateTime.now"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cancel Transaction</title>
    <style>
        td
        {
            text-align:center;
        }
    </style>
</head>
<body>
    <%

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/mydb";
        String user = "root";
        String password = "root";
        Connection Con = null;
        Statement Stmt = null;
        Statement Stmt1 = null;
        Statement Stmt2 = null;
        Statement Stmt3 = null;
        Statement Stmt4 = null;

        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        Stmt1 = Con.createStatement();
        Stmt2 = Con.createStatement();
        Stmt3 = Con.createStatement();
        Stmt4 = Con.createStatement();

        String bank_accountid = request.getSession().getAttribute("bank_account_id").toString();

        String delete_transaction = request.getParameter("delete_transaction");

        float balance;

        Stmt.executeQuery("select *from bankaccount where bank_account_id='"+ bank_accountid + "'");
        ResultSet rs = Stmt.getResultSet();

        Stmt4.executeQuery("select bt_to_account,bta_ammount from banktransaction where bank_transaction_id='" + delete_transaction+ "'");
        ResultSet rs1 = Stmt4.getResultSet();
        if (rs.next()) {
            rs1.next();

            float bta_ammount = rs1.getFloat("bta_ammount");

            String bt_to_account = rs1.getString("bt_to_account");

            balance = rs.getFloat("ba_current_balance")+ Float.valueOf(bta_ammount);

            if (balance >= 0) {
                Stmt.executeUpdate("update bankaccount set ba_current_balance = ba_current_balance +"
                        + "'" + bta_ammount + "'" + " where bank_account_id= "
                        + "'" + bank_accountid + "'");

                Stmt.executeUpdate("update bankaccount set ba_current_balance = ba_current_balance -"
                        + "'" + bta_ammount + "'" + " where bank_account_id= "
                        + "'" + bt_to_account + "'");

                Stmt3.executeUpdate("DELETE from banktransaction where bank_transaction_id=" + delete_transaction + "");

                out.println("<script type=\"text/javascript\">");
                out.println("alert('This Transaction is cancelled successfully');");
                out.println("location='transactions.jsp';");
                out.println("</script>");

            }

        }


    %>


</body>
