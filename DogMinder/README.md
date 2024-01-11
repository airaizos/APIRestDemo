#Dogminder

##Descripción:

Dogminder es una aplicación de notas diseñada para propietarios de perros, facilitando la clasificación y filtrado de notas según su tipo.

##Tecnologías utilizadas:

Desarrollada en SwiftUI con una arquitectura MVVM . Implementa protocolos para los casos de uso (*UseCases*), permitiendo la abstracción en capas de la persistencia de datos, utilizando en este caso CoreData. La implementación incluye **Unit Test** del *ViewModel* para garantizar la correcta ejecución de las solicitudes, utilizando un `MockUseCase`, gracias a protocolos. También se han incorporado **Integration Tests** que, mediante el *UseCase*, inyectan una dependencia de la base de datos `CoreData` creada en memoria.

##Esquema de UseCases para pruebas

En la versión de producción, a través del `UseCaseContract` (Protocolos), se posibilita la **dependency injection** de la `NoteDataBase`. Esto permite cambiar dicha dependencia al realizar los **Integration Tests**.

El `MockUseCase` posibilita los **Unit Tests* del *ViewModel*, asegurando que las llamadas se realicen de manera correcta, se devuelvan los datos solicitados y se evalúen.

[Imagen]()

##UseCases

Los *UseCases* están diseñados con una sola responsabilidad, divididos en:

*CreateNote*: del tipo `NoteCreator`
*FetchAllNotes*: del tipo `NoteFetcher`
*UpdateNote*: del tipo `NoteUpdater`
*RemoveNote*: del tipo `NoteRemover`

Cada uno se inicializa con la dependencia del tipo `PersistenceProtocol` que inyecta la base de datos de **CoreData**.

EL *ViewModel* se inicializa con todos los *UseCases* lo cual permite, gracias a los protocolos, intercambiar por dependencias de *Testing*.

##ContentView
La vista se compone de las vistas `ReminderTypeGridView` y `NoteListView` permitiendo su reutilización cuando sea necesario, mejorando así la legibilidad del código.
