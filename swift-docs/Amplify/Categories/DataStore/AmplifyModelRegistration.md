# AmplifyModelRegistration

Protocol that defines a contract between the consumer and the DataStore plugin.
All models have to be registered and have an associated `version`.

``` swift
public protocol AmplifyModelRegistration
```

## Required Properties

## version

The version associated with the current schema.

``` swift
var version: String
```

## Required Methods

## registerModels(registry:)

Function called during plugin initialization. Implementations must
register all the available models here.

``` swift
func registerModels(registry: ModelRegistry.Type)
```
