//
//  NetworkConstants.swift
//  CureitMobile
//
//  Created by mac on 21/03/25.
//
import Foundation
import UIKit
import Alamofire
class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "http://ec2-13-60-8-94.eu-north-1.compute.amazonaws.com:3000/"
    
    func sendRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .post,
        requestBody: Encodable,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)/\(endpoint)"

        guard let bodyData = try? JSONEncoder().encode(requestBody) else {
            completion(.failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: NSError()))))
            return
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        AF.request(request)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func sendRawJSON<T: Decodable>(
        endpoint: String,
        rawJSON: [String: Any],
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)/\(endpoint)"
        
        guard let bodyData = try? JSONSerialization.data(withJSONObject: rawJSON) else {
            completion(.failure(AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: NSError()))))
            return
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        AF.request(request)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getWithQueryParameters<T: Decodable>(
        endpoint: String,
        parameters: [String: Any],
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)\(endpoint)"
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: ["Content-Type": "application/json"]
        )
        .validate()
        .responseData { response in

            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
            }
            
            // Continue with decoding
            if let data = response.data {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {

                    completion(.failure(error))
                }
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}

