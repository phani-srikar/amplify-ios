# ModelField

``` swift
public struct ModelField
```

## Properties

## name

``` swift
let name: String
```

## type

``` swift
let type: String
```

## isRequired

``` swift
let isRequired: Bool
```

## isArray

``` swift
let isArray: Bool
```

## attributes

``` swift
let attributes: [ModelFieldAttribute]
```

## association

``` swift
let association: ModelAssociation?
```

## isPrimaryKey

``` swift
var isPrimaryKey: Bool
```

## typeDefinition

``` swift
var typeDefinition: ModelFieldType
```

## hasAssociation

``` swift
var hasAssociation: Bool
```

## associatedModel

If the field represents an association returns the `Model.Type`.

``` swift
var associatedModel: Model.Type?
```

> Seealso: `ModelFieldType`

> Seealso: `ModelFieldAssociation`

## requiredAssociatedModel

This calls `associatedModel` but enforces that the field must represent an association.
In case the field type is not a `Model.Type` is calls `preconditionFailure`. Consumers
should fix their models in order to recover from it, since associations are only
possible between two `Model.Type`.

``` swift
var requiredAssociatedModel: Model.Type
```

> Note: as a maintainer, make sure you use this computed property only when context allows (i.e. the field is a valid relationship, such as foreign keys).

## isAssociationOwner

``` swift
var isAssociationOwner: Bool
```

## associatedField

``` swift
var associatedField: ModelField?
```

## isOneToOne

``` swift
var isOneToOne: Bool
```

## isOneToMany

``` swift
var isOneToMany: Bool
```

## isManyToOne

``` swift
var isManyToOne: Bool
```
