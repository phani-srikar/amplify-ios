# ModelRegistry

``` swift
public struct ModelRegistry
```

## Properties

## models

``` swift
var models: [Model.Type]
```

## hasSyncableModels

``` swift
var hasSyncableModels: Bool
```

## Methods

## register(modelType:)

``` swift
public static func register(modelType: Model.Type)
```

## modelType(from:)

``` swift
public static func modelType(from name: String) -> Model.Type?
```

## decode(modelName:from:jsonDecoder:)

``` swift
public static func decode(modelName: String, from jsonString: String, jsonDecoder: JSONDecoder? = nil) throws -> Model
```
