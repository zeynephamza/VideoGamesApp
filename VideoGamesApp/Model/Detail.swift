//
//  Detail.swift
//  VideoGamesApp
//
//  Created by Zeynep Özcan on 28.04.2024.
//

import Foundation


struct Detail: Decodable {
    
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let metacritic: Int?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, description, metacritic
        case backgroundImage = "background_image"
    }
    
    init(id: Int?, name: String?, released: String?, backgroundImage: String?, metacritic: Int?, description: String?) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.metacritic = metacritic
        self.description = description
    }
    
}

enum DetailError: Error{
    case noDataAvailable
    case canNotProcessData
}


struct GameDetailRequest{
    let descriptionURL: URL
    var gameId: Int!
    
    init(gameid: Int){
        gameId = gameid
        let descriptionURLString: String = Constants.apiBaseURL + "/\(gameid)" + Constants.apiKey
        
        guard let descriptionURL = URL(string: descriptionURLString) else {
            fatalError("error")
        }
        self.descriptionURL = descriptionURL
        
    }
    
    func getDetailResponse(completion: @escaping(Result<Detail, DetailError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: descriptionURL) { data, response, error in
          
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let detail = try decoder.decode(Detail.self, from: jsonData)
                completion(.success(detail))
            } catch {
            
                completion(.failure(.canNotProcessData))
                print(error)
            }
        }
        dataTask.resume()
    }
}
