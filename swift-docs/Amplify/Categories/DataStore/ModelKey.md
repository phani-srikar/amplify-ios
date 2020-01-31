# ModelKey

The `ModelKey` protocol is used to decorate Swift standard's `CodingKey` enum with
query functions and operators that are used to build query conditions.

``` swift
public protocol ModelKey: CodingKey, CaseIterable, QueryFieldOperation
```

``` 
let post = Post.keys

Amplify.DataStore.query(Post.self, where: {
    post.title.contains("[Amplify]")
    .and(post.content.ne(nil))
})
```

**Using Operators:**

The operators on a `ModelKey` reference are defined so queries can also be written
with Swift operators as well:

``` 
let post = Post.keys

Amplify.DataStore.query(Post.self, where: {
    post.title ~= "[Amplify]" &&
    post.content != nil
})
```

## Inheritance

`CodingKey`, `CaseIterable`, [`QueryFieldOperation`](QueryFieldOperation)
