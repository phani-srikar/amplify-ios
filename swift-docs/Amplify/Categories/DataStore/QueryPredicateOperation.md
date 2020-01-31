# QueryPredicateOperation

``` swift
public class QueryPredicateOperation: QueryPredicate
```

## Inheritance

[`QueryPredicate`](QueryPredicate), `Equatable`

## Initializers

## init(field:operator:)

``` swift
public init(field: String, operator: QueryOperator)
```

## Properties

## field

``` swift
let field: String
```

## \`operator\`

``` swift
let `operator`: QueryOperator
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
public static func &&(lhs: QueryPredicateOperation, rhs: QueryPredicate) -> QueryPredicateGroup
```

## ||(lhs:rhs:)

``` swift
public static func ||(lhs: QueryPredicateOperation, rhs: QueryPredicate) -> QueryPredicateGroup
```

## \!(rhs:)

``` swift
public static prefix func !(rhs: QueryPredicateOperation) -> QueryPredicateGroup
```

## \==(lhs:rhs:)

``` swift
public static func ==(lhs: QueryPredicateOperation, rhs: QueryPredicateOperation) -> Bool
```
