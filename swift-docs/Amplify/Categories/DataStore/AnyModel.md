# AnyModel

``` swift
public struct AnyModel: Model
```

## Inheritance

[`Model`](Model)

## Nested Types

  - AnyModel.CodingKeys

## Enumeration Cases

## id

``` swift
case id
```

## instance

``` swift
case instance
```

## modelName

``` swift
case modelName
```

## Initializers

## init(\_:)

``` swift
public init(_ instance: Model)
```

## init(from:)

``` swift
init(from decoder: Decoder) throws
```

## Properties

## id

``` swift
let id: Identifier
```

## instance

``` swift
let instance: Model
```

## modelName

Overrides the convenience property with the model name of the instance, so that AnyModel can still be decoded
into the instances's original type.

``` swift
let modelName: String
```

## keys

``` swift
let keys = CodingKeys.self
```

## schema

``` swift
let schema = defineSchema { definition in
        let anyModel = AnyModel.keys

        definition.attributes(.isSystem)

        definition.fields(
            .id(),
            .field(anyModel.instance, is: .required, ofType: .string),
            .field(anyModel.modelName, is: .required, ofType: .string)
        )
    }
```

## modelName

``` swift
var modelName: String
```

## modelName

``` swift
var modelName: String
```

## schema

``` swift
var schema: ModelSchema
```

## schema

``` swift
var schema: ModelSchema
```

## schema

``` swift
var schema: ModelSchema
```

## Methods

## defineSchema(name:attributes:define:)

Utility function that enables a DSL-like `ModelSchema` definition. Instead of building
objects individually, developers can use this to create the schema with a more fluid
programming model.

``` swift
public static func defineSchema(name: String? = nil, attributes: ModelAttribute, define: (inout ModelSchemaDefinition) -> Void) -> ModelSchema
```

  - Example:

``` swift
static let schema = defineSchema { model in
    model.fields(
        .field(name: "title", is: .required, ofType: .string)
    )
}
```

  - Parameters
      - name: the name of the Model. Defaults to the class name
      - attributes: model attributes (aka "directives" or "annotations")
      - define: the closure used to define the model attributes and fields

### Returns

a valid `ModelSchema` instance

## encode(to:)

``` swift
func encode(to encoder: Encoder) throws
```
