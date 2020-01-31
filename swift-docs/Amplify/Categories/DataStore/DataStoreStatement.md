# DataStoreStatement

This protocol represents a statement that will be executed in a specific storage
implementations. Concrete types of this protocol may include SQL insert statements,
queries or GraphQL mutations.

``` swift
public protocol DataStoreStatement
```

## Required Properties

## modelType

The type of the `Model` associated with a particular statement

``` swift
var modelType: Model.Type
```

## stringValue

The actual string content of the statement (e.g. a SQL query or a GraphQL document)

``` swift
var stringValue: String
```

## variables

The variables associated with the statement

``` swift
var variables: Variables
```
