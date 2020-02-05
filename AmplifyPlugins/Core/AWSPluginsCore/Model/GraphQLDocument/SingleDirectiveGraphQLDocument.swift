//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation

public enum GraphQLOperationType: String {
    case mutation
    case query
    case subscription
}

public typealias GraphQLParameterName = String

/// Represents a single directive GraphQL document. Concrete types that conform to this protocol must
/// define a valid GraphQL operation document.
///
/// This type aims to provide a representation of a simple GraphQL document with its components that can be decorated
/// and later serialized into query document and variables for a request to a GraphQL service.
/// Therefore, documents represented by concrete implementations provide a single GraphQL
/// operation based on a defined `Model.Type`.
public protocol SingleDirectiveGraphQLDocument {
    /// The `GraphQLOperationType` a concrete implementation represents the
    /// GraphQL operation of the document
    var operationType: GraphQLOperationType { get set }

    /// The name of the document. This is useful to inspect the response, since it will
    /// contain the name of the document as the key to the response value.
    var name: String { get set }

    /// Input parameters and its values on the GraphQL document
    var inputs: [GraphQLParameterName: GraphQLDocumentInput] { get set }

    /// The selection set of the document, used to specify the response data returned by the service.
    var selectionSet: SelectionSet? { get set }

    /// Simple constructor to be implemented by the concrete types, used by the `copy` method.
    init(operationType: GraphQLOperationType,
         name: String,
         inputs: [GraphQLParameterName: GraphQLDocumentInput],
         selectionSet: SelectionSet?)
}

// Provides default implementation
extension SingleDirectiveGraphQLDocument {

    /// Method to create a deep copy of the document, useful for `SingleDirectiveGraphQLDocumentDecorator` decorators
    /// when decorating a document and returning a new document.
    public func copy(operationType: GraphQLOperationType? = nil,
                     name: String? = nil,
                     inputs: [GraphQLParameterName: GraphQLDocumentInput]? = nil,
                     selectionSet: SelectionSet? = nil) -> Self {

        return Self.init(operationType: operationType ?? self.operationType,
                         name: name ?? self.name,
                         inputs: inputs ?? self.inputs,
                         selectionSet: selectionSet ?? self.selectionSet)
    }

    /// Returns an empty `variables` object when there are no `inputs` required, Otherwise, consolidates the `inputs`
    /// into a single object that can be used for the GraphQL request.
    public var variables: [String: Any] {
        var variables = [String: Any]()
        inputs.forEach { input in
            switch input.value.value {
            case .object(let values):
                variables.updateValue(values, forKey: input.key)
            case .value(let value):
                variables.updateValue(value, forKey: input.key)
            }

        }

        return variables
    }

    /// Provides default construction of the graphQL document based on the components of the document.
    public var stringValue: String {

        var selectionSetString = ""
        if let selectionSet = selectionSet {
            selectionSetString = selectionSet.fields.map { $0.toString() }.joined(separator: "\n    ")
        }

        if !inputs.isEmpty {
            let sortedInputs = inputs.sorted { $0.0 < $1.0 }
            let inputTypes = sortedInputs.map { "$\($0.key): \($0.value.type)" }.joined(separator: ", ")
            let inputParameters = sortedInputs.map { "\($0.key): $\($0.key)" }.joined(separator: ", ")

            return """
            \(operationType.rawValue) \(name.pascalCased())(\(inputTypes)) {
              \(name)(\(inputParameters)) {
                \(selectionSetString)
              }
            }
            """
        }

        return """
        \(operationType.rawValue) \(name.pascalCased()) {
          \(name) {
            \(selectionSetString)
          }
        }
        """
    }
}
