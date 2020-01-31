# List

`List<ModelType>` is a DataStore-aware custom `Collection` that is capable of loading
records from the `DataStore` on-demand. This is specially useful when dealing with
Model associations that need to be lazy loaded.

``` swift
public class List<ModelType: Model>: Collection, Codable, ExpressibleByArrayLiteral
```

When using `DataStore.query(_ modelType:)` some models might contain associations
with other models and those aren't fetched automatically. This collection keeps track
of the associated `id` and `field` and fetches the associated data on demand.

## Inheritance

`Collection`, `Codable`, `ExpressibleByArrayLiteral`

## Nested Types

  - List.LoadState

## Nested Type Aliases

## Index

``` swift
Typealias(context: Optional("List"), attributes: [], modifiers: [public], keyword: "typealias", name: "Index", initializedType: Optional("Int"), genericParameters: [], genericRequirements: [])
```

## Element

``` swift
Typealias(context: Optional("List"), attributes: [], modifiers: [public], keyword: "typealias", name: "Element", initializedType: Optional("ModelType"), genericParameters: [], genericRequirements: [])
```

## Elements

``` swift
Typealias(context: Optional("List"), attributes: [], modifiers: [public], keyword: "typealias", name: "Elements", initializedType: Optional("[Element]"), genericParameters: [], genericRequirements: [])
```

## ArrayLiteralElement

``` swift
Typealias(context: Optional("List"), attributes: [], modifiers: [public], keyword: "typealias", name: "ArrayLiteralElement", initializedType: Optional("ModelType"), genericParameters: [], genericRequirements: [])
```

## LazyListPublisher

``` swift
Typealias(context: Optional("List"), attributes: [], modifiers: [public], keyword: "typealias", name: "LazyListPublisher", initializedType: Optional("AnyPublisher<Elements, DataStoreError>"), genericParameters: [], genericRequirements: [])
```

## Enumeration Cases

## pending

``` swift
case pending
```

## loaded

``` swift
case loaded
```

## Initializers

## init(\_:)

``` swift
public convenience init(_ elements: Elements)
```

## init(arrayLiteral:)

``` swift
required convenience public init(arrayLiteral elements: Element)
```

## init(from:)

``` swift
required convenience public init(from decoder: Decoder) throws
```

## Properties

## startIndex

``` swift
var startIndex: Index
```

## endIndex

``` swift
var endIndex: Index
```

## totalCount

``` swift
var totalCount: Int
```

## Methods

## index(after:)

``` swift
public func index(after index: Index) -> Index
```

## makeIterator()

``` swift
public __consuming func makeIterator() -> IndexingIterator<Elements>
```

## limit(\_:)

``` swift
public func limit(_ limit: Int) -> Self
```

## encode(to:)

``` swift
public func encode(to encoder: Encoder) throws
```

## load(\_:)

Trigger `DataStore` query to initialize the collection. This function always
fetches data from the `DataStore.query`.

``` swift
public func load(_ completion: DataStoreCallback<Elements>)
```

> Seealso: `load()`

## load()

Trigger `DataStore` query to initialize the collection. This function always
fetches data from the `DataStore.query`. However, consumers must be aware of
the internal behavior which relies on `DispatchSemaphore` and will block the
current `DispatchQueue` until data is ready. When operating on large result
sets, prefer using the asynchronous `load(completion:)` instead.

``` swift
public func load() -> Self
```

> Seealso: `load(completion:)`

### Returns

the current instance after data was loaded.

## loadAsPublisher()

Lazy load the collection and expose the loaded `Elements` as a Combine `Publisher`.
This is useful for integrating the `List<ModelType>` with existing Combine code
and/or SwiftUI.

``` swift
public func loadAsPublisher() -> LazyListPublisher
```

### Returns

a type-erased Combine publisher
