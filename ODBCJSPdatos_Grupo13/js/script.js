function mensajeChange() {
    console.log("change");
    const mensaje = document.getElementById("mensaje");
    const mensaje2 = document.getElementById("mensaje2");
    const boton = document.getElementById("enviar");
    console.log(boton)
    
    if (mensaje.value.trim() !== "") {
      console.log("Se muestra")
      boton.removeAttribute('disabled')
    
    }
    else if(mensaje2.value.trim() !== ""){
        console.log("Se muestra")
        boton.removeAttribute('disabled')
    } else {
      boton.setAttribute('disabled', "true");
    }
  }