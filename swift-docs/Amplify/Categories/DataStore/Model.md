# Model

All persistent models should conform to the Model protocol.

``` swift
public protocol Model: Codable
```

## Inheritance

`Codable`

## Conforming Types

[`AnyModel`](AnyModel), [`MutationEvent`](MutationEvent)

## Associated Types

## Identifier

Alias of Model identifier (i.e. primary key)

``` swift
Typealias(context: Optional("Model"), attributes: [], modifiers: [], keyword: "typealias", name: "Identifier", initializedType: Optional("String"), genericParameters: [], genericRequirements: [])
```

## Required Properties

## schema

A reference to the `ModelSchema` associated with this model.

``` swift
var schema: ModelSchema
```

## modelName

The name of the model, as registered in `ModelRegistry`.

``` swift
var modelName: String
```

## modelName

Convenience property to return the Type's `modelName`. Developers are strongly encouraged not to override the
instance property, as an implementation that returns a different value for the instance property will cause
undefined behavior.

``` swift
var modelName: String
```

## id

The Model identifier (aka primary key)

``` swift
var id: Identifier
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

## Required Methods

## eraseToAnyModel()

``` swift
func eraseToAnyModel() throws -> AnyModel
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

## eraseToAnyModel()

``` swift
func eraseToAnyModel() throws -> AnyModel
```

## Generically Constrained Members

### where Self: Codable

#### from(json:decoder:)

De-serialize a JSON string into an instance of the concrete type that conforms
to the `Model` protocol.

``` swift
public static func from(json: String, decoder: JSONDecoder? = nil) throws -> Self
```

##### Parameters

  - json: a valid JSON object as `String`
  - decoder: an optional JSONDecoder to use to decode the model. Defaults to `JSONDecoder()`, using a custom date formatter that decodes ISO8601 dates both with and without fractional seconds

##### Throws

`DecodingError.dataCorrupted` in case data is not a valid JSON or any other decoding specific error that `JSONDecoder.decode()` might throw.

##### Returns

an instance of the concrete type conforming to `Model`

#### from(dictionary:)

De-serialize a `Dictionary` into an instance of the concrete type that conforms
to the `Model` protocol.

``` swift
public static func from(dictionary: [String: Any]) throws -> Self
```

  - Parameter dictionary: containing keys and values that match the target type

##### Throws

`DecodingError.dataCorrupted` in case data is not a valid JSON or any other decoding specific error that `JSONDecoder.decode()` might throw.

##### Returns

an instance of the concrete type conforming to `Model`

#### toJSON(encoder:)

Converts the `Model` instance to a JSON object as `String`.

``` swift
public func toJSON(encoder: JSONEncoder? = nil) throws -> String
```

> Seealso: https://developer.apple.com/documentation/foundation/jsonencoder/2895034-encode

##### Parameters

  - encoder: an optional JSONEncoder to use to encode the model. Defaults to `JSONEncoder()`, using a custom date formatter that encodes ISO8601 dates with fractional seconds

##### Returns

the JSON representation of the `Model`
