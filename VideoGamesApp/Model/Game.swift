//
//  File.swift
//  VideoGamesApp
//
//  Created by Zeynep Özcan on 23.04.2024.
//

import Foundation

struct Game: Decodable {
    
    let id: Int?
    let name, released: String?
    //let tba: Bool
    let backgroundImage: String?
    let rating: Double?
    var isFavorite: Bool = false
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, description
        case backgroundImage = "background_image"
        case rating
    }
    
    init(id: Int?, name: String?, released: String?, backgroundImage: String?, rating: Double?, isFavorite: Bool, description: String?) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.isFavorite = isFavorite
        self.description = description
    }
    
}

struct GameResponse: Decodable{
    var results = [Game?]()
}


enum VideoGameErr: Error{
    case dataNotFound
}



struct GameRequest{
    let resourceURL: URL
    
    init(){
        //let resourceString = "https://api.rawg.io/api/games?key=5023f2bfeaad418a8a1423a9ddf4587d"
        let resourceString = Constants.apiBaseURL + Constants.apiKey
        
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("error")
        }
        self.resourceURL = resourceURL
    }
    
    func getGameResponse(completion: @escaping(Result<GameResponse, VideoGameErr>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let jsonData = data else {
                // throw exp
                completion(.failure(.dataNotFound))
                //error?.localizedDescription
                return
            }
            do {
                let decoder = JSONDecoder()
                let games = try decoder.decode(GameResponse.self, from: jsonData)
                completion(.success(games))
            } catch {
                // throw exep
                completion(.failure(.dataNotFound))
                print(error)
            }
        }
        dataTask.resume()
    }
    
    
    
}






