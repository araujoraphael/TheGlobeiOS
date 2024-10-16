//
//  StoriesUseCase.swift
//  TheGlobeiOSTest
//
//  Created by Raphael Araújo on 2024-10-15.
//

import Foundation

protocol StoriesUseCaseProtocol {
    func fetchStories(completion: @escaping ((Result<StoriesModel, StoryFecthError>) -> Void))
}

enum StoryFecthError: Error {
    case error
    case invalidResponse
    case invalidData
    case invalidRequest
}

class StoriesUseCase: StoriesUseCaseProtocol {
    var session: URLSession
    
    private enum Constants: String {
        case url = "https://d2c9087llvttmg.cloudfront.net/trending_and_sophi/recommendations.json"
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchStories(completion: @escaping ((Result<StoriesModel, StoryFecthError>) -> Void)) {
        guard let url = URL(string: Constants.url.rawValue)
        else {
            completion(.failure(.invalidRequest))
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.error))
                return
            }
            
            guard let data = data
            else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let stories = try JSONDecoder().decode(StoriesModel.self, from: data)
                completion(.success(stories))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
