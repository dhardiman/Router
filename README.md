# ![](Images/Banner.png)

A set of protocols that can be used to describe navigational architecture for an iOS app.

Consists on 3 primary components:

- `Destination`: This is a simple protocol that describes something that can create a view controller. Implementations should be able to construct a view controller with all its dependencies, so should be passed in initialisers. A `Destination` can also describe how it would prefer to be presented.
- `Route`: This is a protocol that indicates how a URL (via `URLRoute`) or a model object (via `ObjectRoute`) can be converted in to a `Destination`. `Route` implementations may do this conversion asynchronously if they need to look up data for the information. For example if a network API call needs to take place.
- `Router`: This protocol describes a simple set of methods that allow components in your app to route to new screens. Any implementation should use the methods as a chance to encapsulate things like showing new view controllers in tabs, modally or in navigation controllers.