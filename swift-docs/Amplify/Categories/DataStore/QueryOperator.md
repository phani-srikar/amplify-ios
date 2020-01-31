# QueryOperator

``` swift
public enum QueryOperator
```

## Inheritance

`Equatable`

## Enumeration Cases

## notEqual

``` swift
case notEqual(_ value: Persistable?)
```

## equals

``` swift
case equals(_ value: Persistable?)
```

## lessOrEqual

``` swift
case lessOrEqual(_ value: Persistable)
```

## lessThan

``` swift
case lessThan(_ value: Persistable)
```

## greaterOrEqual

``` swift
case greaterOrEqual(_ value: Persistable)
```

## greaterThan

``` swift
case greaterThan(_ value: Persistable)
```

## contains

``` swift
case contains(_ value: String)
```

## between

``` swift
case between(start: Persistable, end: Persistable)
```

## beginsWith

``` swift
case beginsWith(_ value: String)
```

## Methods

## \==(lhs:rhs:)

``` swift
public static func ==(lhs: QueryOperator, rhs: QueryOperator) -> Bool
```
