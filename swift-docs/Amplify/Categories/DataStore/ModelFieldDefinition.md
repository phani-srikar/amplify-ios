# ModelFieldDefinition

``` swift
public enum ModelFieldDefinition
```

## Enumeration Cases

## field

``` swift
case field(name: String, type: ModelFieldType, nullability: ModelFieldNullability, association: ModelAssociation?, attributes: [ModelFieldAttribute])
```

## Properties

## modelField

``` swift
var modelField: ModelField
```

## Methods

## field(\_:is:ofType:attributes:association:)

``` swift
public static func field(_ key: CodingKey, is nullability: ModelFieldNullability = .required, ofType type: ModelFieldType = .string, attributes: [ModelFieldAttribute] = [], association: ModelAssociation? = nil) -> ModelFieldDefinition
```

## id(\_:)

``` swift
public static func id(_ key: CodingKey) -> ModelFieldDefinition
```

## id(\_:)

``` swift
public static func id(_ name: String = "id") -> ModelFieldDefinition
```

## hasMany(\_:is:ofType:associatedWith:)

``` swift
public static func hasMany(_ key: CodingKey, is nullability: ModelFieldNullability = .required, ofType type: Model.Type, associatedWith associatedKey: CodingKey) -> ModelFieldDefinition
```

## hasOne(\_:is:ofType:associatedWith:)

``` swift
public static func hasOne(_ key: CodingKey, is nullability: ModelFieldNullability = .required, ofType type: Model.Type, associatedWith associatedKey: CodingKey) -> ModelFieldDefinition
```

## belongsTo(\_:is:ofType:associatedWith:targetName:)

``` swift
public static func belongsTo(_ key: CodingKey, is nullability: ModelFieldNullability = .required, ofType type: Model.Type, associatedWith associatedKey: CodingKey? = nil, targetName: String? = nil) -> ModelFieldDefinition
```
