# DataStoreSyncConflict

Information about a conflict that occurred attempting to sync a local model with a remote model

``` swift
public struct DataStoreSyncConflict
```

## Properties

## localModel

``` swift
let localModel: Model
```

## remoteModel

``` swift
let remoteModel: Model
```

## errors

``` swift
let errors: [GraphQLError]?
```

## mutationType

``` swift
let mutationType: GraphQLMutationType
```
