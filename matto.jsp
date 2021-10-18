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
String ls_B = request.getParameter("B");


//Buscar
String ls_t_buscar = request.getParameter("titulo_buscar");
String ls_a_buscar = request.getParameter("autor_buscar");

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

//Buscar
try{
    if (ls_B.equals("BUSCAR")) {
    ls_query = "select * from libros INNER JOIN editoriales ON libros.id_editorial = editoriales.Id_editorial where titulo LIKE";
    ls_query += "'%" + ls_t_buscar + "%'";
    ls_query += "AND autor LIKE";
    ls_query += "'%" + ls_a_buscar + "%'";
    ls_action ="Vacio";
    }
    }catch(NullPointerException e){
}

try{
    if (ls_action.equals("Crear")) {
        ls_query = " insert into libros (isbn, titulo, autor, id_editorial, anioPublic)";
        ls_query += " values (";
        ls_query += "'" + ls_isbn + "',";
        ls_query += "'" + ls_titulo + "',";
        ls_query += "'" + ls_autor + "',";
        ls_query += "'" + ls_editorial + "',";
        ls_query += "'" + ls_publicacion + "')";
        ls_B="Vacio";
    }
    }catch(NullPointerException e){
        out.println("Error al crear");
}

try{
    if (ls_action.equals("Eliminar")) {
        ls_query = " delete from libros where isbn = ";
        ls_query += "'" + ls_isbn + "'";
        ls_B="Vacio";
    }
    }catch(NullPointerException e){
        out.println("Error al eliminar");
}

try{
    if (ls_action.equals("Actualizar")) {
    ls_query = " update libros";
    ls_query += " set titulo= " + "'" + ls_titulo + "'";
    ls_query += ", autor= " + "'" + ls_autor + "'";
    ls_query += ", id_editorial= " + "'" + ls_editorial + "'";
    ls_query += ", anioPublic= " + "'" + ls_publicacion + "'";
    ls_query += " where isbn = " + "'" + ls_isbn + "'";
    ls_B="Vacio";
}
}catch(NullPointerException e){out.println("Error al actualizar");}

if(ls_action.equals("Vacio")){};
if(ls_B.equals("Vacio")){};

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
                <!--Buscar-->

           <% if(ls_B.equals("BUSCAR")){
                    out.println("Las busqueda se muestra en la siguiente tabla");
                    //Encabezado de la tabla si la opción es BUSCAR                
                    out.println("<table class=table table-striped>");
                    out.println("<thead>");
                    out.println("<tr>");
                    out.println("<th scope=col>"+"#"+"</th>");
                    out.println("<th scope=col>"+"ISBN"+"</td>");
                    out.println("<th scope=col>"+"T&iacute;tulo"+"</td>");
                    out.println("<th scope=col>"+"Autor"+"</td>");
                    out.println("<th scope=col>"+"Editorial"+"</th>");
                    out.println("<th scope=col"+"style=text-align:center;>"+"A&ntilde;o de"+"<br>"+"publicaci&oacute;n"+"</th>");
                    out.println("<th scope=col>"+"Acci&oacute;n"+"</td>");
                    out.println("</tr>");
                    out.println("</thead>");
                    out.println("<tbody>");
            }
                else{
                    out.println("Base de datos actualizada...");
            }
            %>
            <%!

            //Conexion a la base de datos para la consulta de buscar
                public Connection getConnection(String path) throws SQLException {
                String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
                String filePath= path + "\\datos.mdb";
                String userName="",password="";
                String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;
                
                Connection conn = null;
                try{
                    Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                    conn = DriverManager.getConnection(fullConnectionString,userName,password);
                    
                }
                catch (Exception e) {
                    System.out.println("Error: " + e);
                }
                return conn;
                 }
            %>
                <%
                     Connection conexion = getConnection(path);

                //Condicional para llamar a los datos de la consulta
                if (!conexion.isClosed() && ls_B.equals("BUSCAR")){
    
                Statement st = conexion.createStatement();
                ResultSet rs = st.executeQuery(ls_query);    
                int i=1;
                 while (rs.next())
                 {
                String isbn = rs.getString("isbn");
                String titulo = rs.getString("titulo");
                out.println("<tr>");
                    out.println("<td>"+ i +"</td>");
                    out.println("<td>"+isbn+"</td>");
                    out.println("<td>"+titulo+"</td>");
                    out.println("<td>"+rs.getString("autor")+"</td>");
                    out.println("<td>"+rs.getString("nombre")+"</td>");
                    out.println("<td>"+rs.getString("anioPublic")+"</td>");
                    out.println("<td>"+"Actualizar<br><a href='matto.jsp?isbn="+isbn+"&titulo="+titulo+"&Action=Eliminar'>Eliminar</a>"+"</td>");
                    out.println("</tr>");
                    i++;
                }
                out.println("</tbody>");
                out.println("</table>");
                conexion.close();
            }
            else{
                conexion.close();
            }
         %>
        </div>
        <a href="libros.jsp" class="btn btn-light">Ingresar otro valor</a> 
    </div>
</body> 
</html>