import Foundation
import Alamofire

class JokeViewModel {
    
    var category = Dynamic("")
    var joke = Dynamic("")
    
    func fetchJoke() {
        performRequest(with: "https://api.chucknorris.io/jokes/random")
    }
    
    func performRequest(with url: String) {
        if NetworkReachabilityManager()!.isReachable {
            Alamofire.request(url).response { response in
                if let result = response.response {
                    if result.statusCode == 200 {
                        if let safeData = response.data {
                            if let joke = self.parseJSON(safeData) {
                                self.category.value = joke.categories.first?.capitalized ?? ""
                                self.joke.value = self.substring(text: joke.value)
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
    
    func parseJSON(_ data: Data) -> Joke? {
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(Joke.self, from: data)
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
