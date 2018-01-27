# Example MVVM

Goals: Evaluate a few different patters for MVVM under a few scenarios.

## Patterns

### KVO for observing

The view models inputs are prefixed with `input`.  And the outputs all start with `@objc dynamic` to show they can be observed using Key-Value-Observing.

Pros
* KVO is a generally understood pattern

Cons
* Need to make sure you remove observers to support iOS under 11
* Need to use @objc on properties you would like to watch and ViewModels must inherit from NSObject
* Can't watch objects that are native to Swift

### Closure with state object

From https://talk.objc.io/episodes/S01E47-view-models

A "state" `struct` is created that contains all the outputs from the view model and when it is updated the closure is called.

Pros
* Each to test changes in state over time (you can keep track of an array of state struct changes in the test case)
* No need to remove observers
* Can watch objects that are native to Swift

Cons
* Only one listener is supported for each property

### Bindable closure

From http://swiftyjimmy.com/mvvm-with-swift-application-23/

Using a `Bindable` class to observe outputs on the view model using closures.

Pros
* Only need to update UI for each property as it's updated vs updating everything from a state object.
* No need to remove observers
* Can watch objects that are native to Swift

Cons
* Need to use `property.value = ` vs the standard `property = `
* Only supports one listener per output

### ReactiveSwift

TODO: Need to dig into this one :)

## Scenarios

- [X] Simple Input: Dynamically validate a UITextField and enable a UIButton
- [ ] Static Cells
- [ ] Cells with Interaction
