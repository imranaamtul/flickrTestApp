//
//  Model.swift
//  flickrTestAPP
//
//  Created by amtul imrana on 20/11/22.
//
import Foundation

struct FlickrApi: Codable {
    let title: String?
    let link: String?
    let welcomeDescription: String?
    let modified: String?
    let generator: String?
    let items: [Item]
}

struct Item: Codable {
    let title: String?
    let link: String?
    let media: Media?
    let dateTaken: String?
    let itemDescription: String?
    let published: String?
    let author, authorID, tags: String?
}

struct Media: Codable {
    let m: String?
}
class API {
    static let shared = API()
    
    func fetchResults(searchText: String, completion: @escaping ([Item]) -> Void){
        
        let endPoint = "https://api.flickr.com/services/feeds/photos_public.gne?tags=\(searchText)&tagmode=any&format=json&nojsoncallback=1"
        
        guard let url = URL(string: endPoint) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            do {
                let decodedData = try JSONDecoder().decode(FlickrApi.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData.items)                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
