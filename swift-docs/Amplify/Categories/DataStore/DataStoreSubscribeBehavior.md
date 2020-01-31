# DataStoreSubscribeBehavior

``` swift
public protocol DataStoreSubscribeBehavior
```

## Conforming Types

[`DataStoreCategory`](DataStoreCategory)

## Required Methods

## publisher(for:)

Returns a Publisher for model changes (create, updates, delete)

``` swift
@available(iOS 13.0, *) func publisher<M: Model>(for modelType: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>
```

  - Parameter modelType: The model type to observe
