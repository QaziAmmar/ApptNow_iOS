//
//  File.swift
//  
//
//  Created by Qazi Mudassar on 11/02/2023.
//

import Foundation

public enum HttpMethod {
    case get([URLQueryItem])
    case put([String:Any]?)
    case post([String:Any]?)
    case delete([String:Any]?)
    case head

    public var name: String {
        switch self {
        case .get: return "GET"
        case .put: return "PUT"
        case .post: return "POST"
        case .delete: return "DELETE"
        case .head: return "HEAD"
        }
    }
}
