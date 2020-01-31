# QueryField

``` swift
public struct QueryField: QueryFieldOperation
```

## Inheritance

[`QueryFieldOperation`](QueryFieldOperation)

## Properties

## name

``` swift
let name: String
```

## Methods

## beginsWith(\_:)

``` swift
public func beginsWith(_ value: String) -> QueryPredicateOperation
```

## between(start:end:)

``` swift
public func between(start: Persistable, end: Persistable) -> QueryPredicateOperation
```

## contains(\_:)

``` swift
public func contains(_ value: String) -> QueryPredicateOperation
```

## ~=(key:value:)

``` swift
public static func ~=(key: Self, value: String) -> QueryPredicateOperation
```

## eq(\_:)

``` swift
public func eq(_ value: Persistable?) -> QueryPredicateOperation
```

## \==(key:value:)

``` swift
public static func ==(key: Self, value: Persistable?) -> QueryPredicateOperation
```

## ge(\_:)

``` swift
public func ge(_ value: Persistable) -> QueryPredicateOperation
```

## \>=(key:value:)

``` swift
public static func >=(key: Self, value: Persistable) -> QueryPredicateOperation
```

## gt(\_:)

``` swift
public func gt(_ value: Persistable) -> QueryPredicateOperation
```

## \>(key:value:)

``` swift
public static func >(key: Self, value: Persistable) -> QueryPredicateOperation
```

## le(\_:)

``` swift
public func le(_ value: Persistable) -> QueryPredicateOperation
```

## \<=(key:value:)

``` swift
public static func <=(key: Self, value: Persistable) -> QueryPredicateOperation
```

## lt(\_:)

``` swift
public func lt(_ value: Persistable) -> QueryPredicateOperation
```

## \<(key:value:)

``` swift
public static func <(key: Self, value: Persistable) -> QueryPredicateOperation
```

## ne(\_:)

``` swift
public func ne(_ value: Persistable?) -> QueryPredicateOperation
```

## \!=(key:value:)

``` swift
public static func !=(key: Self, value: Persistable?) -> QueryPredicateOperation
```
