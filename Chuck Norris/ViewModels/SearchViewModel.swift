import Foundation
import Alamofire

class SearchViewModel {
    
    var category = Dynamic("")
    var joke = Dynamic("")
    
    func fetchJoke(by search: String) {
        performRequest(with: "https://api.chucknorris.io/jokes/search?query=\(search.replacingOccurrences(of: " ", with: "+"))")
    }
    
    func performRequest(with url: String) {
        if NetworkReachabilityManager()!.isReachable {
            Alamofire.request(url).response { response in
                if let result = response.response {
                    if result.statusCode == 200 {
                        if let safeData = response.data {
                            if let search = self.parseJSON(safeData) {
                                if search.total != 0 {
                                    let index = Int.random(in: 0...search.total)
                                    self.category.value = search.result[index].categories.first?.capitalized ?? ""
                                    self.joke.value = self.substring(text: search.result[index].value)
                                } else {
                                    self.category.value = ""
                                    self.joke.value = "No results were found for this query."
                                }
                            }
                        }
                    }
                }
            }
        } else {
            self.category.value = "You are offline!"
            self.joke.value = "Please, check your internet connection and try again."
        }
        
    }
    
    func parseJSON(_ data: Data) -> Search? {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(Search.self, from: data)
        } catch {
            return nil
        }
    }
    
    func substring(text: String) -> String {
        if text.count > 230 {
            return "\(text.prefix(230))..."
        } else {
            return text
        }
    }
}
