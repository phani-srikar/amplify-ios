# ModelFieldType

``` swift
public enum ModelFieldType
```

## Inheritance

`CustomStringConvertible`

## Enumeration Cases

## string

``` swift
case string
```

## int

``` swift
case int
```

## double

``` swift
case double
```

## date

``` swift
case date
```

## dateTime

``` swift
case dateTime
```

## time

``` swift
case time
```

## bool

``` swift
case bool
```

## enum

``` swift
case enum(: Any.Type)
```

## model

``` swift
case model(type: Model.Type)
```

## collection

``` swift
case collection(of: Model.Type)
```

## Properties

## description

``` swift
var description: String
```

## isArray

``` swift
var isArray: Bool
```
