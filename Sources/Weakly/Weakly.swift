/**
 Returns a closure that weakly references an object and executes the given closure on it.

 - Parameters:
     - object: The object to weakly reference.
     - closure: The closure to execute on the object.

 - Returns: A closure that weakly references the object and executes the given closure on it.
 */
public func weakly<Object: AnyObject>(
    _ object: Object,
    closure: @escaping (Object) -> Void
) -> () -> Void {
    { [weak object] in
        guard let object = object else {
            return
        }

        closure(object)
    }
}

/**
 Returns a closure that weakly captures an object and an input value and passes them to a closure.

 - Parameters:
     - object: The object to be captured weakly.
     - closure: A closure that takes an object of the same type as the captured object and an input value, and performs an action.
 - Returns: A closure that takes an input value and passes it, along with the captured object, to the closure parameter.

 The returned closure captures `object` weakly, and if the object has been deallocated by the time the returned closure is called, nothing happens. Otherwise, the returned closure passes `object` and the input value to `closure`.
 */
public func weakly<Object: AnyObject, Input>(
    _ object: Object,
    closure: @escaping (Object, Input) -> Void
) -> (Input) -> Void {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return
        }

        closure(object, input)
    }
}

/**
 Returns a closure that weakly references an object and executes the given closure on it, returning the output of the closure.

 - Parameters:
     - object: The object to weakly reference.
     - closure: The closure to execute on the object.

 - Returns: A closure that weakly references the object and executes the given closure on it, returning the output of the closure as an optional.
 */
public func weakly<Object: AnyObject, Output>(
    _ object: Object,
    closure: @escaping (Object) -> Output
) -> () -> Output? {
    { [weak object] in
        guard let object = object else {
            return nil
        }

        return closure(object)
    }
}

/**
 Creates a closure that captures a weak reference to an object, and then returns a closure that takes an input and returns an optional output.

 - Parameters:
     - object: The object to capture weakly.
     - closure: The closure to capture.

 - Returns: A closure that takes an input and returns an optional output.
 */
public func weakly<Object: AnyObject, Input, Output>(
    _ object: Object,
    closure: @escaping (Object, Input) -> Output
) -> (Input) -> Output? {
    weak var weakObject = object

    return { (input: Input) in
        guard let object = weakObject else {
            return nil
        }

        return closure(object, input)
    }
}
