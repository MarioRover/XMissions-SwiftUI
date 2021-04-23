//
//  APIService.swift
//  XMissions
//
//  Created by Hossein Akbari on 2/3/1400 AP.
//

import Foundation

class APIService {
    
    static func getCompanyInfo(completion: @escaping (APIResponse?) -> ()) {
        Network.shared.apollo.fetch(query: CompanyInfoQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                if let companyObject = graphQLResult.data?.jsonObject {
                    
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: companyObject) else {
                        completion(nil)
                        fatalError("Error Seriallize Response")
                    }
                    
                    guard let response = try? JSONDecoder().decode(APIResponse.self, from: jsonData) else {
                        completion(nil)
                        fatalError("Error Decode Response")
                    }
                    
                    completion(response)
                    
                } else {
                    print("Error in find object")
                    completion(nil)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
}
