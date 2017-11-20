import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var forecastLabel: UILabel!
    
    let apiClient = WeatherAPIClient(apiKey: "bdef3d9ffc9e6f4f856eba90f8e94f6b")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.apiClient.fetchCurrentForecast(
            latitude: "37.8267",
            longitude: "-122.4233",
            completion: { (forecast: Forecast) in
                self.forecastLabel.text = forecast.summary
            },
            failure: { (error: Error) in
                print(error)
            }
        )
    }

}
