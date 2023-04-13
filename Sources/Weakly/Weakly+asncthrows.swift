/**
 Creates a weak reference to the provided `object`, and returns a closure that executes the given asynchronous closure `closure` with the referenced object as its argument, if the object is still alive.
 
 If the object has already been deallocated, the closure is not executed.
 
 - Parameters:
     - object: The object that should be weakly referenced.
     - closure: The asynchronous closure to execute with the referenced object.
 
 - Returns: A closure that can be executed to invoke `closure` with a weakly referenced object.
 */
public func weakly<Object: AnyObject>(
    _ object: Object,
    closure: @escaping (Object) async throws -> Void
) -> () async throws -> Void {
    { [weak object] in
        guard let object = object else { return }
        try await closure(object)
    }
}

/**
Captures a weak reference to an object and returns an asynchronous closure that takes an input argument, and executes asynchronously. The closure captures a strong reference to the object weakly, and performs an asynchronous operation on it, passing the input value.

- Parameters:
    - object: The object to capture weakly.
    - closure: An asynchronous closure that takes the object and an input value as arguments and performs an asynchronous operation.

- Returns: An asynchronous closure that takes an input value and returns void.

Example:

```swift
weakly(self) { object, input in
    await object.myAsyncMethod(input)
}
```
*/
public func weakly<Object: AnyObject, Input>(
    _ object: Object,
    closure: @escaping (Object, Input) async throws -> Void
) -> (Input) async throws -> Void {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return
        }

        try await closure(object, input)
    }
}

/**
 Creates a weak reference to the provided `object`, and returns a closure that executes the given asynchronous closure `closure` with the referenced object as its argument, if the object is still alive.
 
 If the object has already been deallocated, the closure is not executed.
 
 - Parameters:
     - object: The object that should be weakly referenced.
     - closure: The asynchronous closure to execute with the referenced object.
 
 - Returns: The output of the closure, wrapped in an optional, if the object is still alive; otherwise, `nil`.
 */
public func weakly<Object: AnyObject, Output>(
    _ object: Object,
    closure: @escaping (Object) async throws -> Output
) -> () async throws -> Output? {
    { [weak object] in
        guard let object = object else {
            return nil
        }
        
        return try await closure(object)
    }
}

/**
Creates a weakly retained closure that takes an asynchronous input argument and asynchronously returns an optional output.

- Parameters:
    - object: The object to be weakly retained.
    - closure: A closure to execute asynchronously with the weakly retained object and an input argument of type `Input`, returning an output of type `Output`.

- Returns: A closure that takes an input of type `Input`, executes the given `closure` asynchronously with the weakly retained object and the input argument, and returns an optional output of type `Output`.
*/
public func weakly<Object: AnyObject, Input, Output>(
    _ object: Object,
    closure: @escaping (Object, Input) async throws -> Output
) -> (Input) async throws -> Output? {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return nil
        }

        return try await closure(object, input)
    }
}
