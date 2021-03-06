<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
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
<% ServletContext context = request.getServletContext();
   String path = context.getRealPath("/data");
   Connection conexion = getConnection(path);
    if (!conexion.isClosed()){
      Statement st = conexion.createStatement();
      ResultSet ed = null;
      ed = st.executeQuery("select * from editoriales");
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
      <br><br>
      <H1>MANTENIMIENTO DE LIBROS</H1>
      <!-- Formulario que contiene el boton buscar-->
      <div class="bg-light text-dark">
         <form action="matto.jsp" id="form" method="post" name="search">
          
            <div class="container">
               <br>
               <h5>Buscar</h5>
               <input class="form-check-input" type="hidden" name="B" value="BUSCAR" id="btn_buscar" checked>
               <!--input txt para el titulo-->
               <input onkeyup="mensajeChange()" type="text" id="mensaje" name="titulo_buscar" class="form-control" placeholder="Ingrese un titulo" >
               <br>
               <input onkeyup="mensajeChange()" type="text" id="mensaje2" name="autor_buscar" class="form-control" placeholder="Ingrese un Autor">
           </div>
           <br/>
           <div class="container">
               <!--Boton buscar-->
               <input type="SUBMIT" id="enviar" class="btn btn-primary" value="Buscar" disabled>
           </div>
         </form>
      </div>
      <div class="bg-light text-dark">
         <form action="matto.jsp" id="libro_form" method="post" name="Actualizar">
               <div class="container">
                  <br>
                  <h5>Mantenimiento</h5>
               </div>
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
                        <select class="form-select" name="editorial" form="libro_form" aria-label="Editorial">
                           <option selected>Seleccionar Editorial</option>
                           <%while(ed.next()){ 
                                    String nombre = ed.getString("nombre");
                                    String id_editorial = ed.getString("id_editorial");%>
                                    <option value="<%=id_editorial%>"><%=nombre%></option>
                           <%}%>
                        </select>
                     </td>
                  </tr>
                  <tr>    
                     <td><input type="number" min="1000" max="2021" name="anioPublic" value="" class="form-control" placeholder="A&ntilde;o de publicaci&oacute;n" aria-label="A??o"></td>    
                  </tr>
                  <tr>
                     <td> 
                        <h5>Acci&oacute;n</h5>
                        <div class="container">
                        <!--Buscar-->

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
                        <input type="SUBMIT" class="btn btn-primary" value="Aceptar" />
                        <div class="text-white">.</div>
                     </td>
               </tr>
               </table>
         </form>
      </div>
   <br>
   <table class="table table-striped">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col">ISBN</th>
          <th scope="col"><a href="libros.jsp?orden=ascendente" name="linktitulo">T&iacute;tulo</a></th>
          <th scope="col">Autor</th>
          <th scope="col">Editorial</th>
          <th scope="col" style="text-align:center;">A&ntilde;o de <br>publicaci&oacute;n</th>
          <th scope="col">Acci&oacute;n</th>
        </tr>
      </thead>
      <tbody>
<%
   ResultSet rs = null;
   /*Codigo utilizado para el ejercicio 2*/
   if(request.getParameter("orden")!=null)
      rs = st.executeQuery("select * from libros inner join editoriales on libros.id_editorial = editoriales.id_editorial order by titulo asc");
   else
      rs = st.executeQuery("select * from libros inner join editoriales on libros.id_editorial = editoriales.id_editorial");
   
   // Ponemos los resultados en un table de html
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
            out.println("<td>"+"<a href='matto.jsp?isbn=" +isbn+"&titulo="+titulo+ "&Action=Actualizar'>Actualizar</a> <br> <a href='matto.jsp?isbn=" +isbn+"&titulo="+titulo+ "&Action=Eliminar'>Eliminar</a>"+"</td>");
            out.println("</tr>");
            i++;
         }
         out.println("</table>");
         
         // cierre de la conexion
         conexion.close();
      }
      
      %>
      <a  class="btn btn-success" href="listado-csv.jsp" >Descargar listado Excel</a>
            <a  class="btn btn-danger" href="listado-xml.jsp" >Descargar listado XML</a>
      <a  class="btn btn-warning" href="listado-json.jsp" >Descargar listado JSON</a>
      <a  class="btn btn-info" href="listado-html.jsp" >Descargar listado HTML</a>
      <a  class="btn btn-dark" href="listado-txt.jsp" >Descargar listado TXT</a>

   </div>
      <script src="js/bootstrap.min.js"></script>
      <script src="js/script.js"></script>
   </body>