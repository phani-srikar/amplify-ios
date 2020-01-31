# field(\_:)

## field(\_:)

Creates a new instance of the `QueryField` that can be used to create query predicates.

``` swift
public func field(_ name: String) -> QueryField
```

``` swift
field("id").eq("some-uuid")
// or using the operator-based:
field("id") == "some-uuid"
```

  - Parameter name: the name of the field

> Seealso: `ModelKey` for `CodingKey`-based approach on predicates

### Returns

an instance of the `QueryField`
