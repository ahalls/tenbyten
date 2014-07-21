TenByTen
========
TenByTen is a native iOS project to display news headline photos gathered by
the 10x10 website.  

I've written this project for two purposes.  1) To showcase a basic application underdevelopment.  2) To explore the visual news application space.

Currently the app is just getting off the ground with very basic functionality on 
the iPhone.

Update
------
I'm going to re-work this example usint the following techniologies
- Swift
- ReactiveCocoa
- AFNetworking 2.0
- MVVM Pattern 

Implementation
--------------
This project uses the (http://cocoapods.org/) Cocoapods library management system to bring in third party software into the project.

The iOS SDK builds heavly on the MVC code pattern.  One of the heuristics I use is to work to keep the view controllers thin and put application logic in the models. Its always a challenge but it pays off in easier to maintain code.

The Model in this implementation uses the Singleton patern to implement a Data Manager that holds data in memory for use by the View Controller and interfaces with the Server through an API Client class.  I endevor to keep all the server interface details in the ApiClient so changes in the server interface protocol will only effect that class.  


## License

TenByTen iOS is available under the MIT license. See the LICENSE file for more info.
