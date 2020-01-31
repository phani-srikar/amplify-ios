# not(\_:)

## not(\_:)

The `not` function is used to wrap a `QueryPredicate` in a `QueryPredicateGroup` of type `.not`.

``` swift
public func not<Predicate: QueryPredicate>(_ predicate: Predicate) -> QueryPredicateGroup
```

  - Parameter predicate: the `QueryPredicate` (either operation or group)

### Returns

`QueryPredicateGroup` of type `.not`
