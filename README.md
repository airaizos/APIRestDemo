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
* `Patron Callback`  y `URLSession` para la conexión a la API [ChuckNorrisNetwork](https://github.com/airaizos/APIRestDemo/blob/d7fb0f0afbe56a8d26b1f44bf810fd23bab14173/APIRestDemo/APIRestDemo/ChuckNorrisNetwork.swift)
* `NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
* Persistencia de datos con un archivo `JSON` que se guarda en carpeta de documentos de la app. 
* `TableView` para los items persistidos
*  *Unit Tests* del `ModelLogic` y un *Mock* de `URLSession` gracias a `URLPRotocol` [ChuckURLSessionMock](https://github.com/airaizos/APIRestDemo/blob/d7fb0f0afbe56a8d26b1f44bf810fd23bab14173/APIRestDemo/APIRestDemoTests/ChuckNorrisHelpers.swift)

![](https://github.com/airaizos/APIRestDemo/blob/0fa55be8a1ecea225d12105356a379c2423adb9c/APIRestDemo/ChuckNorris.png)
### [API Découpage administratif](https://geo.api.gouv.fr/decoupage-administratif)
Proporciona información sobre la división administrativa de regiones, departamentos y municipios en Francia. Datos por municipio como código postal, población. 

**Implementación**
* `Combine`  y `URLSession` para la conexión a la API [CommunesNetwork](https://github.com/airaizos/APIRestDemo/blob/d7fb0f0afbe56a8d26b1f44bf810fd23bab14173/APIRestDemo/APIRestDemo/Features/FrenchRegions/Network/CommunesNetwork.swift)
* `NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
* `TableView` para los listados
* *Unit Tests* del `ModelLogic` con un *Mock* en la petición a red [CommunesUnitTests](https://github.com/airaizos/APIRestDemo/blob/d7fb0f0afbe56a8d26b1f44bf810fd23bab14173/APIRestDemo/APIRestDemoTests/Communes/CommunesUnitTests.swift)

### [Dice Bear (Fun Emoji)](https://www.dicebear.com/styles/fun-emoji/) 
API que genera un avatar personalizable en formato SVG, PNG o JPG, con opciones como color de fondo, ojos, boca, tamaño, rotación, etc. 

**Implementación**
* Hecho con el modelo de concurrencia `Async-await` [Statics](https://github.com/airaizos/APIRestDemo/blob/1b3d1654d529310e3eb5c50e182f597f7af817bc/APIRestDemo/APIRestDemo/Public/Statics.swift)
* `NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
* Permite la persistencia de datos través de `CoreData`.[APIRestDemoDataBase](https://github.com/airaizos/APIRestDemo/blob/1b3d1654d529310e3eb5c50e182f597f7af817bc/APIRestDemo/APIRestDemo/Features/DiceBear/Persistence/APIRestDemoDataBase.swift)
* `CollectionView` para mostrar los elementos persistidos

![](https://github.com/airaizos/APIRestDemo/blob/0fa55be8a1ecea225d12105356a379c2423adb9c/APIRestDemo/FunEmoji.png)

### Países
Diferentes APIs de las que se obtiene un [listado de países](https://countryinfoapi.com) ( 250 ) y a partir de esa información se consulta en otras APIs para la descarga de la [bandera del icono](https://flagsapi.com) de la tabla, la [bandera en tamaño](https://flagpedia.net/download/api) 128x96, y una cuarta API con APIKey que permite la [consulta de la regiones y ciudades](http://battuta.medunes.net) del país seleccionado.

**Implementación**
* Hecho con la funcionalidad `Continuations` que permite crear un puente entre la función de red con `callback` para convertirlo a un código asíncrono (async-await). [Countries Network](https://github.com/airaizos/APIRestDemo/blob/1b3d1654d529310e3eb5c50e182f597f7af817bc/APIRestDemo/APIRestDemo/Features/Countries/Network/CountriesNetwork.swift)
* Interfaz de red que implementa un *ApiKey* para el acceso a las regiones y ciudades.
* `NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
* `MapKit` para mostrar la localización de la ciudad elegida y calcular la distancia hasta la localización del usuario [CountryDetailViewController](https://github.com/airaizos/APIRestDemo/blob/1b3d1654d529310e3eb5c50e182f597f7af817bc/APIRestDemo/APIRestDemo/Features/Countries/Controller/CountryDetailViewController.swift)
  
![](https://github.com/airaizos/APIRestDemo/blob/0fa55be8a1ecea225d12105356a379c2423adb9c/APIRestDemo/Countries.png)
### Marvel Characters
API que obtiene de la [API Developer Marvel](developer.marvel.com) un listado de imágenes de los personajes, a los que se les puede marcar como favorito.

**Implementación**
* Hecho con el modelo de concurrencia `Async-await` 
* `NotificationCenter` para la notificación del cambio en de los valores en las propiedades. 
* Las `CollectionViews` están implementadas con la clase `DiffableDataSource` para la gestión de los elementos. [MarvelCharactersModelLogic](https://github.com/airaizos/APIRestDemo/blob/1b3d1654d529310e3eb5c50e182f597f7af817bc/APIRestDemo/APIRestDemo/Features/MarvelCharacters/Model/MarvelCharactersModelLogic.swift)
* Grupos de tareas permiten la concurrencia de  `Async-await` en la devolución de las imágenes de los personajes [MarvelCharactersNetwork](https://github.com/airaizos/APIRestDemo/blob/1b3d1654d529310e3eb5c50e182f597f7af817bc/APIRestDemo/APIRestDemo/Features/MarvelCharacters/Network/MarvelCharactersNetwork.swift)
* El diseño de las celdas de las `CollectionViews` está implementado en **SwiftUI** gracias el `UIHostingConfiguration` [MarvelCharactersCollectionViewController](https://github.com/airaizos/APIRestDemo/blob/1b3d1654d529310e3eb5c50e182f597f7af817bc/APIRestDemo/APIRestDemo/Features/MarvelCharacters/Controller/MarvelCharactersCollectionViewController.swift)
* Interfaz de red que implementa un *timestamp*, *ApiKey* y *hash* para el acceso a la API
  
![](https://github.com/airaizos/APIRestDemo/blob/0fa55be8a1ecea225d12105356a379c2423adb9c/APIRestDemo/MarvelCharacters.png)
