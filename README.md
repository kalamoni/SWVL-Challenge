# SWVL Challenge

### A demo app for SWVL:



- The app architecture is MVC and follows Cocoa design patterns whenever fit.

- Views are composed of storyboards and custom xib. 

- A single ViewController that manages and ties everything together.

- The model consists of a singleton `Lines` class which provides a globally accessible, shared instance. It has the property `linesList` which is a struct `LinesList` which consist of an array of a struct `Line`, which in turn contains a struct `Station`, which has struct `Location`. All structs are conforming to `Codable` protocol which helps converting them at ease  to and from external representations such as JSON.

- All networking are done via the singleton class of `NetworkManager`, which is a unified access point to make HTTP requests. And each type of request is done via a dedicated method.


- When the main view controller `MapViewController` first loaded, it subscribes to a custom Notification, then asks the `Lines` model via its singleton instance to fetch the lines, which in turn fetches them via the API using the `NetworkManager`. And then posts a notification using the `NotificationCenter` via property observer. The notification is received by the subscribed `MapViewController` and refreshes the `lines` asynchronously. 
