# Example MVVM

Goals: Use a few different patters for MVVM for a few scenarios.

## Patterns

### KVO for observing

The view models inputs are prefixed with `input`.  And the outputs all start with `@objc dynamic` to show they can be observed using Key-Value-Observing.

### Closure with state object

From https://talk.objc.io/episodes/S01E47-view-models

A "state" `struct` is created that contains all the outputs from the view model and when it is updated the closure is called.

Benefits
* Each to test changes in state over time (you can keep track of an array of state struct changes in the test case)

### ReactiveSwift

TODO: Need to dig into this one :)

## Scenarios

- [X] Simple Input: Dynamically validate a UITextField and enable a UIButton
- [ ] Static Cells
- [ ] Cells with Interaction
