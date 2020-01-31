# QueryPredicateGroup

``` swift
public class QueryPredicateGroup: QueryPredicate
```

## Inheritance

[`QueryPredicate`](QueryPredicate), `Equatable`

## Initializers

## init(type:predicates:)

``` swift
public init(type: QueryPredicateGroupType = .and, predicates: [QueryPredicate] = [])
```

## Properties

## type

``` swift
var type: QueryPredicateGroupType
```

## predicates

``` swift
var predicates: [QueryPredicate]
```

## Methods

## and(\_:)

``` swift
public func and(_ predicate: QueryPredicate) -> QueryPredicateGroup
```

## or(\_:)

``` swift
public func or(_ predicate: QueryPredicate) -> QueryPredicateGroup
```

## &&(lhs:rhs:)

``` swift
public static func &&(lhs: QueryPredicateGroup, rhs: QueryPredicate) -> QueryPredicateGroup
```

## ||(lhs:rhs:)

``` swift
public static func ||(lhs: QueryPredicateGroup, rhs: QueryPredicate) -> QueryPredicateGroup
```

## \!(rhs:)

``` swift
public static prefix func !(rhs: QueryPredicateGroup) -> QueryPredicateGroup
```

## \==(lhs:rhs:)

``` swift
public static func ==(lhs: QueryPredicateGroup, rhs: QueryPredicateGroup) -> Bool
```
