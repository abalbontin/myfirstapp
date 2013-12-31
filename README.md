<img src="GasAll/Resources/Images/Icons/Icon.png?raw=true" width="36px" heigth="36px" hspace="5"/>GasAll
================

*... Indicar aquí una descripción breve del proyecto.*

###Consideraciones básicas
* Las consideraciones básicas que deben conocerse para cualquier proyecto iOS se encuentran en [IOS-README-BASE](https://github.com/mobivery/mobivery/blob/master/docs/IOS-README-BASE.md)

###Requisitos
*... Modificar los requisitos siguientes para que cumplan con lo reales.*
* iOS 5.0 o posterior.
* Xcode 4.0 o posterior.
* iPhone.
* ARC.

###Variables de entorno
*... Indicar aquí las variables configurables del proyecto y donde están. Si no hay, poner "No aplica".*

###Usuarios/códigos para pruebas
*... Indicar aquí los datos necesarios para que cualquiera pueda probar la aplicación, por ejemplo user y pass. Si no es necesario, poner "No aplica".*

###Servicios
*... Colocar aquí los enlaces a la documentación de servicios entregada por el cliente o hecha por nosotros. Si no hay, poner "No aplica".*

###Cómo realizar una entrega al cliente
*... Indicar los pasos que hay que seguir (¿cambiar alguna variable de entorno, pulsar un botón en Jenkins, ...?), las distintas versiones que hay que generar (si está apuntado a pruebas, producción, etc), qué certifcados hacen faltan y dónde están (deberían estar siempre en el repositorio "certs"), avisar al PO y cualquier otra cosa que haga falta para entregar la aplicación al cliente y que este pueda probar todo, sin necesidad de que haya que preguntar nada a nadie.*

###Cómo se realiza la subida al App Store
*... Modificar las consideraciones siguientes para que cumplan las que requiere el proyecto, para que se pueda hacer la subida al AppStore sin necesidad de preguntar nada a nadie.*
* Asegurarse que está puesto el flag ```-DDISTRIBUTION=1``` en la configuración **Distribution**, para las push de Malcom.
* Asegurarse que la url de los servicios apunta a producción en el fichero de defines: [Defines.h](GasAll/Classes/Defines.h).
* Asegurarse que tenemos el certificado de la cuenta del cliente para push y que está correctamente configurado en el proyecto. Los certificados están en XXXXX.
* Genear un IPA asegurándonos que la opción **Archive** está puesta en **Distribution**.
* Asegurarse que todo está subido a **GitHub** en **Master** y marcar en dicha rama una versión.
