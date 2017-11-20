import UIKit

class NewsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var articles: [Article] = []
    let apiClient = NewsAPIClient(apiKey: "e80603556d9d4ab19a37522a7af3a5fc")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.apiClient.fetchArticles(completion: { (articles) in
            self.articles = articles
            self.tableView.reloadData()
        }, failure: { error in
            let alertController = UIAlertController(title: "Network Error", message: "Something went wrong. Please try closing and reopening the app to refresh.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            print(error)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article")!
        let article = self.articles[indexPath.row]
        cell.textLabel?.text = article.title
        return cell
    }

}

