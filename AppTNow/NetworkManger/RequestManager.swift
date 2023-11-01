//
//  File.swift
//  
//
//  Created by Qazi Mudassar on 11/02/2023.
//

import Foundation

public protocol RequestManager{
    func sendApiRequest<T: Decodable>(request: Request, responseModel: T.Type) async -> Result<T, RequestError>
}
extension RequestManager {
    public  func sendApiRequest<T: Decodable>(request: Request, responseModel: T.Type) async -> Result<T, RequestError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request.urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            debugPrint(String(data: data, encoding: String.Encoding.utf8) ?? "")
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return .success(decodedResponse)
                    
                } catch let error {
                    debugPrint(error)
                    debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
                    return .failure(.decode)
                }
                
            case 400,401:
                let error = try parseJSON(from: data)
                debugPrint(error)
                debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
                return .failure(.unauthorized(reason: error.message))
                
            default:
                debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            debugPrint("❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌ ❌")
            return .failure(.unknown)
        }
    }
    
    private func parseJSON(from data: Data) throws -> GenricModel {
        do {
            return try JSONDecoder().decode(GenricModel.self, from: data)
            /// force logout here if neened
        } catch let error {
            print(error)
            
        }
        return GenricModel()
    }
    
}
