<%@page import="java.sql.*, java.io.*" pageEncoding="iso-8859-1" %>
<%
response.setStatus(200);
response.setHeader("content-type","application/vnd.ms-excel");
response.setHeader("content-disposition","filename=libros.csv");
%>
<%
try{
    out.println("ISBN;TITULO;AUTOR;EDITORIAL;ANIO PUBLICACION");
    ServletContext context = request.getServletContext();
    String ls_dburl = "jdbc:odbc:registro";
    String ls_usuario = "libros",ls_password = "books";
    String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
    String ls_query = "select * from libros inner join editoriales on libros.id_editorial = editoriales.id_editorial";

    Connection l_dbconn = null;

    Class.forName(ls_dbdriver);
    l_dbconn = DriverManager.getConnection(ls_dburl, ls_usuario, ls_password);

    Statement l_stat = l_dbconn.createStatement();
    ResultSet l_rs = l_stat.executeQuery(ls_query);
    String impresion = "";

    while(l_rs.next()){
        impresion += l_rs.getString("isbn") + ";";
        impresion += l_rs.getString("titulo") + ";";
        impresion += l_rs.getString("autor") + ";";
        impresion += l_rs.getString("nombre")+ ";";
        impresion += l_rs.getString("anioPublic");

        out.println(impresion);
        impresion = ""; 
    }
    l_dbconn.close();
}catch(Exception e){
    e.printStackTrace();
}
%>