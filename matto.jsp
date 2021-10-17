<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>

<%
/* Paso 1) Obtener los datos del formulario */
String ls_isbn = request.getParameter("isbn");
String ls_titulo = request.getParameter("titulo");
String ls_autor = request.getParameter("autor");
String ls_editorial = request.getParameter("editorial");
String ls_publicacion = request.getParameter("anioPublic");
String ls_action = request.getParameter("Action");

/* Paso 2) Inicializar variables */
String ls_result = "Base de datos actualizada...";
String ls_query = "";
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
String filePath= path+"\\datos.mdb";
String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
String ls_usuario = "";
String ls_password = "";
String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";

/* Paso 3) Crear query&nbsp; */
if (ls_action.equals("Crear")) {
    ls_query = " insert into libros (isbn, titulo, autor, id_editorial, anioPublic)";
    ls_query += " values (";
    ls_query += "'" + ls_isbn + "',";
    ls_query += "'" + ls_titulo + "',";
    ls_query += "'" + ls_autor + "',";
    ls_query += "'" + ls_editorial + "',";
    ls_query += "'" + ls_publicacion + "')";
}

if (ls_action.equals("Eliminar")) {
    ls_query = " delete from libros where isbn = ";
    ls_query += "'" + ls_isbn + "'";
}

if (ls_action.equals("Actualizar")) {
    ls_query = " update libros";
    ls_query += " set titulo= " + "'" + ls_titulo + "'";
    ls_query += ", autor= " + "'" + ls_autor + "'";
    ls_query += ", id_editorial= " + "'" + ls_editorial + "'";
    ls_query += ", anioPublic= " + "'" + ls_publicacion + "'";
    ls_query += " where isbn = " + "'" + ls_isbn + "'";
}

/* Paso4) Conexi�n a la base de datos */
Connection l_dbconn = null;

try {
    Class.forName(ls_dbdriver);
    /*&nbsp; getConnection(URL,User,Pw) */
    l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
    
    /*Creaci�n de SQL Statement */
    Statement l_statement = l_dbconn.createStatement();
    /* Ejecuci�n de SQL Statement */
    l_statement.execute(ls_query);
} catch (ClassNotFoundException e) {
    ls_result = " Error creando el driver!";
    ls_result += " <br/>" + e.toString();
} catch (SQLException e) {
    ls_result = " Error procesando el SQL!";
    ls_result += " <br/>" + e.toString();
} finally {
    /* Cerramos */
    try {
        if (l_dbconn != null) {
            l_dbconn.close();
        }
    } catch (SQLException e) {
        ls_result = "Error al cerrar la conexi�n.";
        ls_result += " <br/>" + e.toString();
    }
}
%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= , initial-scale=1.0">
        <title>Actualizar, Eliminar, Crear registros</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    </head>
<body>
    
    <div class="container">
        <br/><br/>
        <h4>La siguiente instrucci&oacute;n fue ejecutada: </h4>
        <div class="alert alert-warning" role="alert">
            <%=ls_query%>
          </div>
        
        <h4>El resultado fue:</h4>
        <div class="alert alert-info" role="alert">
            <%=ls_result%>
        </div>
        
        <a href="libros.jsp" class="btn btn-light">Ingresar otro valor</a> 
    </div>
</body>
</html>