//
//  RickMortyService.swift
//  Rick&MortyNoSB
//
//  Created by Bartu Gençcan on 4.02.2022.
//

import Alamofire

enum RickMortyServiceEndpoint: String {
    case BaseURL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BaseURL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickMortyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void)
}

struct RickMortyService: IRickMortyService {
    func fetchAllData(response: @escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndpoint.characterPath()).responseDecodable(of: RickMortyModel.self) { (model) in
            
            guard let data = model.value else {
                response(nil)
                return
            }
            
            response(data.results)
            
            
        }
    }
}
