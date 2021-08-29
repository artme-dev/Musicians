//
//  ParameterEncoder.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation

protocol ParameterEncoderType {
    var encodingTypeFieldValue: String { get }
    func add(_ parameters: Parameters, to urlRequest: inout URLRequest) throws
    func setContentTypeIfNil(for urlRequest: inout URLRequest)
}

extension ParameterEncoderType {
    func setContentTypeIfNil(for urlRequest: inout URLRequest) {
        let contentTypeFieldName = "Content-type"
        if urlRequest.value(forHTTPHeaderField: contentTypeFieldName) == nil {
            urlRequest.setValue(encodingTypeFieldValue, forHTTPHeaderField: contentTypeFieldName)
        }
    }
}
