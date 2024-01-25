# APIRest Demo
APIs Públicas
Repositorio 100% nativo en Swift en UIKIt en el que se realizan conexiones a diferentes API Rest. Para cada API he utilizado 3 diferentes patrones para manejar la asincronía:

* Patrón `callback` 
* Librería `Combine`
* Modelo de concurrencia `Async-await` .
  
### [Math Tools API](https://math.tools/api/numbers/)
Proporciona en formato json un número generado de manera aleatoria y su detalle como su equivalente en Binario, su version en Romano, Chino, si es primo, perfecto, triangular, etc.

Para la gestión de la asincronía se utiliza el patrón `callback` y `URLSession` 

### [Chuck Norris Facts API](https://api.chucknorris.io)
Proporciona en formato json un chiste aleatorio relacionado el *legendario* Chuck Norris. 

**Implementación**
`Combine`  y `URLSession` para la conexión a la API 
`NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
Persistencia de datos con un archivo `JSON` que se guarda en carpeta de documentos de la app. 
*Unit Tests* del `ModelLogic` y un *Mock* de `URLSession` gracias a `URLPRotocol`

### [API Découpage administratif](https://geo.api.gouv.fr/decoupage-administratif)
Proporciona información sobre la división administrativa de regiones, departamentos y municipios en Francia. Datos por municipio como código postal, población. 

**Implementación**
`Combine`  y `URLSession` para la conexión a la API 
`NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
*Unit Tests* del `ModelLogic` con un *Mock* en la petición a red

### [Dice Bear (Fun Emoji)](https://www.dicebear.com/styles/fun-emoji/) 
API que genera un avatar personalizable en formato SVG, PNG o JPG, con opciones como color de fondo, ojos, boca, tamaño, rotación, etc. 

**Implementación**
Hecho con el modelo de concurrencia `Async-await` 
`NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
Permite la persistencia de datos través de `CoreData`.
