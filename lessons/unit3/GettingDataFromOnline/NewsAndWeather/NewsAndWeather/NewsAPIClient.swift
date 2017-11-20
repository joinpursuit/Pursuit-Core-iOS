import Foundation

struct Article: Codable {
    let title: String
    let url: String
}

struct HeadlinesAPIResponse: Codable {
    let status: String
    let articles: [Article]
}

class NewsAPIClient {
    
    let apiKey: String
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private let networkHelper = NetworkHelper()
    
    func fetchArticles(completion: @escaping (([Article]) -> Void), failure: @escaping ((Error) -> Void)) {
        var components = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        components.queryItems = [
            URLQueryItem(name: "sources", value: "bbc-news"),
            URLQueryItem(name: "apiKey", value: self.apiKey),
        ]
        let url = components.url!
        let urlRequest = URLRequest(url: url)
        self.networkHelper.perform(urlRequest: urlRequest, completion: { data in
            let jsonDecoder = JSONDecoder()
            do {
                let headlines = try jsonDecoder.decode(HeadlinesAPIResponse.self, from: data)
                completion(headlines.articles)
            } catch {
                failure(error)
            }
        }, failure: failure)
    }
    
}
