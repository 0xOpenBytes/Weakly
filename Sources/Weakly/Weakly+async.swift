/**
 Returns a weakly captured closure that executes the provided closure with the object if it still exists, otherwise does nothing.

 - Parameters:
     - object: The object to be weakly captured.
     - closure: The closure to be executed with the object.
 - Returns: An asynchronous closure that captures the object weakly.

 Example:

 ```swift
 let object = Object()

 let closure = weakly(object) { strongObject in
    await strongObject.asyncMethod()
 }

 await closure()
 ```
 */
public func weakly<Object: AnyObject>(
    _ object: Object,
    closure: @escaping (Object) async -> Void
) -> () async -> Void {
    { [weak object] in
        guard let object = object else { return }
        await closure(object)
    }
}

/**
 Returns a closure that weakly captures `object` and calls `closure` with `input`.

 - Parameters:
   - object: An object to weakly capture.
   - closure: A closure that takes an object of type `Object` and an input of type `Input` and returns `Void`, wrapped in an `async` context.

 - Returns: A closure that takes an input of type `Input`, wrapped in an `async` context, and returns `Void`.
*/
public func weakly<Object: AnyObject, Input>(
    _ object: Object,
    closure: @escaping (Object, Input) async -> Void
) -> (Input) async -> Void {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return
        }

        await closure(object, input)
    }
}

/**
 Returns a weakly captured closure that executes the provided closure with the object if it still exists, otherwise returns nil.

 - Parameters:
     - object: The object to be weakly captured.
     - closure: The closure to be executed with the object.
 - Returns: An asynchronous closure that captures the object weakly and returns an optional value.

 Example:

 ```swift
 let object = Object()

 let closure = weakly(object) { strongObject in
    return await strongObject.asyncMethod()
 }

 let result = await closure()
 ```
 */

public func weakly<Object: AnyObject, Output>(
    _ object: Object,
    closure: @escaping (Object) async -> Output
) -> () async -> Output? {
    { [weak object] in
        guard let object = object else {
            return nil
        }

        return await closure(object)
    }
}

/**
Returns a closure that weakly captures `object` and passes `input` to `closure` upon invocation.

If `object` has been deallocated by the time the closure is invoked, no action will be taken.

- Parameters:
    - object: The object to be weakly captured by the returned closure.
    - closure: The closure to be invoked with `object` and `input`.
- Returns: A closure that takes an `Input` value and invokes `closure` with `object` and the input value.
*/
public func weakly<Object: AnyObject, Input, Output>(
    _ object: Object,
    closure: @escaping (Object, Input) async -> Output
) -> (Input) async -> Output? {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return nil
        }

        return await closure(object, input)
    }
}
