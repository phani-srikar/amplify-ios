# DataStoreBaseBehavior

``` swift
public protocol DataStoreBaseBehavior
```

## Conforming Types

[`DataStoreCategory`](DataStoreCategory)

## Required Methods

## save(\_:completion:)

Saves the model to storage. If sync is enabled, also initiates a sync of the mutation to the remote API

``` swift
func save<M: Model>(_ model: M, completion: @escaping DataStoreCallback<M>)
```

## query(\_:byId:completion:)

``` swift
func query<M: Model>(_ modelType: M.Type, byId id: String, completion: DataStoreCallback<M?>)
```

## query(\_:where:completion:)

``` swift
func query<M: Model>(_ modelType: M.Type, where predicate: QueryPredicateFactory?, completion: DataStoreCallback<[M]>)
```

## delete(\_:completion:)

``` swift
func delete<M: Model>(_ model: M, completion: @escaping DataStoreCallback<Void>)
```

## delete(\_:withId:completion:)

``` swift
func delete<M: Model>(_ modelType: M.Type, withId id: String, completion: @escaping DataStoreCallback<Void>)
```
