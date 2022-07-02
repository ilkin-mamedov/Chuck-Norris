import UIKit

class ViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var jokeLabel: UILabel!
    
    private let jokeViewModel = JokeViewModel()
    private let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chuck Norris"
        
        searchController.searchBar.tintColor = UIColor(named: "AccentColor")
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.searchController = searchController
        
        jokeViewModel.fetchJoke()
        
        bindJokeViewModel()
        bindSearchViewModel()
    }
    
    @IBAction func getJokePressed(_ sender: UIButton) {
        if let text = searchController.searchBar.text {
            if text.isEmpty {
                jokeViewModel.fetchJoke()
            } else {
                searchViewModel.fetchJoke(by: text)
            }
        }
    }
    
    private func bindJokeViewModel() {
        jokeViewModel.category.bind { value in
            DispatchQueue.main.async {
                self.categoryLabel.text = value
            }
        }
        
        jokeViewModel.joke.bind { value in
            DispatchQueue.main.async {
                self.jokeLabel.text = value
            }
        }
    }
    
    private func bindSearchViewModel() {
        searchViewModel.category.bind { value in
            DispatchQueue.main.async {
                self.categoryLabel.text = value
            }
        }
        
        searchViewModel.joke.bind { value in
            DispatchQueue.main.async {
                self.jokeLabel.text = value
            }
        }
    }
}

// - MARK: UISearchControllerDelegate, UISearchResultsUpdating

extension ViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchViewModel.fetchJoke(by: text)
    }
}
