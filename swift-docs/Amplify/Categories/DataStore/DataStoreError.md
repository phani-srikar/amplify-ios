# DataStoreError

``` swift
public enum DataStoreError
```

## Inheritance

`Error`, `AmplifyError`

## Enumeration Cases

## api

``` swift
case api(: AmplifyError)
```

## configuration

``` swift
case configuration(: ErrorDescription, : RecoverySuggestion, : Error? = nil)
```

## conflict

``` swift
case conflict(: DataStoreSyncConflict)
```

## decodingError

``` swift
case decodingError(: ErrorDescription, : RecoverySuggestion)
```

## internalOperation

``` swift
case internalOperation(: ErrorDescription, : RecoverySuggestion, : Error? = nil)
```

## invalidDatabase

``` swift
case invalidDatabase(path: String, : Error? = nil)
```

## invalidModelName

``` swift
case invalidModelName(: String)
```

## invalidOperation

``` swift
case invalidOperation(causedBy: Error? = nil)
```

## nonUniqueResult

``` swift
case nonUniqueResult(model: String, count: Int)
```

## sync

``` swift
case sync(: ErrorDescription, : RecoverySuggestion, : Error? = nil)
```

## unknown

``` swift
case unknown(: ErrorDescription, : RecoverySuggestion, : Error? = nil)
```

## Initializers

## init(error:)

``` swift
init(error: Error)
```

## Properties

## errorDescription

``` swift
var errorDescription: ErrorDescription
```

## recoverySuggestion

``` swift
var recoverySuggestion: RecoverySuggestion
```

## underlyingError

``` swift
var underlyingError: Error?
```
