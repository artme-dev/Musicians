//
//  JSONParameterEncoder.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import Foundation

class JSONParameterEncoder: ParameterEncoderType{
    var encodingTypeFieldValue = "application/json"
    
    func add(_ parameters: Parameters, to urlRequest: inout URLRequest) throws{
        let serialisedParameters = try JSONSerialization.data(withJSONObject: parameters,
                                                              options: .prettyPrinted)
        urlRequest.httpBody = serialisedParameters
        setContentTypeIfNil(for: &urlRequest)
    }
}
