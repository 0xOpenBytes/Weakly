# Weakly

*[weak object]*

## Introduction

Weakly is a lightweight utility library that provides a simple way to safely capture a weak reference to an object within a closure. This helps to prevent retain cycles, which can lead to memory leaks in your code.

Weakly provides a set of functions that allow you to capture a weak reference to an object and pass it to a closure. These functions come in several variations, depending on the type of closure you need to capture.

## Usage

The most basic use case for Weakly is capturing a weak reference to an object and passing it to a closure that takes no arguments and returns no value. Here's an example:

```swift
class MyClass {
    func myMethod() {
        weakly(self) { object in
            // Use the object safely inside the closure
        }()
    }
}
```

In this example, self is captured weakly and passed to the closure. The closure takes one argument of type MyClass (the object captured weakly), and uses it inside the closure.

Weakly also provides variations of the basic function that allow you to capture weak references and pass them to closures that take one or more arguments, return a value, or throw an error.

Here are some examples:

```swift
// Capture a weak reference and pass it to a closure that takes one argument and returns a value
let result: Int? = weakly(self) { object in
    // Use the object safely inside the closure, and return a value
}()

// Capture a weak reference and pass it to a closure that takes one argument and throws an error
do {
    try weakly(self) { object in
        // Use the object safely inside the closure, and throw an error if necessary
    }()
} catch {
    // Handle the error
}
```
