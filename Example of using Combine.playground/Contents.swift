import UIKit
import Combine

//map operator:
/*In this example, we create a publisher from an array of numbers, and use the map operator to double each number. We subscribe to the doubled publisher with a sink, which prints each doubled value.*/

let numbers = [1, 2, 3, 4, 5]
let publisher = numbers.publisher

let doubled = publisher.map { number in
    return number * 2
}

let subscriber = doubled.sink(receiveValue: { value in
    print(value)
})


//retry operator:
/*In this example, we create a PassthroughSubject publisher that emits integers. We use the tryMap operator to simulate an error for the first two emitted values, and then emit the third value successfully. We use the retry operator with a maximum of two retries to resubscribe to the pipeline in case of a failure. We subscribe to the retryablePublisher with a sink, which prints each successfully emitted value.*/
var count = 0
let retryPublisher = PassthroughSubject<Int, Error>()

let retryablePublisher = publisher
    .tryMap { value -> Int in
        count += 1
        if count < 3 {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return value
    }
    .retry(2)

let retrySubscriber = retryablePublisher.sink(receiveCompletion: { completion in
    print(completion)
}, receiveValue: { value in
    print(value)
})

retryPublisher.send(1)
retryPublisher.send(2)
retryPublisher.send(3)

//breakpoint operator:

/*In this example, we create a publisher from an array of numbers, and use the breakpoint operator to print a message when the value 3 is emitted. We subscribe to the breakpointPublisher with a sink, which prints each emitted value.*/

let numbersOperator = [1, 2, 3, 4, 5]
let publisherOperator = numbersOperator.publisher

let breakpointPublisher = publisherOperator
    .breakpoint(receiveSubscription: { _ in print("Subscription started") },
               receiveOutput: { value in
                if value == 3 {
                    print("Reached breakpoint")
                }
               })

let subscriber = breakpointPublisher.sink(receiveValue: { value in
    print(value)
})


//filter operator:
/*In this example, we create a publisher from an array of numbers, and use the filter operator to only emit even numbers. We subscribe to the filtered publisher with a sink, which prints each emitted value.*/


//let numbers = [1, 2, 3, 4, 5]
//let publisher = numbers.publisher
//
//let filtered = publisher.filter { number in
//    return number % 2 == 0
//}
//
//let subscriber = filtered.sink(receiveValue: { value in
//    print(value)
//})


//zip operator:

//let numbers = [1, 2, 3, 4, 5]
//let publisher = numbers.publisher
//
//let names = ["Alice", "Bob

