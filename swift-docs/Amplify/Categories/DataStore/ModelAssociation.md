# ModelAssociation

Defines the association type between two models. The type of association is
important when defining how to store and query them. Each association have
its own rules depending on the storage mechanism.

``` swift
public enum ModelAssociation
```

The semantics of a association can be defined as:

**Many-to-One/One-to-Many**

The most common association type. It defines an array/collection on one side and a
single `Model` reference on the other. The side with the `Model` (marked as `belongsTo`)
holds a reference to the other side's `id` (aka "foreign key").

Example:

``` 
struct Post: Model {
  let id: Model.Identifier

  // hasMany(associatedWith: Comment.keys.post)
  let comments: [Comment]
}

struct Comment: Model {
  let id: Model.Identifier

  // belongsTo
  let post: Post
}
```

**One-to-One**

This type of association is not too common since in these scenarios data can usually
be normalized and stored under the same `Model`. However, there are use-cases where
one-to-one can be useful, specially when one side of the association is optional.

Example:

``` 
struct Person: Model {
  // hasOne(associatedWith: License.keys.person)
  let license: License?
}

struct License: Model {
  // belongsTo
  let person: Person
}
```

**Many-to-Many**

These associations mean that an instance of one `Model` can relate to many other
instances of another `Model` and vice-versa. Many-to-Many is achieved by combining
`hasMany` and `belongsTo` with an intermediate `Model` that is responsible for
holding a reference to the keys of both related models.

``` 
struct Book: Model {
  // hasMany(associatedWith: BookAuthor.keys.book)
  let auhors: [BookAuthor]
}

struct Author: Model {
  // hasMany(associatedWith: BookAuthor.keys.author)
  let books: [BookAuthor]
}

struct BookAuthor: Model {
  // belongsTo
  let book: Book

  // belongsTo
  let author: Author
}
```

## Enumeration Cases

## hasMany

``` swift
case hasMany(associatedWith: CodingKey?)
```

## hasOne

``` swift
case hasOne(associatedWith: CodingKey?)
```

## belongsTo

``` swift
case belongsTo(associatedWith: CodingKey?, targetName: String?)
```

## Properties

## belongsTo

``` swift
let belongsTo: ModelAssociation = .belongsTo(associatedWith: nil, targetName: nil)
```

## Methods

## belongsTo(targetName:)

``` swift
public static func belongsTo(targetName: String? = nil) -> ModelAssociation
```
