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
    
    public func fetchData<T : Decodable, Y : Encodable>(body: Y? = nil,
                                  httpMethodType: HtppMethodType,
                                  queryStringParamters: [String: String]?,
                                  urlString: String,
                                  completion: @escaping (Result<T, Error>) -> Void) {
        
        var url = URL(string: urlString)!
        
        if let queryStringParamters = queryStringParamters {
            url = getQueryItems(queryStringParamters: queryStringParamters, urlString: urlString)
        }
        
        var request = getRequest(body: body, url: url)
        request.httpMethod = httpMethodType.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            guard let data = data else {
                return
            }
            
            do{
                let loginResult = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.sync {
                    completion(.success(loginResult))
                }
            }catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    private func getRequest<T: Encodable>(body: T?,url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
        case Post = "POST"
        case Get = "GET"
        case Delete = "DELETE"
    }
    
    
    public override init() {}
}

#endif
