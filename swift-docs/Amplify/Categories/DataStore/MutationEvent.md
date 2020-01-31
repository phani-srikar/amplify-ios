# MutationEvent

``` swift
public struct MutationEvent: Model
```

## Inheritance

[`Model`](Model)

## Nested Types

  - MutationEvent.CodingKeys
  - MutationEvent.MutationType

## Enumeration Cases

## id

``` swift
case id
```

## modelId

``` swift
case modelId
```

## modelName

``` swift
case modelName
```

## json

``` swift
case json
```

## mutationType

``` swift
case mutationType
```

## createdAt

``` swift
case createdAt
```

## version

``` swift
case version
```

## inProcess

``` swift
case inProcess
```

## create

``` swift
case create
```

## update

``` swift
case update
```

## delete

``` swift
case delete
```

## Initializers

## init(id:modelId:modelName:json:mutationType:createdAt:version:inProcess:)

``` swift
public init(id: Identifier = UUID().uuidString, modelId: String, modelName: String, json: String, mutationType: MutationType, createdAt: Date = Date(), version: Int? = nil, inProcess: Bool = false)
```

## init(model:mutationType:version:)

``` swift
public init<M: Model>(model: M, mutationType: MutationType, version: Int? = nil) throws
```

## init(untypedModel:mutationType:version:)

``` swift
public init(untypedModel model: Model, mutationType: MutationType, version: Int? = nil) throws
```

## Properties

## id

``` swift
let id: Identifier
```

## modelId

``` swift
let modelId: Identifier
```

## modelName

``` swift
var modelName: String
```

## json

``` swift
var json: String
```

## mutationType

``` swift
var mutationType: String
```

## createdAt

``` swift
var createdAt: Date
```

## version

``` swift
var version: Int?
```

## inProcess

``` swift
var inProcess: Bool
```

## keys

``` swift
let keys = CodingKeys.self
```

## schema

``` swift
let schema = defineSchema { definition in
        let mutation = MutationEvent.keys

        definition.pluralName = "MutationEvents"
        definition.attributes(.isSystem)

        definition.fields(
            .id(),
            .field(mutation.modelId, is: .required, ofType: .string),
            .field(mutation.modelName, is: .required, ofType: .string),
            .field(mutation.json, is: .required, ofType: .string),
            .field(mutation.mutationType, is: .required, ofType: .string),
            .field(mutation.createdAt, is: .required, ofType: .dateTime),
            .field(mutation.version, is: .optional, ofType: .int),
            .field(mutation.inProcess, is: .optional, ofType: .bool)
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

## Methods

## decodeModel()

``` swift
public func decodeModel() throws -> Model
```

## decodeModel(as:)

Decodes the model instance from the mutation event.

``` swift
public func decodeModel<M: Model>(as modelType: M.Type) throws -> M
```

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
