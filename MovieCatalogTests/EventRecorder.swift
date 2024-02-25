//
//  EventRecorder.swift
//  MovieCatalogTests
//
//  Created by Bruno Maciel on 2/25/24.
//

import Combine
import Foundation

protocol EventType {
    associatedtype Value
    var value: Value { get }
}

fileprivate struct ValueEvent<T>: EventType {
    let value: T
}
fileprivate struct CompletionEvent<T>: EventType {
    let value: T
}

final class EventRecorder<Output> {
    private var events: [any EventType] = []
    private var cancellables = Set<AnyCancellable>()

    var values: [Output] {
        events.compactMap { ($0 as? ValueEvent<Output>)?.value }
    }

    fileprivate init<P: Publisher>(_ publisher: P) where P.Output == Output {
        publisher
            .sink(receiveCompletion: { [unowned self] in
                self.events.append( CompletionEvent(value: $0))
            }, receiveValue: { [unowned self] in
                self.events.append(ValueEvent(value: $0))
            })
            .store(in: &cancellables)
    }
}

extension Publisher {
    func asRecorder() -> EventRecorder<Output> {
        EventRecorder(self)
    }
}
