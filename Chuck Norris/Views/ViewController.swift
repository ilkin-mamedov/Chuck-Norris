import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var jokeLabel: UILabel!
    
    private let jokeViewModel = JokeViewModel()
    private let searchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        jokeViewModel.fetchJoke()
        
        bindJokeViewModel()
        bindSearchViewModel()
    }
    
    @IBAction func getJokePressed(_ sender: UIButton) {
        if let search = searchBar.text {
            if search.isEmpty {
                jokeViewModel.fetchJoke()
            } else {
                searchViewModel.fetchJoke(by: search)
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

// - MARK: UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let search = searchBar.text {
            searchViewModel.fetchJoke(by: search)
        }
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
}
