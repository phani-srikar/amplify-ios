# ModelSchema

``` swift
public struct ModelSchema
```

## Properties

## name

``` swift
let name: String
```

## pluralName

``` swift
let pluralName: String?
```

## fields

``` swift
let fields: ModelFields
```

## attributes

``` swift
let attributes: [ModelAttribute]
```

## sortedFields

``` swift
let sortedFields: [ModelField]
```

## primaryKey

``` swift
var primaryKey: ModelField
```

## isSyncable

``` swift
var isSyncable: Bool
```

## isSystem

``` swift
var isSystem: Bool
```

## Methods

## field(withName:)

``` swift
public func field(withName name: String) -> ModelField?
```
