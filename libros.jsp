<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
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
      <br><br>
      <H1>MANTENIMIENTO DE LIBROS</H1>
      <form action="matto.jsp" method="post" name="Actualizar">
            <table class="table">
               <tr>
                  <td><input type="text" name="isbn" value="" class="form-control" placeholder="ISBN" aria-label="ISBN"></td>
               </tr>
               <tr>    
                  <td><input type="text" name="titulo" value="" class="form-control" placeholder="T&iacute;tulo" aria-label="T&iacutetulo"></td>    
               </tr>
               <tr>    
                  <td><input type="text" name="autor" value="" class="form-control" placeholder="Autor" aria-label="Autor"></td>    
               </tr>
               <tr>
                  <td> 
                     <h5>Acci&oacute;n</h5>
                     <div class="container">
                        <div class="form-check">
                           <input class="form-check-input" type="radio" name="Action" value="Actualizar" id="flexRadioDefault1">
                           <label class="form-check-label" for="flexRadioDefault1">
                           Actualizar
                           </label>
                        </div>
                        <div class="form-check">
                           <input class="form-check-input" type="radio" name="Action" value="Eliminar" id="flexRadioDefault1">
                           <label class="form-check-label" for="flexRadioDefault1">
                           Eliminar
                           </label>
                        </div>
                        <div class="form-check">
                           <input class="form-check-input" type="radio" name="Action" value="Crear" id="flexRadioDefault2" checked>
                           <label class="form-check-label" for="flexRadioDefault2">
                              Crear
                           </label>
                        </div>
                     </div>
                     <br>
                     <input type="SUBMIT" class="btn btn-primary" value="ACEPTAR" />
                     <div class="text-white">.</div>
                  </td>

               
            </tr>
 
            </table>
      </form>

   <br>
<%!
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
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
if (!conexion.isClosed()){
   
   Statement st = conexion.createStatement();
   ResultSet rs = st.executeQuery("select * from libros" );
   
   // Ponemos los resultados en un table de html
  
   out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Autor</td><td>Acci&oacuten</td></tr>");
      int i=1;
      while (rs.next())
      {
         String isbn = rs.getString("isbn");
         String titulo = rs.getString("titulo");
         out.println("<tr>");
            out.println("<td>"+ i +"</td>");
<<<<<<< HEAD
            out.println("<td>"+isbn+"</td>");
            out.println("<td>"+titulo+"</td>");
            out.println("<td>"+"Actualizar<br><a href='matto.jsp?isbn="+isbn+"&titulo="+titulo+"&Action=Eliminar'>Eliminar</a>"+"</td>");
=======
            out.println("<td>"+rs.getString("isbn")+"</td>");
            out.println("<td>"+rs.getString("titulo")+"</td>");
            out.println("<td>"+rs.getString("autor")+"</td>");
            out.println("<td>"+"Actualizar<br>Eliminar"+"</td>");
>>>>>>> 71bf806ed2bfddc60141870be3fdc6f9b993bccb
            out.println("</tr>");
            i++;
         }
         out.println("</table>");
         
         // cierre de la conexion
         conexion.close();
      }
      
      %>
<<<<<<< HEAD

      <a href="listado-csv.jsp" download="libros.csv">Descargar listado</a>
=======
   </div>
      <script src="js/bootstrap.min.js"></script>
>>>>>>> 71bf806ed2bfddc60141870be3fdc6f9b993bccb
   </body>