//
//  TableViewController.swift
//  Musicians
//
//  Created by Артём on 29.08.2021.
//

import UIKit

let searchResultReuseIdentifier = "searchResult"

class SearchViewController: UITableViewController {
    private var tableData: [SpotifyArtist] = []
    
    lazy var resultSearchController: UISearchController = {
        let controller = UISearchController()
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.keyboardDismissMode = .onDrag
        
        tableView.register(ArtistTableViewCell.self,
                           forCellReuseIdentifier: searchResultReuseIdentifier)
        
        resultSearchController.searchBar.delegate = self
        resultSearchController.searchBar.scopeButtonTitles = ["Spotify", "Your Library"]
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = resultSearchController
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = tableData.count
        return numberOfRows
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: searchResultReuseIdentifier,
                                                 for: indexPath)
        
        guard let artistCell = cell as? ArtistTableViewCell else { return UITableViewCell() }

        let index = indexPath.row
        let artistModel = tableData[index]

        artistCell.nameText = artistModel.name
        let images = artistModel.images
        let img = images.sorted {
            $0.height < $1.height
        }.first
        artistCell.imageURL = URL(string: img?.url ?? "")

        return artistCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            tableData = []
            tableView.reloadData()
            return
        }
        
        let service = SpotifyWebService.shared
        service.searchArtist(keywords: searchText) { artists in
            DispatchQueue.main.async {
                self.tableData = artists
                self.tableView.reloadData()
            }
        }
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableData = []
        tableView.reloadData()
     }
}
