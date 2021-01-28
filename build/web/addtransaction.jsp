<%-- 
    Document   : addtransaction
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
    <title>Transaction</title>
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
        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        Stmt1 = Con.createStatement();
        String bank_account_id = request.getParameter("bankaccount_id");

        String bank_accountid = request.getSession().getAttribute("bank_account_id").toString();

        float ammount = Float.valueOf(request.getParameter("ammount"));

        float balance;

        Stmt.executeQuery("select *from bankaccount where bank_account_id='" + bank_accountid + "'");
        ResultSet rs = Stmt.getResultSet();

        if (rs.next()) {

            balance = rs.getFloat("ba_current_balance") - Float.valueOf(ammount);

            if (balance >= 0) {
                Stmt.executeUpdate("update bankaccount set ba_current_balance = ba_current_balance -"
                        + "'" + ammount + "'" + " where bank_account_id= "
                        + "'" + bank_accountid + "'");

                Stmt.executeUpdate("update bankaccount set ba_current_balance = ba_current_balance +"
                        + "'" + ammount + "'" + " where bank_account_id= "
                        + "'" + bank_account_id + "'");

                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                String date = dtf.format(now());
                int Rows = Stmt.executeUpdate("insert into banktransaction(btc_creation_datel,bta_ammount,bta_from_account,bt_to_account,bank_account_id) VALUES("
                        + "'" + date + "',"
                        + "'" + ammount + "',"
                        + "'" + bank_accountid + "',"
                        + "'" + bank_account_id + "',"
                        + "'" + bank_accountid + "')");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('This Transaction is Make successfully');");
                out.println("location='transactions.jsp';");
                out.println("</script>");
            }

        }
    %>

</body>
