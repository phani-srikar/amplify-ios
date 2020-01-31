# DataStoreCategory

``` swift
final public class DataStoreCategory: Category
```

## Inheritance

`Category`, `CategoryConfigurable`, [`DataStoreBaseBehavior`](DataStoreBaseBehavior), [`DataStoreSubscribeBehavior`](DataStoreSubscribeBehavior), `Resettable`

## Properties

## categoryType

Always .dataStore

``` swift
let categoryType: CategoryType = .dataStore
```

## Methods

## add(plugin:)

Adds `plugin` to the list of Plugins that implement functionality for this category.

``` swift
public func add(plugin: DataStoreCategoryPlugin) throws
```

  - Parameter plugin: The Plugin to add

## getPlugin(for:)

Returns the added plugin with the specified `key` property.

``` swift
public func getPlugin(for key: PluginKey) throws -> DataStoreCategoryPlugin
```

  - Parameter key: The PluginKey (String) of the plugin to retrieve

### Returns

The wrapped plugin

## removePlugin(for:)

Removes the plugin registered for `key` from the list of Plugins that implement functionality for this category.
If no plugin has been added for `key`, no action is taken, making this method safe to call multiple times.

``` swift
public func removePlugin(for key: PluginKey)
```

  - Parameter key: The key used to `add` the plugin

## save(\_:completion:)

``` swift
public func save<M: Model>(_ model: M, completion: @escaping DataStoreCallback<M>)
```

## query(\_:byId:completion:)

``` swift
public func query<M: Model>(_ modelType: M.Type, byId id: String, completion: DataStoreCallback<M?>)
```

## query(\_:where:completion:)

``` swift
public func query<M: Model>(_ modelType: M.Type, where predicate: QueryPredicateFactory? = nil, completion: DataStoreCallback<[M]>)
```

## delete(\_:completion:)

``` swift
public func delete<M: Model>(_ model: M, completion: @escaping DataStoreCallback<Void>)
```

## delete(\_:withId:completion:)

``` swift
public func delete<M: Model>(_ modelType: M.Type, withId id: String, completion: @escaping DataStoreCallback<Void>)
```

## reset(onComplete:)

``` swift
public func reset(onComplete: @escaping BasicClosure)
```

## publisher(for:)

``` swift
@available(iOS 13.0, *) public func publisher<M: Model>(for modelType: M.Type) -> AnyPublisher<MutationEvent, DataStoreError>
```
