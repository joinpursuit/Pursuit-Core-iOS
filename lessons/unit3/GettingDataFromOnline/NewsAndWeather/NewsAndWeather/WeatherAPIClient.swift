import Foundation

// The sub-section of the API response we care about
struct Forecast: Codable {
    let summary: String // i.e. "Partly Cloudy"
}

// directly model what comes back from the API
struct ForecastAPIResponse: Codable {
    let currently: Forecast
}

class WeatherAPIClient {
    
    let apiKey: String
    let networkHelper = NetworkHelper()
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchCurrentForecast(
        latitude: String,
        longitude: String,
        completion: @escaping ((Forecast) -> Void),
        failure: @escaping ((Error) -> Void)
    ) {
        
        // 1. assemble a URL request
        let url = URL(string: "https://api.darksky.net/forecast/" + self.apiKey + "/" + latitude + "," + longitude)!
        let urlRequest = URLRequest(url: url)

        let myCompletion = { (data: Data) in
            // 3. in that NetworkHelper's completion handler, parse the JSON into our Forecast struct.
            do {
                let jsonDecoder = JSONDecoder()
                let apiResponse = try jsonDecoder.decode(ForecastAPIResponse.self, from: data)
                // 4. call our own completion handler with the forecast
                completion(apiResponse.currently)
            } catch {
                failure(error)
            }
        }
        
        let myFailure = { (error: Error) in
            failure(error)
        }
        
        // 2. call our NetworkHelper to make the HTTP request
        self.networkHelper.perform(
            urlRequest: urlRequest,
            completion: myCompletion,
            failure: myFailure
        )
        
    }
    
}
