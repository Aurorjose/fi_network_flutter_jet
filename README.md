# Prueba técnica FiNetwork - Flutter - Jose Esteve

Prueba realizada con la versión de Flutter `3.10.5`.

# Explicación de los directorios

En este caso, tenemos los siguientes directorios dentro de la carpeta `lib`: `app`, `data_layer`, `domain_layer` y `presentation_layer`.
  
- El directorio `app` se correspondería con todos los archivos de la app (screens, recursos, imágenes, etc).
- `data_layer`: Contiene los DTOs, los repositorios y proveedores de datos y el mappeado de DTOs a modelos (y viceversa). También contiene la librería para trabajar con el backend (`network`).
- `domain_layer`: Contiene los repositorios abstractos, los modelos y los casos de uso los cuales se encargan de realizar una acción en específico y proveer datos a los cubits. Los repositorios abstractos permiten que se pueda cambiar de repositorios y proveedores de datos dependiendo de las necesidades de la app. Los use cases permiten testear pequeñas partes de la app con test unitarios.
- `presentation_layer`: Contine un directorio de cubits que la app puede utilizar.

Los directorios `data_layer`, `domain_layer` y `presentation_layer` están preparados para llevarlos a un paquete a parte y utilizarl dicho paquete como SDK común para varias apps. Esto nos aportaría beneficios tales cómo:

- Es fácil generar diferentes flavors para la app (dev, test, prod...) para trabajar en diferentes entornos de desarrollo.
- Se puede cambiar de repositorios y proveedores de datos de una manera sencilla sin tener que realizar grandes cambios en los demás elementos del SDK.
- El testeo unitario de los cubits es más sencillo, ya que no tenemos que preocuparnos de los repositorios y proveedores de datos, sólo de los estados que el cubit expone hacia la app. Los repositorios y proveedores de datos se pueden testear a nivel de cada método de manera individual en los test unitarios de los use cases que los cubits utilizan.
- Migrar a un nuevo repositorio para una nueva app es sencillo, ya que el SDK provee todo lo necesario para comenzar un nuevo desarrollo.

# State management utilizado

He decidido utilizar el paquete `flutter_bloc` para gestionar los estados de la app. Más específicamente los `Cubit`s. Como podréis comprobar, he añadido clases auxiliares a los estados de los cubits y los cubits. También he añadido varios widget helpers para deshacerme del a mayor cantidad de código duplicado en la UI y de esta manera unificar la forma de trabajar entre vistas. En este ejemplo quizá no se ha utilizado demasiado, pero quería mostraros esta opción que me parece muy útil ya que nos aporta beneficios como:

- Todos los desarrollos estarían unificados entre desarrolladores. Cualquier característica implementada por otra persona sería más sencillo de abordar ya que el desarrollo del state management se ha realizado de manera similar a la que solemos utilizar.
- A la hora de hacer code reviews de otros compañeros, simplifica las cosas, ya que podemos tener la certeza de que la estructura del código es bastante parecida a la que nosotros solemos utilizar.
- Introducir a nuevos desarrolladores a nuestro código debería ser bastante más sencillo independientemente del nivel del nuevo desarrollador.

Se han utilizado varias clases con métodos o gettes estáticos en la app. Esto se ha hecho para simplificar la prueba técnica, pero en un caso real, estas clases pasarían a ser `InheritedWidgets` con una estructura diferente que podrían ser inyectados por encima de nuestra `MaterialApp` para proveer dicha clase a todo el widget tree. (Localizaciones, Temas, etc.)

# ¿Qué haría de manera diferente si se le asignara más tiempo?

- Habría mejorado la estructura del código, llevándome clases que pueden ser utilizadas por varias apps (por ejemplo, el directorio network o el base state y los cubit helper widgets) a otra librería. De este modo, nuevos desarrollos ya tendrían esas funciones disponibles.
- Habría implementado un ejemplo de lo sencillo que sería ahora mismo añadir otro repositorio totalmente diferente al que hemos utilizado en esta prueba (API). Por ejemplo habría creado una base de datos con productos y habría cargado los productos desde ahí. Simplemente debería añadir un repositorio que implemente el repositorio abstracto y un proveedor para ese repositorio que sse encarge de leer los datos de la base de datos.
- Habría implementado test unitarios.
