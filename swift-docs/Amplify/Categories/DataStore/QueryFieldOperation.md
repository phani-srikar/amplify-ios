# QueryFieldOperation

`QueryFieldOperation` provides functions that creates predicates based on a field name.
These functions are matchers that get executed at a later point by specific implementations
of the `Model` filtering logic (e.g. SQL or GraphQL queries).

``` swift
public protocol QueryFieldOperation
```

> Seealso: `QueryField`

> Seealso: `ModelKey`

## Conforming Types

[`ModelKey`](ModelKey), [`QueryField`](QueryField)

## Required Methods

## beginsWith(\_:)

``` swift
func beginsWith(_ value: String) -> QueryPredicateOperation
```

## between(start:end:)

``` swift
func between(start: Persistable, end: Persistable) -> QueryPredicateOperation
```

## contains(\_:)

``` swift
func contains(_ value: String) -> QueryPredicateOperation
```

## eq(\_:)

``` swift
func eq(_ value: Persistable?) -> QueryPredicateOperation
```

## ge(\_:)

``` swift
func ge(_ value: Persistable) -> QueryPredicateOperation
```

## gt(\_:)

``` swift
func gt(_ value: Persistable) -> QueryPredicateOperation
```

## le(\_:)

``` swift
func le(_ value: Persistable) -> QueryPredicateOperation
```

## lt(\_:)

``` swift
func lt(_ value: Persistable) -> QueryPredicateOperation
```

## ne(\_:)

``` swift
func ne(_ value: Persistable?) -> QueryPredicateOperation
```

## ~=(key:value:)

``` swift
static func ~=(key: Self, value: String) -> QueryPredicateOperation
```

## \==(key:value:)

``` swift
static func ==(key: Self, value: Persistable?) -> QueryPredicateOperation
```

## \>=(key:value:)

``` swift
static func >=(key: Self, value: Persistable) -> QueryPredicateOperation
```

## \>(key:value:)

``` swift
static func >(key: Self, value: Persistable) -> QueryPredicateOperation
```

## \<=(key:value:)

``` swift
static func <=(key: Self, value: Persistable) -> QueryPredicateOperation
```

## \<(key:value:)

``` swift
static func <(key: Self, value: Persistable) -> QueryPredicateOperation
```

## \!=(key:value:)

``` swift
static func !=(key: Self, value: Persistable?) -> QueryPredicateOperation
```
