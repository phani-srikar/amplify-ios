# ModelDateFormatting

``` swift
public struct ModelDateFormatting
```

## Properties

## decodingStrategy

``` swift
let decodingStrategy: JSONDecoder.DateDecodingStrategy = {
        let strategy = JSONDecoder.DateDecodingStrategy.custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = iso8601WithFractionalSeconds.date(from: dateString) {
                return date
            }

            if let date = iso8601WithoutFractionalSeconds.date(from: dateString) {
                return date
            }

            return try container.decode(Date.self)
        }

        return strategy
    }()
```

## encodingStrategy

``` swift
let encodingStrategy: JSONEncoder.DateEncodingStrategy = {
        let strategy = JSONEncoder.DateEncodingStrategy.custom { date, encoder in
            let dateString = iso8601WithFractionalSeconds.string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(dateString)
        }
        return strategy
    }()
```
