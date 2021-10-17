<%@page import="java.sql.*, java.io.*" pageEncoding="iso-8859-1" %>
<%
response.setStatus(200);
response.setHeader("content-type","application/vnd.ms-excel");
response.setHeader("content-disposition","filename=libros.csv");
%>
<%
try{
    out.println("ISBN;TITULO;AUTOR;EDITORIAL;ANIO PUBLICACION");
    String filePath = "c:\\Apache\\Tomcat\\webapps\\JSPdatos_Grupo13\\data\\datos.mdb";
    String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
    String ls_usuario = "",ls_password = "";
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
        impresion += l_rs.getString("nombre");
        out.println(impresion);
        impresion = ""; 
    }
    l_dbconn.close();
}catch(Exception e){
    e.printStackTrace();
}
%>