//
//  Network.swift
//  SimpleNetworkCall
//
//  Created by Dion Dula on 1/12/21.
//
#if os(iOS) || os(tvOS)
import UIKit

public class Network: NSObject {
    public static let shared = Network()
    
    //Nil Body in to Get
    public func get<T : Decodable>(urlString: String,
                                   headerParameters: [String : String] = [:],
                                   completion: @escaping (Result<T, Error>) -> Void) {
        let nilInt: Int? = nil
        fetchData(body:nilInt,httpMethodType: HtppMethodType.GET, urlString: urlString,headerParameters: headerParameters,completion: completion)
    }
    
    public func post<T : Decodable, Y : Encodable>(body: Y? = nil,
                                                   urlString: String,
                                                   headerParameters: [String : String] = [:],
                                                   completion: @escaping (Result<T, Error>) -> Void) {
        fetchData(body: body, httpMethodType: HtppMethodType.POST, urlString: urlString, headerParameters: headerParameters,completion: completion)
    }
    //Nil Body in to Delete
    public func delete<T : Decodable>(urlString: String,
                                      headerParameters: [String : String] = [:],
                                      completion: @escaping (Result<T, Error>) -> Void) {
        let nilInt: Int? = nil
        fetchData(body: nilInt, httpMethodType: HtppMethodType.DELETE, urlString: urlString, headerParameters: headerParameters,completion: completion)
    }
    
    private func fetchData<T : Decodable, Y : Encodable>(body: Y? = nil,
                                                         httpMethodType: HtppMethodType,
                                                         urlString: String,
                                                         headerParameters: [String : String] = [:],
                                                         completion: @escaping (Result<T, Error>) -> Void) {
        
        let url = URL(string: urlString)!
        
        var request = getRequest(body: body, url: url,headerParameters: headerParameters)
        request.httpMethod = httpMethodType.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            guard let data = data else {
                return
            }
            
            do{
                let returnResult = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.sync {
                    completion(.success(returnResult))
                }
            }catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    private func getRequest<T: Encodable>(body: T?,url: URL,headerParameters: [String : String] = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        for headerParameter in headerParameters {
            request.addValue(headerParameter.value, forHTTPHeaderField: headerParameter.key)
        }
        
        if let body = body{
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            } catch  {
                print(error)
            }
            
            
        }
        
        return request
    }
    
    private func getQueryItems(queryStringParamters: [String: String] ,urlString: String) -> URL {
        var utlTempString = urlString
        for item in queryStringParamters {
            utlTempString = urlString + "/" + item.value
        }
        
        let url = URL(string: utlTempString)!
        return url
    }
    
    
    public enum HtppMethodType: String {
        case POST = "POST"
        case GET = "GET"
        case DELETE = "DELETE"
    }
    
    
    public override init() {}
}

#endif
