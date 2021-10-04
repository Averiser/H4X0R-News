//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by MyMacBook on 04.10.2021.
//

import Foundation

class NetworkManager: ObservableObject {
  
  @Published var posts = [Post]()
  
  func fetchData() {
    // Use optional binding to unwrap the URL that's created from the urlString.
    //1. Create  a URL
    if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
      
    // Create a new URLSession object with default configuration.
    //2. Create a URLSession
      
      let session = URLSession(configuration: .default)
      
    //3. Give the session a task.
      let task = session.dataTask(with: url) { (data, response, error) in
        if error == nil {
          let decoder = JSONDecoder()
          if let safeData = data {
            do {
             let results = try decoder.decode(Results.self, from: safeData)
              DispatchQueue.main.async {
                self.posts = results.hits
              }
            } catch {
              print(error)
            }
          }
        }
      }
      task.resume()
    }
  }
}
