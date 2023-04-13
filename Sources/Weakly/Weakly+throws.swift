/**
 Returns a closure that weakly captures an object and calls the closure with the object as its argument. If the object is deallocated, the closure will not be called.

 - Parameters:
 - object: An object to weakly capture.
 - closure: A closure to call with the captured object.

 - Returns: A closure that weakly captures the object and calls the closure with the object as its argument. If the object is deallocated, the closure will not be called.
 */
public func weakly<Object: AnyObject>(
    _ object: Object,
    closure: @escaping (Object) throws -> Void
) -> () throws -> Void {
    { [weak object] in
        guard let object = object else { return }
        try closure(object)
    }
}

/**
Returns a closure that weakly captures `object` and applies `closure` with the provided `Input`.

- Parameters:
    - object: The object to weakly capture.
    - closure: The closure to apply with `Input` and `object`.

- Returns: A closure that applies `closure` with the provided `Input`, weakly capturing `object`.
*/
public func weakly<Object: AnyObject, Input>(
    _ object: Object,
    closure: @escaping (Object, Input) throws -> Void
) -> (Input) throws -> Void {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return
        }

        try closure(object, input)
    }
}


/**
 Returns a closure that weakly captures an object and calls the closure with the object as its argument, returning the output of the closure. If the object is deallocated, the closure will return `nil`.

 - Parameters:
 - object: An object to weakly capture.
 - closure: A closure to call with the captured object.
 
 - Returns: A closure that weakly captures the object and calls the closure with the object as its argument, returning the output of the closure. If the object is deallocated, the closure will return `nil`.
 */
public func weakly<Object: AnyObject, Output>(
    _ object: Object,
    closure: @escaping (Object) throws -> Output
) -> () throws -> Output? {
    { [weak object] in
        guard let object = object else {
            return nil
        }

        return try closure(object)
    }
}

/**
 Returns a closure that weakly captures the provided object and executes a closure that takes the object and an input of type `Input` and returns a value of type `Output`. The returned closure takes an input of type `Input` and returns an optional value of type `Output`.

 - Parameters:
    - object: The object to be weakly captured.
    - closure: The closure to execute on the object with the input.

 - Returns: A closure that takes an input of type `Input` and returns an optional value of type `Output`. The closure weakly captures the provided object and executes the provided closure on the object with the input.
 */
public func weakly<Object: AnyObject, Input, Output>(
    _ object: Object,
    closure: @escaping (Object, Input) throws -> Output
) -> (Input) throws -> Output? {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return nil
        }

        return try closure(object, input)
    }
}
